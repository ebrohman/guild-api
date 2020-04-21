# frozen_string_literal: true

require "rails_helper"

RSpec.describe Message do
  let(:message) do
    Message.create(body: "Hey Jennifer!",
                   sender: users(:bob),
                   recipient: users(:jennifer))
  end

  describe "#sender" do
    subject(:sender) { message.sender }

    it { should eq users(:bob) }
  end

  describe "#recipient" do
    subject(:recipient) { message.recipient }

    it { should eq users(:jennifer) }
  end
end
