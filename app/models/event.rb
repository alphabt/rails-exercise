class Event < ActiveRecord::Base
  has_one :location, :dependent => :destroy
  has_many :attendees, ->{ where(["created_at > ?", Time.now - 7.day]).order("id DESC") }, :dependent => :destroy
  has_many :event_groupships
  has_many :groups, :through => :event_groupships
  belongs_to :category

  accepts_nested_attributes_for :location, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :name

  delegate :name, :to => :category, :prefix => true, :allow_nil => true
end
