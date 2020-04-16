ActiveRecord::Base.logger = Logger.new($stdout)
abort 'It seems the database already was seeded before.' if User.exists?

User.create!(name: 'First User',
            email: 'first_user@email.com',
            cpf: '01010101',
            birth_date: 1.year.ago.to_date,
            gender: 'Female',
            city: 'First City',
            state: 'First State',
            country: 'First Country',
            referral_code: '001')