# BookClub


BookClub is a Mod2 paired project at [Turing School of Software & Design](https://turing.io/) where 2 students with 10 weeks of experience in software development build a new rails app for tracking stats on a collection of books & allows users to create reviews..



[![Screen-Shot-2019-02-12-at-8-32-39-AM.png](https://i.postimg.cc/D0PRvVzd/Screen-Shot-2019-02-12-at-8-32-39-AM.png)](https://postimg.cc/K340fHBR)
(Welcome Page)


[![Screen-Shot-2019-02-12-at-8-33-02-AM.png](https://i.postimg.cc/3rtBTJ8f/Screen-Shot-2019-02-12-at-8-33-02-AM.png)](https://postimg.cc/xqbHGQbL)
(Book Show Page with Statistics)


### BookClub - Database Schema:

[![Book-Club-Skeema-Updated.png](https://i.postimg.cc/05XBCCwN/Book-Club-Skeema-Updated.png)](https://postimg.cc/3Wp18m9M)


### Active BookClub - app in Production:

https://justinsbookclub.herokuapp.com/

### BookClub - Github Repository:
https://github.com/justinmauldin7/BookClub


### BookClub - Project Management Board:

We used Waffle.io to manage the development of this app.  Checkout our board [here](https://waffle.io/jpclark6/BookClub).


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

#### Prerequisites:

* Install Ruby (Version 2.4.1)
* Install Rails (Version 5.2.2)
* Heroku Account - (Create free account [here](https://signup.heroku.com/) if you don't have on already.)


#### Installing:

To run this application locally, clone this [repo](https://github.com/bendelonlee/brownfield-of-dreams) and follow the steps below:

1) Install gems:
```
$ bundle
```

2) Create, migrate, & seed database:
```
$ rake db:{create,migrate,seed}
```

3) Start your rails server:
```
$ rails s
```


4) Open browser and navigate to:

```
localhost:3000
```


## Running the RSpec Test Suite

BookClub has a full RSpec suite of feature and model tests for every piece of functionality in the app.

#### Running the Full Test Suite:

From the root of the directory, type the below command to run the full test suite:

```
$ rspec
```

#### Running only Feature Tests:

Type this command from the root of the directory.

```
$ rspec ./spec/features
```
#### Running only Model Tests:

Type this command from the root of the directory.

```
$ rspec ./spec/models
```

#### Running a Single Test File:

Type this command from the root of the directory.

```
$ rspec ./spec/features/user/github/user_sees_github_info_spec.rb

```
#### Running a Single Test From a Single Test File:

Type this command from the root of the directory.

*Just change the line number in the command to run a different test in that file.*

```
$ rspec ./spec/features/user/github/user_sees_show_book_spec.rb:5
```


## Deployment

To deploy this app through Heroku as we have, you can follow these [instructions](https://devcenter.heroku.com/articles/git) on Heroku's website.

## Built With

* [Ruby - Version 2.4.5](https://ruby-doc.org/core-2.4.5/) - Base code language
* [Rails - Version 5.1](https://guides.rubyonrails.org/v5.1/) - Web framework used
* [RSpec](http://rspec.info/documentation/) - Testing Suite
* [Bootstrap](https://getbootstrap.com/) - Frontend templating
* [Heroku](https://www.heroku.com/) - Used to deploy to production
* [Waffle.io](https://waffle.io/) - Used for project management tracking


## Contributing

When contributing to this repository, please submit a pull request [here](https://github.com/justinmauldin7/BookClub) and one of the authors will review the request and merge it into master if it looks good.

##### *** Please note, that we only believe in Test Driven Development, so if your code you push does not have the corresponding tests to go with it, it will be rejected!! *** #####

## Authors

* **Justin Clark** - *Team member* - [Ben's Github](https://github.com/jpclark6)
* **Justin Mauldin** - *Team member* - [Justin's Github](https://github.com/justinmauldin7)


## Acknowledgments

* Huge thanks to our Mod2 instructors [Ian Douglas](https://iandouglas.com/) & [Dione Wilson](https://github.com/dionew1) for all their help and insight on this project.

* Thanks to all our other fellow [Turing School of Software & Design](https://turing.io/) - Mod2 - Backend classmates that helped us on this project as well.
