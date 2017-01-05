# Installing Rails for Linux

## Install Ruby (2.3.1)

Everything in this installation takes place in your terminal. First, we'll need to install dependencies for Ruby. 

```
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
```

Now, we will install Ruby via RVM. [Learn why RVM is useful here](https://code.tutsplus.com/articles/why-you-should-use-rvm--net-19529).

```
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.3.1
rvm use 2.3.1 --default
```

To verify you're using the correct Ruby version, type `ruby -v`. You should have 2.3.1 as the version. Now, you'll need to install Bundler via

``` gem install bundler ```

## Install Git

Git is a version control system. We'll use Github to host our code. If you don't already have a Github account, make sure to [register](https://github.com/).

Install git:
``` sudo apt-get install git```

Now, you'll need to set the configurations to your account. Replace your name and email with what you've used for your Github account.
```
git config --global color.ui true
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR@EMAIL.com"
ssh-keygen -t rsa -b 4096 -C "YOUR@EMAIL.com"
```

Now, you'll need to add your newly generated SSH key and add it to your Github account, so that Github knows it's you. The below command will open the file for you and copy it to your paste board. 

```
cat ~/.ssh/id_rsa.pub | pbcopy
```

You'll need to paste the output into your Github SSH settings [found here](https://github.com/settings/ssh).

You can verify if this works via
```
ssh -T git@github.com
```
You should get a message like this:

```
Hi [YOURNAME]! You've successfully authenticated, but GitHub does not provide shell access.
```

## Install Rails 4.2.6
Since Rails ships with so many dependencies these days, we're going to need to install a Javascript runtime like NodeJS. This lets you use Coffeescript and the [Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html) in Rails which combines and minifies your javascript to provide a faster production environment.

To install NodeJS, we're going to add it using the official repository:

```
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
```

And now, without further adieu:

```
gem install rails -v 4.2.6
```

To make sure everything installed correctly, run `rails -v` and it should output `Rails 4.2.6`.

## Installing Your Database
### MySQL
Rails ships with sqlite3 as the default database. Chances are you won't want to use it because it's stored as a simple file on disk. You'll probably want something more robust like MySQL or PostgreSQL.

There is a lot of documentation on both, so you can just pick one that seems like you'll be more comfortable with. If you're coming from PHP, you may already be familiar with MySQL. If you're new to databases, you may want to skip setting up PostgreSQL.

You can install MySQL server and client from the packages in the Ubuntu repository. As part of the installation process, you'll set the password for the root user. This information will go into your Rails app's `database.yml` file in the future.
```
sudo apt-get install mysql-server mysql-client libmysqlclient-dev
```
Installing the `libmysqlclient-dev` gives you the necessary files to compile the `mysql2` gem which is what Rails will use to connect to MySQL when you setup your Rails app.

### PostgreSQL
For PostgreSQL, we're going to add a new repository to easily install a recent version of Postgres.
```
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-common
sudo apt-get install postgresql-9.5 libpq-dev
```

The postgres installation doesn't setup a user for you, so you'll need to follow these steps to create a user with permission to create databases. Replace NAME with your username.
```
sudo -u postgres createuser NAME -s

# If you would like to set a password for the user, you can do the following
sudo -u postgres psql
postgres=# \password NAME
```
