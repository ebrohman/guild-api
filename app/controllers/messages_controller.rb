# frozen_string_literal: true

class MessagesController < ApplicationController
  def recent
    render json: Message.recent.where(recipient: recipient)
  end

  def recent_from_sender
    render json: Message.recent.where(recipient: recipient,
                                      sender: sender)
  end

  def create
    Message.create(create_message_params).then do |message|
      if message.valid?
        render json: message, status: :created
      else
        render json: message.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def recipient
    @recipient ||= User.find(_params["recipient_id"])
  end

  def sender
    @sender ||= User.find(_params["sender_id"])
  end

  def create_message_params
    {
      sender: sender,
      recipient: recipient,
      body: _params["body"]
    }
  end

  def _params
    params.permit(:recipient_id, :sender_id, :body).to_h
  end
end
