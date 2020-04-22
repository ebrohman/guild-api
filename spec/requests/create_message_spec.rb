# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST - /messages" do
  let(:request) { post(messages_path, params: params); @response }

  subject(:response) { request }

  describe "creating a new message" do
    let(:params) do
      {
        recipient_id: recipient.id,
        sender_id: sender.id,
        body: body
      }
    end

    let(:body) { "Hey Sally" }

    context "with a specified sender and recipient" do
      let(:sender)    { users(:bob) }
      let(:recipient) { users(:jennifer) }

      it { should be_created }

      it "should create a new message from the sender to the recipient" do
        expect { request }
          .to change { Message.where(sender: sender, recipient: recipient).count }
          .by(1)
      end
    end

    context "when the sender cannot be found" do
      let(:sender)    { OpenStruct.new(id: "not-found") }
      let(:recipient) { users(:bob) }

      it { should be_not_found }
    end

    context "when the recipient cannot be found" do
      let(:sender)    { users(:jennifer) }
      let(:recipient) { OpenStruct.new(id: "not-here") }

      it { should be_not_found }
    end

    context "when no message body is specified" do
      let(:sender)    { users(:bob) }
      let(:recipient) { users(:jennifer) }
      let(:body) { nil }

      it { should be_unprocessable }

      it "should not create a new message" do
        expect { request }
          .not_to change { Message.count }
      end

      it "should return a helpful error message" do
        expect(JSON.load(response.body))
          .to eq("body" => ["can't be blank"])
      end
    end
  end
end
