require 'rails_helper'
require "spec_helper"

RSpec.describe V1::AirtablesController do
  describe "GET copy" do
    it "basic" do
      get :copy
      parsed_body = JSON.parse(response.body)

      file = File.read('./public/copy.json')
      data_hash = JSON.parse(file)

      expect(parsed_body).to include_json(data_hash)
    end
  end

  describe "GET bye" do
    it "basic" do
      get :bye

    end

  end

end
