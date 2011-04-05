require 'active_record'

module ArAttributeSerializer
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    # You need a blob field to store serialized data, and a list of attributes
    # and their types. For example, with field called 'data':
    # attribute_serializer :data, :name, :bio
    def attribute_serializer(field, *attributes)
      
      serialize field, Hash
      
      attributes.each do |attribute|
        class_eval %Q^
          def #{attribute}
            self.#{field} ||= { }
            self.#{field}[:#{attribute}]
          end
          def #{attribute}=(value)
            self.#{field} ||= { }
            self.#{field}[:#{attribute}] = value
          end
        ^
      end
    end
  end
end

ActiveRecord::Base.send :include, ArAttributeSerializer