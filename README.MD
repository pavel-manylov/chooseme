Chooseme. Index chooser for your rails powered application
==========================================================
Sometimes database do what you expect, sometimes not. If you have small application with small piece of data in your
database, you will not have so much problems if your MySQL (or any other db) choose not relevant index.

But sometimes you handle really *big database* and database mistake may cost you money and nervous. It's not good idea
to hard-writing indexes in your sql queries, but what you say if index will be selected by automated method?

How it works now
-----------------
First of all, behind the scene, Chooseme fetch all indexes from your db/schema.rb file.

###Example query to Chooseme:

     Chooseme::Chooser.choose!(SomeModel, [:list,:of,:used,:columns]) #-> ix_with_list_of_used_columns_if_possible_or_nil

Yes, at this time there are not much magic and you must pass used columns. By the way, in complex queries with bunch of joins
it's the only way. Maybe, some time later, magic will be here, but now... :)

###Example of real usage

    used_columns=[:name, :founded_at]
    ix=Chooseme::Chooser.choose!(City, used_columns)
    cities=City.where(:name=>"Moscow", :founded_at=>1147)
    cities=cities.from("#{City.table_name} USE INDEX (#{ix})") unless ix.nil?

Installation?
-------------
Well, i think you know without my explanation, but...

    gem 'chooseme', :git=>'git://github.com/rap-kasta/chooseme.git'  #add this line to your Gemfile

TODO
-----

* Tests

* Docs

* Magic

Author
-------
Pavel Manylov aka [r-k] / rap_kasta on github