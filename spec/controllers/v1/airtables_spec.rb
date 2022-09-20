require 'rails_helper'
require "spec_helper"

RSpec.describe V1::AirtablesController, type: :request do
  describe "GET copy" do
    it "base" do
      get '/api/v1/copy'
      parsed_body = JSON.parse(response.body)

      file = File.read('./public/copy.json')
      data_hash = JSON.parse(file)

      expect(parsed_body).to include_json(data_hash)
    end
  end

  describe "GET copy_with_key" do
    it "copy/greeting" do
      get '/api/v1/copy/greeting', params: { name: "John", app: "Bridge" }

      parsed_body = JSON.parse(response.body)

      expect(parsed_body).to include_json(
                               { value: "Hi John, welcome to Bridge!" }
                             )
    end

    it "copy/greetingVIP" do
      get '/api/v1/copy/greetingVIP', params: { name: "Elon", app: "Bridge" }

      parsed_body = JSON.parse(response.body)

      expect(parsed_body).to include_json(
                               {value: "Hi Elon, welcome to Bridge! You're on the VIP plan."}
                             )

    end

    it "copy/intro.created_at" do
      get '/api/v1/copy/intro.created_at', params: { created_at: 1603814215 }

      parsed_body = JSON.parse(response.body)

      expect(parsed_body).to include_json(
                               {value: "Intro created on Tue Oct 27 03:56:55 PM"}
                             )

    end


    it "copy/intro.updated_at" do
      get '/api/v1/copy/intro.updated_at', params: { updated_at: 1604063144 }

      parsed_body = JSON.parse(response.body)

      expect(parsed_body).to include_json(
                               {value: "Intro updated on Fri Oct 30 01:05:44 PM" }
                             )

    end

  end

end
