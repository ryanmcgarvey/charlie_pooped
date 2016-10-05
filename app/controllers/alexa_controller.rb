class AlexaController < ActionController::API
  def create
    activity = params["request"]["intent"]["slots"]["Activity"]
    modifier = params["request"]["intent"]["slots"]["Modifier"]
    time     = params["request"]["intent"]["slots"]["Time"]

    activity = activity["value"] if activity
    modifier = modifier["value"] if modifier
    time = Time.parse(time["value"]) if time

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
