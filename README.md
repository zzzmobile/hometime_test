# Hometime Skill Assessment

##### Prerequisites

This project expects following tools installed on the system.

- Ruby 2.6.6
- Postgres 9.6+

##### 1. Check out the repository

##### 2. Install dependencies

Using [Bundler](https://github.com/bundler/bundler):

```shell
bundle install
```

##### 3. Modify database.yml file according to your DB credentials

##### 4. Create and setup the database

Run the following commands to create and setup the database.

```bash
bundle exec rake db:create
bundle exec rake db:setup
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```bash
bundle exec rails s
```

And now you can make POST request to the URL http://localhost:3000/reservations

