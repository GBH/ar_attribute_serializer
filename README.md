AR Attribute Serializer
=======================

**ar_attribute_serializer** is a simple method that allows you to serialize random ActiveRecord Model attributes.

Installation
------------
Define the following in your Gemfile and run `bundle install`
    
    gem 'ar_attribute_serializer'
    
Usage
-----
Define a field that is going to be used for storing serialized data and a list of attributes:
    
    class MyModel < ActiveRecord::Base
      attribute_serializer :serialized_data, :apple, :orange, :banana
    end
    
Then you can use those serialized attributes:
    
    >> model = MyModel.new(:apple => 'red')
    >> model.apple
    => red
    >> model.orange = 'orange'
    >> model.banana = 'yellow'
    >> model.serialized_data
    => {:apple => 'red', :orange => 'orange', :banana => 'yellow' }
    
Copyright
=========
(c) 2011 Oleg Khabarov, released under the MIT license
