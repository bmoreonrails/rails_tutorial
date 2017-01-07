---
url: ubuntu.html
title: Installation on Ubuntu Linux
layout: rails_installation
---

{:.sectionheader}
# Installing Rails for Linux

To get linux ready for Ruby on Rails development, we need to do the following:

1. install dependencies
1. install ruby
1. install rails
1. test it out

We're going to do these tasks via the Terminal console, so if you aren't familiar with that, please read **this non-existent page** over first.

## Dependencies

First, we'll need to install dependencies for Ruby.

{% highlight bash %}
   $ sudo apt-get update
   $ sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
   $ sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
{% endhighlight %}

## Install Ruby (2.3.1)

The [Ruby Version Manager (rvm)](http://rvm.io/) will allow you to install different versions of ruby on your machine and switch between them as you switch from one job to another. [Learn why RVM is useful here](https://code.tutsplus.com/articles/why-you-should-use-rvm--net-19529).

To install rvm, open a terminal window and run the following commands (copied directly off of the rvm website):

{% highlight bash %}
   $ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
   $ curl -sSL https://get.rvm.io | bash -s stable
   $ source ~/.rvm/scripts/rvm
{% endhighlight %}

Now that you have rvm installed, you can use it to install ruby.  You simply call `rvm install <version>`.  Let's install the latest version (as of 12/3/2016), v2.3.1:

{% highlight bash %}
  $ rvm install 2.3.1
  $ rvm default use 2.3.1
{% endhighlight %}

To verify you're using the correct Ruby version, type `ruby -v`. You should have 2.3.1 as the version.

{% highlight bash %}
  $ ruby -v
  # => ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]
{% endhighlight %}

Now, you'll need to install a tool called Bundler via

{% highlight bash %}
   $ gem install bundler
{% endhighlight %}

## Install Rails

Since Rails ships with so many dependencies these days, we're going to need to install a Javascript runtime like NodeJS. This lets you use Coffeescript and the [Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html) in Rails which combines and minifies your javascript to provide a faster production environment.

To install NodeJS, we're going to add it using the official repository:

{% highlight bash %}
   $ curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
   $ sudo apt-get install -y nodejs
{% endhighlight %}

And now, without further adieu:

{% highlight bash %}
  $ gem install rails 5.0.1 --no-document
{% endhighlight %}

{% protip %}
Note, adding `--no-document` prevents the generation of local (offline) documentation.  If you later decide you want local docs, you can easily recreate them (although it can be a slow process).  Look [here](http://blog.honeybadger.io/how-to-globally-disable-rdoc-and-ri-during-gem-installs/) for more details.
{% endprotip %}

If that succeeds, you should be able to run rails on the command-line:

{% highlight bash %}
  $ rails --version
  Rails 5.0.1
{% endhighlight %}

## Test it out

Now that we have everything we need installed, let's try it out.

{% highlight bash %}
  $ rails new test_rails
  $ cd test_rails
  $ rails server
{% endhighlight %}

You should see output similar to this:

{% highlight bash %}
  => Booting Puma
  => Rails 5.0.1 application starting in development on http://localhost:3000
  => Run `rails server -h` for more startup options
  Puma starting in single mode...
  * Version 3.6.2 (ruby 2.3.1-p112), codename: Sleepy Sunday Serenity
  * Min threads: 5, max threads: 5
  * Environment: development
  * Listening on tcp://localhost:3000
  Use Ctrl-C to stop
{% endhighlight %}

If you see the output above, rails is running and you can point your browser at http://localhost:3000 and you should see this:

![Yay! You're on Rails!]({{ site.baseurl}}/assets/images/youre_on_rails.png)

## Optional

The following tools are optional for the tutorial, but are commonly used by many developers.

### Install Git

Git is a version control system. We'll use Github to host our code. If you don't already have a Github account, make sure to [register](https://github.com/).

Install git:
{% highlight bash %}
   $ sudo apt-get install git
{% endhighlight %}

Now, you'll need to set the configurations to your account. Replace your name and email with what you've used for your Github account.

{% highlight bash %}
   $ git config --global color.ui true
   $ git config --global user.name "YOUR NAME"
   $ git config --global user.email "YOUR@EMAIL.com"
   $ ssh-keygen -t rsa -b 4096 -C "YOUR@EMAIL.com"
{% endhighlight %}

Now, you'll need to add your newly generated SSH key and add it to your Github account, so that Github knows it's you. The below command will open the file for you and copy it to your paste board.

{% highlight bash %}
   $ cat ~/.ssh/id_rsa.pub | pbcopy
{% endhighlight %}

You'll need to paste the output into your Github SSH settings [found here](https://github.com/settings/ssh).

You can verify if this works via

{% highlight bash %}
   $ ssh -T git@github.com
{% endhighlight %}

You should get a message like this:

{% highlight bash %}
   Hi [YOURNAME]! You've successfully authenticated, but GitHub does not provide shell access.
{% endhighlight %}

### Installing a Different Database

#### MySQL

Rails ships with sqlite3 as the default database. Chances are you won't want to use it because it's stored as a simple file on disk. You'll probably want something more robust like MySQL or PostgreSQL.

There is a lot of documentation on both, so you can just pick one that seems like you'll be more comfortable with. If you're coming from PHP, you may already be familiar with MySQL. If you're new to databases, you may want to skip setting up PostgreSQL.

You can install MySQL server and client from the packages in the Ubuntu repository. As part of the installation process, you'll set the password for the root user. This information will go into your Rails app's `database.yml` file in the future.

{% highlight bash %}
   $ sudo apt-get install mysql-server mysql-client libmysqlclient-dev
{% endhighlight %}

Installing the `libmysqlclient-dev` gives you the necessary files to compile the `mysql2` gem which is what Rails will use to connect to MySQL when you setup your Rails app.

#### PostgreSQL

For PostgreSQL, we're going to add a new repository to easily install a recent version of Postgres.

{% highlight bash %}
   $ sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
   $ wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
   $ sudo apt-get update
   $ sudo apt-get install postgresql-common
   $ sudo apt-get install postgresql-9.5 libpq-dev
{% endhighlight %}

The postgres installation doesn't setup a user for you, so you'll need to follow these steps to create a user with permission to create databases. Replace NAME with your username.

{% highlight bash %}
   $ sudo -u postgres createuser NAME -s

   # If you would like to set a password for the user, you can do the following
   $ sudo -u postgres psql
   $ postgres=# \password NAME
{% endhighlight %}
