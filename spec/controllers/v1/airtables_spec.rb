require 'rails_helper'

RSpec.describe "airtable" do

  let(:contact_options_instance) { ContactOptions.new }

  describe '#perform' do

  end

  describe '#contact_ranking_calculation' do
    it 'test gmail' do
      email = "foobar@gmail.com"
      intros_offered = { free: 8, vip: 0 }
      result = contact_options_instance.contact_ranking_calculation(email, intros_offered)
      expect(result).to eq 2
    end

    it 'test hotmail' do
      email = "foobar@hotmail.com"
      intros_offered = { free: 3, vip: 0 }
      result = contact_options_instance.contact_ranking_calculation(email, intros_offered)
      expect(result).to eq 2
    end
  end

end