require 'test/unit'
require 'ar_attribute_serializer'
require 'sqlite3'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
$stdout_orig = $stdout
$stdout = StringIO.new

class Model  < ActiveRecord::Base
  attribute_serializer :data, :attr_1, :attr_2
end

class LetMeInTest < Test::Unit::TestCase
  
  def setup
    ActiveRecord::Base.logger
    ActiveRecord::Schema.define(:version => 1) do
      create_table :models do |t|
        t.column :attr_0, :string
        t.column :data,   :text
      end
    end
  end
  
  def teardown
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end
  
  def test_attribute_serializer
    model = Model.new
    assert model.respond_to?(:attr_0)
    assert model.respond_to?(:data)
    assert model.respond_to?(:attr_1)
    assert model.respond_to?(:attr_2)
    assert_equal nil, model.attr_1
    assert_equal nil, model.attr_2
    
    model = Model.new(
      :attr_0 => 'data_0',
      :attr_1 => 'data_1',
      :attr_2 => 'data_2'
    )
    assert_equal ({ :attr_1 => 'data_1', :attr_2 => 'data_2' }), model.data
    assert_equal 'data_0', model.attr_0
    assert_equal 'data_1', model.attr_1
    assert_equal 'data_2', model.attr_2
    
    model.save!
    
    model.attr_1 = 'data_updated'
    assert_equal 'data_updated', model.attr_1
    assert_equal ({ :attr_1 => 'data_updated', :attr_2 => 'data_2' }), model.data
  end
  
end