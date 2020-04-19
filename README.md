# Mini Bank API

This project was made as a code challenge, have fun reading it:) 

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
- `rails db:setup`

Now you can run the specs by doing `bundle exec rspec` or initialize our API and make requests usgin `bundle exec rails s`


## Contributing

Please read [code_of_conduct.md](/code_of_conduct.md) for details on our code of conduct, and the process for submitting pull requests to us.


## Authors

* **Nicolas Gleiser** - *Initial work* - [PurpleBooth](https://github.com/gleisernicolas)

See also the list of [contributors](https://github.com/gleisernicolas/mini-bank-api/contributors) who participated in this project.