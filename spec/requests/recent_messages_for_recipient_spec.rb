# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET - /messages/:recipient_id/recent" do
  include ActiveSupport::Testing::TimeHelpers

  let(:request) { get(recent_messages_path(recipient.id)); @response }

  subject(:response) { request }

  describe "getting all the recent messages for a recipient" do
    subject(:parsed_response) { JSON.load(response.body) }

    context "when the recipient has no recent messages" do
      let(:recipient) { users(:bob) }

      it { should be_empty }
    end

    context "when the recipient has some recent messages" do
      let(:recipient) { users(:jennifer) }

      it { should_not be_empty }
    end

    context "when there are more than 100 recent messages" do
      let(:recipient) { users(:bob) }
      let(:sender)    { users(:jennifer) }

      before do
        101.times do
          Message.create(body: "Hi", sender: sender, recipient: recipient)
        end
      end

      it "limits the response json to 100 messages" do
        expect(parsed_response.length).to eq 100
      end

      it "orders the messages by most recent first" do
        recent_item = parsed_response.first["created_at"]
        older_item  = parsed_response.last["created_at"]
        expect(Time.parse(recent_item) > Time.parse(older_item)).to be true
      end
    end

    context "when there are messages that are out of the date window" do
      let(:recipient) { users(:bob) }
      let(:sender)    { users(:jennifer) }

      before do
        travel_to(2.months.ago) do
          Message.create(body: "Hi", sender: sender, recipient: recipient)
        end
      end

      it "should not return the messages" do
        expect(parsed_response).to be_empty
      end
    end

    context "when the recipient cannot be found" do
      let(:recipient) { OpenStruct.new(id: "Not-Found")}

      it "should return a 404 status not found" do
        expect(response).to be_not_found
      end
    end
  end
end
