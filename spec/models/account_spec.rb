require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { create(:account) }
  
  context 'validations' do
    it { should validate_uniqueness_of(:cpf).case_insensitive }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:user) }
  end

  context 'relations' do
    it { should belong_to(:user)}
  end
end
