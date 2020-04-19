require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { create(:account) }
  
  context 'validations' do
    it { should validate_uniqueness_of(:cpf).case_insensitive }
    it { should validate_uniqueness_of(:my_referral_code) }
    it { should validate_inclusion_of(:status).in_array(['pending', 'completed'])}
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:user) }
    it { should validate_length_of(:name).is_at_least(2).allow_nil }
    it { should validate_length_of(:gender).is_at_least(2).allow_nil}
    it { should validate_length_of(:city).is_at_least(2).allow_nil}
    it { should validate_length_of(:state).is_at_least(2).allow_nil}
    it { should validate_length_of(:country).is_at_least(2).allow_nil}
    it { should validate_length_of(:referral_code).is_at_least(8).allow_nil}
    it { should validate_length_of(:my_referral_code).is_at_least(8).allow_nil}
    it { should allow_value('email@email.com').for(:email)}
    it { should_not allow_value('invalid_email').for(:email)}

    it 'birth_date_format' do
      expect(build(:account, birth_date: '00-00-0000')).to be_invalid
      expect(build(:account, birth_date: '16-03-1993')).to be_valid
      expect(build(:account, birth_date: '1993-03-16')).to be_valid
      expect(build(:account, birth_date: '16/03/1993')).to be_valid
      expect(build(:account, birth_date: nil)).to be_valid
    end
  end

  context 'relations' do
    it { should belong_to(:user)}
  end

  describe '#complete_account' do
    context 'a account without missing attributes' do
      let(:complete_attributes) do
        {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          birth_date: 20.years.ago.to_date,
          gender: Faker::Gender.type,
          city: Faker::Address.city,
          state: Faker::Address.state,
          country: Faker::Address.country,
          referral_code:  SecureRandom.alphanumeric(8),
          cpf: Faker::IDNumber.brazilian_citizen_number,
          user_id: create(:user).id
        }
      end

      it 'should have status completed' do
        account = Account.create!(complete_attributes)

        account.complete_account

        expect(account.status).to eq('completed')
      end

      it 'should create a referral code for said account' do
        account = Account.create!(complete_attributes)

        account.complete_account

        expect(account.my_referral_code).not_to be_nil
      end
    end

    context 'with incomplete attributes' do
      it 'does not change the default status' do
        account = Account.create!(cpf: Faker::IDNumber.brazilian_citizen_number,
                                  user_id: create(:user).id)
        
        account.complete_account

        expect(account.status).to eq('pending')
      end

      it 'does not create referral code' do
        account = Account.create!(cpf: Faker::IDNumber.brazilian_citizen_number,
                                  user_id: create(:user).id)
        
        account.complete_account

        expect(account.my_referral_code).to be_nil
      end
    end
  end
end
