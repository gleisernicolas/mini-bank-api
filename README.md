# Mini Bank API

This project was made as a code challenge, have fun reading it :)

## Getting Started

This project is made using ruby `ruby 2.7.0` and `rails 6.0.2` and the latest version of postgresql, at this moment `10.12`

### Prerequisites

Before you run this project you will need:

- `Ruby 2.7.0`, the best way is using [RVM](https://rvm.io/rvm/install)
- [postgresql](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04-pt)
- Nodejs, the best way is using [NVM](https://github.com/nvm-sh/nvm)
- [Yarn](https://classic.yarnpkg.com/pt-BR/docs/install/#debian-stable)

### Installing

After you have all the requirements installed, you must follow the instuctions bellow:

- `bundle install`
- `export MINI_BANK_API_DATABASE_PASSWORD="password_set_during_postgresql_installation"`
- `export RUBYOPT='-W:no-deprecated -W:no-experimental'` *this step is to hide experimental deprecated warnings from `ruby 2.7.0`*
- `bundle exec rails db:setup`

Now you can run the specs by doing `bundle exec rspec` or initialize our API and make requests using `bundle exec rails s` using the included [postman collection](/mini_bank_api.postman_collection.json) (ids and tokens must be updated with the data from the created resources)


## Contributing

Please read [code_of_conduct.md](/code_of_conduct.md) for details on our code of conduct, and the process for submitting pull requests to us.


## Authors

* **Nicolas Gleiser** - *Initial work* - [Nicolas Gleiser](https://github.com/gleisernicolas)

See also the list of [contributors](https://github.com/gleisernicolas/mini-bank-api/contributors) who participated in this project.


## Reasoning behinde choices

The API architecture was done trying to make this a RESTful API and simple to maintain, I used the gem symmetric-encryption to encrypt the sensitive data because were simple and almost transparent when using active record, I used shoulda-matchers to simplify activerecord validation specs, the authentication was done without using any external gem because I don't think it was needed and was made in two forms, the first one file based, using a simple yaml file that has all apps that can use the Users api to create the users that can create the account, the second method is using a client created token to authenticate and define the user responsible for the account
