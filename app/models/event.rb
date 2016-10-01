class Event < ApplicationRecord
  extend Enumerize
  TYPES = %i|peed pooped ate peed_inside pooped_inside slept woke_up peed_in_crate pooped_in_create|
  enumerize :activity, in: TYPES
end
