class AddModifierToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :modifier, :string

    Event.all.each do |event|
      activity = case event.activity
      when /peed/
        'peed'
      when /pooped/
        'pooped'
      else
        event.activity
      end

      modifier = case event.activity
      when /inside/
        'inside'
      when /crate/
        'crate'
      else
        nil
      end

      event.activity = activity
      event.modifier = modifier
      event.save!
    end

  end
end
