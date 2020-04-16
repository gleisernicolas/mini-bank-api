require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { create(:account) }
  
  context 'validations' do
    it { should validate_uniqueness_of(:cpf).case_insensitive }
  end
end
