# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET - /users" do
  let(:request) { get(users_path); @response }

  subject(:response) { request }

  describe "Getting a list of users" do
    context "when making a GET request to /users" do
      it "should return a successful response" do
        expect(response).to be_successful
      end

      it "should return a json payload representing the users" do
        expect(JSON.parse(response.body)).to include(
          hash_including(
            "name" => "Jennifer",
            "email" => "Jennifer@guild.com"
          ),
          hash_including(
            "name" => "Bob",
            "email" => "bob@guild.com"
          ),
          hash_including(
            "name" => "Kim",
            "email" => "kim@guild.com"
          )
        )
      end

      # Actual response
      # Did not have time to set up a matcher
      # to make a direct assertion against the json,
      # so I picked out a few important fields
      # [
      #     [0] {
      #                 "id" => 93202360,
      #               "name" => "Jennifer",
      #              "email" => "Jennifer@guild.com",
      #           "settings" => {},
      #         "created_at" => "2020-04-22T00:35:57.087Z",
      #         "updated_at" => "2020-04-22T00:35:57.087Z"
      #     },
      #     [1] {
      #                 "id" => 902541635,
      #               "name" => "Bob",
      #              "email" => "bob@guild.com",
      #           "settings" => {},
      #         "created_at" => "2020-04-22T00:35:57.087Z",
      #         "updated_at" => "2020-04-22T00:35:57.087Z"
      #     },
      #     [2] {
      #                 "id" => 1023357144,
      #               "name" => "Kim",
      #              "email" => "kim@guild.com",
      #           "settings" => {},
      #         "created_at" => "2020-04-22T00:35:57.087Z",
      #         "updated_at" => "2020-04-22T00:35:57.087Z"
      #     }
      # ]
    end
  end
end
