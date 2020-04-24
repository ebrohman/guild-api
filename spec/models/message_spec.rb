# frozen_string_literal: true

require "rails_helper"

RSpec.describe Message do
  include ActiveSupport::Testing::TimeHelpers

  let(:recipient) { users(:bob) }
  let(:sender)    { users(:jennifer) }

  let(:message) do
    Message.create(body: "Hey Jennifer!",
                   sender: sender,
                   recipient: recipient)
  end

  describe "#sender" do
    subject { message.sender }

    it { should eq users(:jennifer) }
  end

  describe "#recipient" do
    subject { message.recipient }

    it { should eq users(:bob) }
  end

  describe ".recent" do
    subject(:recent) { described_class.recent }

    context "when there are messages outside of the default date range" do
      out_of_scope_message = nil

      before do
        travel_to(2.months.ago) do
          out_of_scope_message =
            Message.create(body: "Hi", sender: sender, recipient: recipient)
        end
      end

      it "should include messages created in the last month" do
        expect(recent).not_to include out_of_scope_message
      end
    end

    context "when there are more than 100 recent messages" do
      before do
        101.times do
          Message.create(body: "Hi", sender: sender, recipient: recipient)
        end
      end

      it "should limit the colleciton size to 100 items" do
        expect(recent.size).to eq 100
      end
    end
  end
end
