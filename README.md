# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* PostgreSql

brew services start postgresql

* Commands:

docker-compose down

docker-compose up --build

* Validation

docker-compose logs web

* Migration:

docker-compose run web rake db:create
docker-compose run web rake db:migrate

or

docker-compose run web bundle exec rake db:migrate

or
docker-compose run web bundle exec rails db:schema:dump

* Test:

Without Docker
bundle exec rspec

With Docker
docker-compose -f docker-compose.test.yml up --build

docker-compose run web /bin/bash

bundle exec rspec

or

docker-compose run web bundle exec rspec


* Bundler:

docker-compose run web bundle install

* Down and Clean

docker-compose down -v --rmi all

docker-compose rm -f -v

* bundler install
docker-compose run web bundle install
