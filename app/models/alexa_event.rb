class AlexaEvent

  GOOD_RESPONSES = ["Good boy!", "Good pup!", "Way to go!"]
  BAD_RESPONSES = ["Oh no!", "OUTSIDE!", "Bad boy!"]

  attr_reader :activity, :modifier, :time, :good_boy
  def initialize(activity:,modifier: nil,time: nil)
    @activity = activity
    @modifier = modifier
    @time = time
    @good_boy = true
  end

  def create!
    full_activity = modified_activity || activity
    occurred_at = time || DateTime.now
    Event.create!(activity: full_activity, occurred_at: occurred_at)
  end

  def response_text
    if good_boy
      GOOD_RESPONSES.sample
    else
      BAD_RESPONSES.sample
    end
  end

  def modified_activity
    case modifier
    when /inside/
      @good_boy = false
      case activity
      when "peed", "pooped"
        "#{activity}_inside"
      end
    when /crate/, /cage/
      @good_boy = false
      case activity
      when "peed", "pooped"
        "#{activity}_in_crate"
      end
    end
  end
end

