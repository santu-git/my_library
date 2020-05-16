# README

This is a blueprint of rails application to practice testing in rails using Minitest.

This repo has 3 branches:

* master - Rails application with scaffold of Author resource. Which can be used to implement by own.

* test-cases - Consist only test cases.

* full-app - Implementation of logic to pass test cases.

## How to use

* Clone master branch
```
git clone git@github.com:santu-git/my_library.git
```
* Create Database (Change config/database.yml if required)
```
rails db:create
```

* Migrate Database
```
rails db:migrate
```

* Populate some data for development environment
```
rails db:seed
```

## To check test cases
```
git checkout test-cases
```

## To check out full implementation
```
git checkout full-app
```
