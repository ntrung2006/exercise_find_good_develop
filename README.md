# Welcome

This repository is Exercies after join Workshop.

## Required software

* Ruby 2.5.0
* Ruby on Rails 5.1.5
* Postgresql 9.3 or later

## Local development
### Required software

The following software should be installed (by brew on Mac)
* yarn

### Getting Started

1. Install packages
    ```
    $ bundle install --path vendor/bundle
    ```
    ```
    $ yarn install
    ```

2. Database setup
    ```
    $ bin/rails db:setup
    ```

3. Start local servers
    ```
    (Execute the following commands on different tabs)
    $ bin/rails server
    ```

4. You have to sign up first from http://localhost:3000/signup to login.

5. If you want to create test data, see below.

### Run Specs (Tests)

```
$ bundle exec rspec
```

### Setup test data

```
$ bin/rails dev:generate_data

# You can specify arguments
$ bin/rails 'dev:generate_data[100,10,20]'

-> A test user is created with the following email and password (test@example.com / password).
```

### Overcommit

Setup overcommit for git hooks
```
$ bundle exec overcommit --install
$ bundle exec overcommit --sign
```

In case you have to ignore hooks
```
SKIP=HOOK COMMAND

e.g. SKIP=RuboCop git commit ...
e.g. OVERCOMMIT_DISABLE=1 git commit ...
```