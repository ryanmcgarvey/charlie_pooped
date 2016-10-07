class Event < ApplicationRecord
  extend Enumerize
  ACTIVITY_TYPES = %i|peed pooped ate slept woke_up|
  MODIFIER_TYPES = %i|inside crate|
  enumerize :activity, in: ACTIVITY_TYPES
  enumerize :modifier, in: MODIFIER_TYPES

  scope :last_few, -> { order(occurred_at: :desc).limit(20) }
  validates :occurred_at, presence: true
  validates :activity, presence: true

  def self.event_data
    data = []
    index = 1
    self.all.group_by(&:activity).each do |activity, events|
      data << {name: activity.text, data: events.map {|event| [event.occurred_at.to_formatted_s(:iso8601), index] } }
      index +=1
    end

    data
  end

  def self.most_recent
    recent = {}
    recent['pooped']
  end

end
