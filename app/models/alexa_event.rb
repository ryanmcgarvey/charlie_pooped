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
    normalize!
    occurred_at = time || DateTime.now
    event = Event.new(activity: full_activity, occurred_at: occurred_at)
    event.save
  end

  def response_text
    if event.valid?
      if good_boy
        GOOD_RESPONSES.sample
      else
        BAD_RESPONSES.sample
      end
    else
      "I was unable to process activity #{activity} or modifier #{modifier}"
    end
  end

  private

  def normalize!
    @activity =
      case activity
      when /wet/, /be/, /pe/i, /we/
        "peed"
      when /shit/, /crap/, /dump/, /po/i
        "pooped"
      when /sleep/, /slept/, /sle/i
        "slept"
      when /woke/, /got up/
        "woke_up"
      when /ate/, /fed/i, /8/, /eight/
        "ate"
      else
        activity
      end

    @modifier =
      case modifier
      when /inside/, /carpet/, /house/
        @good_boy = false
        "inside"
      when /crate/, /cage/, /bed/
        @good_boy = false
        "crate"
      else
        modifier
      end
  end

end

