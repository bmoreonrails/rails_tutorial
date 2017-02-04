---
url: 1.html
number: 1
title: Getting Started from Scratch
layout: rails_tutorial
---
{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}

{% protip %}
  Throughout the tutorial, you're going to run a lot of commands on the command line. For example, we might ask you to do something like

  > Run `pwd` to print your current working directory.

  Where you run these commands will vary depending on the type of computer you're using.

  * If you're using a Mac, you'll type the command into *Terminal*.

  * If you're on Windows, you'll type the command into *Command Prompt*.

  After you've typed the command, you'll press `enter` to execute it.
  
  To keep things simple, we'll refer to both *Terminal* and *Command Prompt* as Terminal in the tutorial.
{% endprotip%}

{% steps %}
{% list %}
  1.  Get started by opening Terminal.

  1.  You're now in your home directory. Let's take a look what you have in there.

      Run `ls` to list everything inside your home directory.

      ```shell
      ls
      ```

      You might see some familiar directories like `Desktop`, `Documents`, and `Music`.

  1.  All code deserves a good home. Add a new `Projects` directory to your home directory by running `mkdir Projects`.

      ```shell
      mkdir Projects
      ```

  1.  Navigate into your new `Projects` directory by running `cd Projects`.

      ```shell
      cd Projects
      ```

      Now you're ready to create a new Rails application!
{% endlist %}

{% highlight shell %}
  $ ls
  Desktop Document Music

  $ mkdir Projects

  $ cd Projects
{% endhighlight %}
{% endsteps %}

{% protip %}
  Before you can continue with the tutorial, your computer needs to be configured with Rails. If you haven't already, please refer to the [install instructions]({{ site.baseurl }}/installation.html) to get everything set up and ready to go.
{% endprotip %}

{% steps %}
{% list %}
  1.  Run `rails new bookstore` to create a new Rails application named "bookstore".

      ```shell
      rails new bookstore
      ```

  1.  After `rails new` finishes, run `cd bookstore` to navigate into the newly created bookstore application.

      ```shell
      cd bookstore
      ```
{% endlist %}

{% highlight shell %}
  $ rails new bookstore
        create
        create  README.md
        create  Rakefile
        create  config.ru
        create  .gitignore
        create  Gemfile
        create  app
        ...
        run bundle install
  Fetching gem metadata from http://rubygems.org/...........
  Fetching version metadata from http://rubygems.org/...
  Fetching dependency metadata from http://rubygems.org/..
  Resolving dependencies..................
  Installing rake 11.3.0
  ...

  $ cd bookstore
{% endhighlight %}
{% endsteps %}

{% aside %}
  Woah! The `rails new` command does a lot of stuff!

  When you run `rails new`, it creates the files and directories that make up the basic structure of your new Rails application. Then, it runs `bundle install` to install the dependencies needed to run the application.
{% endaside %}

{% steps %}
{% list %}
  Let's take a look the files that got created when you ran `rails new`.

  1.  Run `ls -l` to list out all the top level files and directories in the `bookstore` directory.

      ```shell
      ls -l
      ```

      There's a lot of stuff in there, but a few things stand out.

  1.  Any code that is specific to your bookstore application will live in the `app` directory. This is where you'll be doing most of your work for this tutorial.

      Run `ls -l app` and take a look at some of things in there.

      ```shell
      ls -l app
      ```
{% endlist %}

{% highlight shell %}
  $ ls -l
  total 48
  -rw-r--r--   1 awesomesauce  staff  1728 Nov  6 14:31 Gemfile
  -rw-r--r--   1 awesomesauce  staff  4329 Nov  6 14:33 Gemfile.lock
  -rw-r--r--   1 awesomesauce  staff   374 Nov  6 14:13 README.md
  -rw-r--r--   1 awesomesauce  staff   227 Nov  6 14:13 Rakefile
  drwxr-xr-x  10 awesomesauce  staff   340 Nov  6 14:13 app
  drwxr-xr-x   7 awesomesauce  staff   238 Nov  6 14:13 bin
  drwxr-xr-x  14 awesomesauce  staff   476 Nov 12 18:56 config
  -rw-r--r--   1 awesomesauce  staff   130 Nov  6 14:13 config.ru
  drwxr-xr-x   4 awesomesauce  staff   136 Nov 12 18:54 db
  drwxr-xr-x   4 awesomesauce  staff   136 Nov  6 14:13 lib
  drwxr-xr-x   4 awesomesauce  staff   136 Nov  6 14:34 log
  drwxr-xr-x   9 awesomesauce  staff   306 Nov  6 14:13 public
  drwxr-xr-x   9 awesomesauce  staff   306 Nov  6 14:13 test
  drwxr-xr-x   7 awesomesauce  staff   238 Nov  6 14:34 tmp
  drwxr-xr-x   3 awesomesauce  staff   102 Nov  6 14:13 vendor

  $ ls -l app
  total 0
  drwxr-xr-x  6 awesomesauce  staff  204 Nov  6 14:13 assets
  drwxr-xr-x  3 awesomesauce  staff  102 Nov  6 14:13 channels
  drwxr-xr-x  4 awesomesauce  staff  136 Nov  6 14:13 controllers
  drwxr-xr-x  3 awesomesauce  staff  102 Nov  6 14:13 helpers
  drwxr-xr-x  3 awesomesauce  staff  102 Nov  6 14:13 jobs
  drwxr-xr-x  3 awesomesauce  staff  102 Nov  6 14:13 mailers
  drwxr-xr-x  4 awesomesauce  staff  136 Nov  6 14:13 models
  drwxr-xr-x  3 awesomesauce  staff  102 Nov  6 14:13 views
{% endhighlight %}
{% endsteps %}

{% protip %}
  It's easiest to view and edit the files of your application using a text editor created just for programming. If you don't already have a favorite text editor we recommend [Atom](https://atom.io/).
{% endprotip %}

{% steps %}
{% list %}
  The `config` directory is where you'll store configuration files for the bookstore application.

  `rails new` generated a bunch of configuration files to help you get this new application up and running quickly. Let's take a look at one of those files.

  1.  Using your favorite text editor, open the whole `bookstore` directory.

      If you're using Atom, you can do this by going to `File` > `Open...`.

  1.  Now, open `config/database.yml`.

      `database.yml` tells Rails how to connect to the bookstore application's database.

      By default, the bookstore application is setup to use [SQLite](https://sqlite.org/). It's a light weight database that's perfect for this tutorial.

      Since we're happy with the default `database.yml` generated by `rails new`, we can live it as is.
{% endlist %}

{% highlight yml linenos %}
  # SQLite version 3.x
  #   gem install sqlite3
  #
  #   Ensure the SQLite 3 gem is defined in your Gemfile
  #   gem 'sqlite3'
  #
  default: &default
    adapter: sqlite3
    pool: 5
    timeout: 5000

  development:
    <<: *default
    database: db/development.sqlite3

  # Warning: The database defined as "test" will be erased and
  # re-generated from your development database when you run "rake".
  # Do not set this db to the same as development or production.
  test:
    <<: *default
    database: db/test.sqlite3

  production:
    <<: *default
    database: db/production.sqlite3
{% endhighlight %}
{% endsteps %}

{% aside %}
### Not sure what a database is? Don't worry, we'll fill you in. 😊

There are many different types of databases out there, but we'll only be working with a relational database.

A relational database is made up of tables where you store data. You can think of them kinda like an Excel spreadsheet but much more powerful. There are many types of *Relational Database Management Systems* (RDMS's for short) and SQLite is just one of them.

Feel free to check out this video to learn a bit more about Relational Databases:

<iframe width="560" height="315" src="https://www.youtube.com/embed/t48TGntrX4s" frameborder="0" allowfullscreen></iframe>
{% endaside %}

{% protip %}
  While you're working through the tutorial, don't worry if what you're seeing doesn't look *exactly* like the examples in the tutorial. Everyone's setup is going to be a little different, and small things can change between different versions of Rails.
{% endprotip %}

{% steps %}
{% list %}
  Let's get the application running!

  1.  Go back to Terminal and make sure you're in the `bookstore` directory by running `pwd`.

      ```shell
      pwd
      ```

      `pwd` shows you what directory you're in. You should see something like `/Users/awesomesauce/Projects/bookstore`.

  1.  If you're not in the `bookstore` directory, you're *probably* in your home directory.

      To get to the `bookstore` directory from your home directory, first run `cd Projects` to get to your `Projects` directory. Then, run `cd bookstore`.

      ```shell
      cd Projects
      cd bookstore
      ```

  1.  Now run `rails server` to start your application's web server.

      If you take a close look at the command's output, you'll see where you can access the running application:

      ```shell
      => Rails 5.0.0.1 application starting in development on
      http://localhost:3000
      ```

 1.  Open you web browser and go to [http://localhost:3000](http://localhost:3000).
{% endlist %}

{% highlight shell %}
  $ pwd
  /Users/awesomesauce/Projects/bookstore

  $ rails server
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
  => Run `rails server -h` for more startup options
  Puma starting in single mode...
  * Version 3.6.0 (ruby 2.3.1-p112), codename: Sleepy Sunday Serenity
  * Min threads: 5, max threads: 5
  * Environment: development
  * Listening on tcp://localhost:3000
  Use Ctrl-C to stop
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Rails Default Root Page]({{ site.baseurl}}/assets/images/rails_yay.png)
{% endscreenshot %}

{% steps %}
{% list %}
  Yay! The bookstore application is running!

  1.  Go back to Terminal and take a look at what's happening in your application's web server. You can see the application responding to requests!

  1.  Now that you're back in Terminal, run `Ctrl-C` to stop your application's web server.
{% endlist %}

{% highlight shell %}
  $ rails server
  ...
  Started GET "/" for ::1 at 2016-11-12 19:38:25 -0500
  Processing by Rails::WelcomeController#index as HTML
    Parameters: {"internal"=>true}
    Rendering /Users/awesomesauce/.rvm/gems/ruby-2.3.1/gems/railties-5.0.0.1/lib/rails/templates/rails/welcome/index.html.erb
    Rendered /Users/awesomesauce/.rvm/gems/ruby-2.3.1/gems/railties-5.0.0.1/lib/rails/templates/rails/welcome/index.html.erb (6.6ms)
  Completed 200 OK in 71ms (Views: 27.0ms | ActiveRecord: 0.0ms)
  ...
  ^CExiting
{% endhighlight %}
{% endsteps %}

{% aside %}
### What's this bookstore we keep talking about?

In this tutorial, you're going to use Rails to build an application for a bookstore.

As you build the application, you'll add features to create, view, edit, and delete books. Since we all have feelings on the books we love...and hate, you'll add features so books can be reviewed by users.

By creating an application for a bookstore, you'll get to explore the different layers of the Rails framework.

Are you ready?!

![Yes!]({{ site.baseurl }}/assets/images/yes.gif)
{% endaside %}



