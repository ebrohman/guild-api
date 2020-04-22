# frozen_string_literal: true

class MessagesController < ApplicationController
  def recent
    render json: message_relation.where(recipient: recipient)
  end

  def recent_from_sender
    render json: message_relation.where(recipient: recipient,
                                        sender: sender)
  end

  private

  def recipient
    @recipient ||= User.find(_params["recipient_id"])
  end

  def sender
    @sender ||= User.find(_params["sender_id"])
  end

  def _params
    params.permit(:recipient_id, :sender_id).to_h
  end

  def message_relation
    Message.where(created_at: (Time.current - 1.month)..Time.current)
           .limit(100)
           .order(created_at: :desc)
  end
end
