require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }
  
  context 'validations' do
    it { should validate_uniqueness_of(:token) }
    it { should validate_presence_of(:token) }

    it { should validate_presence_of(:name) }
  end

  context 'relations' do
    it { should have_many(:accounts) }
  end
end
