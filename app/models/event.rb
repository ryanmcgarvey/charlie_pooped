class Event < ApplicationRecord
  extend Enumerize
  TYPES = %i|peed pooped ate slept peed_inside pooped_inside|

  enumerize :activity, in: TYPES
end
