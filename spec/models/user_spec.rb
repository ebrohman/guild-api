# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  describe "#outbound_messages" do
    subject { user.outbound_messages }

    context "when a user has outbound messages" do
      let(:user) { users(:bob) }

      it { should_not be_empty }
    end

    context "when a user has no outbound messages" do
      let(:user) { users(:jennifer) }

      it { should be_empty }
    end
  end

  describe "#inbound_messages" do
    subject { user.inbound_messages }

    context "when the user has inbound messages" do
      let(:user) { users(:jennifer) }

      it { should_not be_empty }
    end

    context "when the user has no inbound messages" do
      let(:user) { users(:bob) }

      it { should be_empty }
    end
  end
end
