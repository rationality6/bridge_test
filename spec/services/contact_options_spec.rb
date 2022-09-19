require 'rails_helper'

RSpec.describe "contact_options_spec" do
  let(:contact_options_instance) { ContactOptions.new }

  describe '#perform' do
    @contects = eval(IO.read('./public/contects_data.rb'))
    result = contact_options_instance.perform
    expect(result)
  end

  describe '#contact_ranking_calculation' do
    it 'default' do
      email = "aj@smith.com"
      intros_offered = { free: 3, vip: 0 }
      result = contact_options_instance.contact_ranking_calculation(email, intros_offered)
      expect(result).to eq 3
    end

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

    it 'EACH intro already offered' do
      email = "foobar@hotmail.com"
      intros_offered = { free: 3, vip: 2 }
      result = contact_options_instance.contact_ranking_calculation(email, intros_offered)
      expect(result).to eq 1
    end
  end

end



