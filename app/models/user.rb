# frozen_string_literal: true

class User < ApplicationRecord
  has_many :outbound_messages, class_name: "Message", foreign_key: :sender_id
  has_many :inbound_messages, class_name: "Message", foreign_key: :recipient_id
end
