# README

### Ruby version
3.2.2

### Rails version
7.0.8.1

### Setup

```
bundle install
bundle exec rake db:create db:migrate db:seed

# exampleコピー後、設定は各自で書き換えてください
cp config/setting_example.yml config/setting.yml

bundle exec rails s

```
