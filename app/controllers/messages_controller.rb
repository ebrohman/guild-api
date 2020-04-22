# frozen_string_literal: true

class MessagesController < ApplicationController
  def recent
    recents = Message.where(recipient: recipient,
                            created_at: (Time.current - 1.month)..Time.current)
                     .limit(100)

    render json: recents
  end

  private

  def recipient
    @recipient ||= User.find(_params["recipient_id"])
  end

  def _params
    params.permit(:recipient_id).to_h
  end
end
