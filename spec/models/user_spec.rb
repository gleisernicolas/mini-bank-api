require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }

  context 'validations' do
    it { expect(user).to validate_uniqueness_of(:cpf) }
  end
end
