require "chooseme/version"

module Chooseme
  class Indexes
    class <<self
      def create_table(*args)
        #feel free to do nothing
      end

      def add_index(table_name, columns, options={})
        @available_indexes[table_name]={} if @available_indexes[table_name].blank?
        @available_indexes[table_name][options[:name]]=columns
      end

      def set_indexes
        @available_indexes={}
        eval File.read("#{Rails.root}/db/schema.rb").gsub(/^ActiveRecord::Schema.define(.+?)$/,"").gsub(/end(\s*)\Z/,"")
      end

      #@return  Hash
      def indexes
        set_indexes unless defined?(@available_indexes)
        @available_indexes
      end
      alias_method :indices, :indexes
    end
  end

  class Chooser
    class <<self
      #@param   model_or_table_name  [String, ActiveRecord::Base, ActiveRecord::Relation]
      #@param   used_columns         [Array]
      #@return  [String,NilClass]
      def choose(model_or_table_name, used_columns)
        table=model_or_table_name.kind_of?(String) ? model_or_table_name : model_or_table_name.table_name
        nil if Indexes.indexes[table].blank?

        comparison={}
        Indexes.indexes[table].each do |name, columns|
          current_comparison=[false]*columns.size
          used_columns.each{|c| if columns.index(c.to_s) then current_comparison[columns.index(c.to_s)]=true end}

          true_count=current_comparison.inject(0){|_,v|_+(v ? 1 : 0)}
          r=true
          current_comparison.each.with_index do |v,i|
            break if i>=true_count
            (r=false; break) unless v
          end
          comparison[name]=true_count if r
        end

        comparison.blank? ? nil : comparison.max{|l,r| l[1]<=>r[1] }.first
      end
      alias_method :choose!, :choose
    end
  end
end
