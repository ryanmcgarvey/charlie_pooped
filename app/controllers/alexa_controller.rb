class AlexaController < ActionController::API
  def create
    activity = params["request"]["intent"]["slots"]["Activity"]["value"]
    modifier = params["request"]["intent"]["slots"]["Modifier"]["value"]
    time     = params["request"]["intent"]["slots"]["Time"]["value"]

    time = Time.parse("#{time} EDT").utc.to_datetime if time

    event = AlexaEvent.new(activity: activity, modifier: modifier, time: time)
    event.create!

    resp =
      {
        "version": params["version"],
        "response": {
          "outputSpeech": {
            "type": "PlainText",
            "text": event.response_text,
          },
          "shouldEndSession": true
        }
    }

    render json: resp
  end
end
