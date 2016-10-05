class Event < ApplicationRecord
  extend Enumerize
  TYPES = %i|peed pooped ate peed_inside pooped_inside slept woke_up peed_in_crate pooped_in_crate|
  enumerize :activity, in: TYPES

  scope :last_few, -> { order(occurred_at: :desc).limit(20) }

  def self.event_data
    data = []
    index = 1
    self.all.group_by(&:activity).each do |activity, events|
      data << {name: activity.text, data: events.map {|event| [event.occurred_at.to_formatted_s(:iso8601), index] } }
      index +=1
    end

    data
  end

end
