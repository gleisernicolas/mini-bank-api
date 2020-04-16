require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }
  
  context 'validations' do
    it { should validate_uniqueness_of(:cpf).case_insensitive }
  end
end
