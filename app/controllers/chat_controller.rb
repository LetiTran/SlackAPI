class ChatController < ApplicationController
  def index
    @channels = SlackApiWrapper.list_channels
  end

  def new
    @channel = params[:channel]
  end

  def create
    channel = params[:channel]
    message = params[:message]

    if SlackApiWrapper.send_message(channel, message)
      flash[:success] = "Message Sent!"
    else
      fals[:alert] = "Error Sending"
    end
    redirect_to chat_new_path(channel)
  end
end
