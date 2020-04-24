# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  scope :recent, lambda {
                   where(created_at: (Time.current - 1.month)..Time.current)
                     .limit(100)
                     .order(created_at: :desc)
                 }

  validates :body, presence: true
end
