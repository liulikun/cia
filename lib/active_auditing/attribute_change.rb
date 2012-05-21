module ActiveAuditing
  class AttributeChange < ActiveRecord::Base
    self.table_name = "audit_attribute_changes"

    belongs_to :event, :foreign_key => "audit_event_id"
    belongs_to :source, :polymorphic => true

    validates_presence_of :event, :attribute_name, :source

    if ActiveRecord::VERSION::MAJOR > 2
      scope :previous, :order => "id desc"
    else
      named_scope :previous, :order => "id desc"
    end

    delegate :created_at, :to => :event
  end
end
