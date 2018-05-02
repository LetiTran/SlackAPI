require 'httparty'

class SlackApiWrapper
  # Your code here!

  URL = "https://slack.com/api/"
  TOKEN = ENV["SLACK_TOKEN"]

  def self.list_channels
    response = HTTParty.get("#{URL}channels.list?token=#{TOKEN}")

    channel_list = []

    if response["channels"]
      response.parsed_response["channels"].each do |channel|
        channel_list << Channel.new(channel["name"], channel["id"])
      end
    end
    return channel_list
  end
  
  def self.send_message(channel, message)
    message_url ="#{URL}chat.postMessage"
    response = HTTParty.post(message_url,
      body: {
        # required:
        "token" => TOKEN,
        "channel" => channel,
        "text" => message,
        # optionals:
        "username" => "BeeBot",
        "icon_emoji" => ":bee:",
        "as-user" => "false"
      },
      :headers => {'Content-Type' => 'application/x-www-form-urlencoded'}
    )
    return response.success?
  end
end
