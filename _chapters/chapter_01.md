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

  The place that you run these commands will be different based on the type of computer you have: 

  * If you're using a mac, you'll type the command into *Terminal* and hit `enter` to execute it.

  * To run this command on Windows you'll need to type it into the *Command Prompt* then press `enter`. 
  
  Throughout this tutorial we'll be referring to both Terminal and Command Prompt as "Terminal". 
{% endprotip%}

{% steps %}
{% list %}
  1.  Get started by opening Terminal.

  1.  You're now in your home directory. The command `ls` will always show you what's in the current directory. Go ahead and run `ls` to see what files are here.
 
  1.  You might see some familiar files like Desktop, Documents, and Music.

  1.  All code deserves a good home. Add a new `Projects` directory to your home directory by running `mkdir Projects`.

  1.  Navigate into your new `Projects` directory by running `cd Projects`.

  1.  Now you're ready to create the bookstore!
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
  1.  In your `Projects` directory, run `rails new bookstore`.

  1.  The `rails new` command does a lot of stuff! First, it creates the files and directories that make up the basic structure of your bookstore application. Then, it runs `bundle install` to install the dependencies needed to run the application.

  1.  After `$rails new` finishes, run `cd bookstore` to navigate into the newly created bookstore application.
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
{% endhighlight %}
{% endsteps %}

{% aside %}
### What's this bundle thing?

The command "bundle" might sound familiar to you. If you did the install instructions for this tutorial, you probably ran `gem install bundler`. 

[Bundler](http://bundler.io/) is a program that helps you manage all of the other little programs that help Rails run and all of the commands related to that program start with `bundle`. 

You don't need to worry about this much for the tutorial but if you're interested in it, you can learn more about them on their website. 
{% endaside %}

{% steps %}
{% list %}
  1.  Let's take a look the files that got created when you ran `rails new`.

  1.  Run `ls -l` to list out all the top level files and directories. There's lot going on, but a few things stand out.

  1.  Any code that is specific to the bookstore application will live in the `app` directory. This is where you'll be doing most of your work for this tutorial. Run `ls -l app` to take a look at the some of the things you'll be working with.
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
  It's easiest to edit these files using a text editor created just for programming. If you don't already have a favorite text editor we recommend [Atom](https://atom.io/).
{% endprotip %}

{% steps %}
{% list %}
  1.  The `config` directory is where you'll store configuration files for the bookstore application. `rails new` generated a bunch of configuration files to help you get this new application up and running quickly. Let's take a look at one of those files.

  1.  From inside your favorite text editor go to File -> open and select the whole `bookstore` directory.

  1.  In your text editor, navigate to the `config` directory, and then look at the contents of the `database.yml` file.

  1.  `database.yml` tells Rails how to connect to the bookstore application's database.

  1.  By default, the bookstore application is setup to use [SQLite](https://sqlite.org/). It's a light weight database that's perfect for this tutorial.

  1.  Since we're happy with the default `database.yml` generated by `rails new`, we can live it as is. Which is great because we ❤️ [convention over configuration](https://en.wikipedia.org/wiki/Convention_over_configuration) when programming with Rails.
{% endlist %}

{% highlight yaml linenos %}
  # config/database.yml

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
### Not sure what a database is? Don't worry, we'll fill you in :)

There are many different types of databases but the type we'll be working with here is called a Relational Database. A relational database is made up of tables where you store data kinda like an Excel spreadsheet but much more powerful. There are many types of *Relational Database Management Systems* (RDMS's for short) and SQLite is just one of them. 

Feel free to check out this video to learn a bit more about Relational Databases:

<iframe width="560" height="315" src="https://www.youtube.com/embed/t48TGntrX4s" frameborder="0" allowfullscreen></iframe>

{% endaside %}

{% protip %}
 As you work through the tutorial - don't worry if what you're seeing doesn't look exactly like our examples. Small things can change between different versions of Rails.
{% endprotip %}

{% steps %}
{% list %}
  1.  Let's get the application running!

  1.  Go back to Terminal and make sure you're in the `bookstore` directory.

      Not sure if you're in the `bookstore` directory? Run `pwd` to see what directory you're in. You should see something like `/Users/awesomesauce/Projects/bookstore`. 

      If you're still in your home directory run `cd bookstore` in your terminal to navigate into your bookstore directory. 

  1.  Now run `$rails server` to start the application server. Notice that the output in your terminal tells you how to access the running application:

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
  <a href='#' data-featherlight='/rails_tutorial/assets/images/rails_yay.png'>
  ![Rails Default Root Page]({{ site.baseurl}}/assets/images/rails_yay.png)
  </a>
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Yay! The bookstore application is running!

  1.  Go back to Terminal, and you can see the application responding to requests.

  1.  Now that you're back in Terminal, run `Ctrl-C` to stop the application.
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
  What's this bookstore we keep talking about? In this tutorial, we're going to use Rails to make an application for a bookstore.

  As you build the application, you'll add features to create, view, edit, and delete books. Since we all have feelings on the books we love...and hate, you'll add features so books can be reviewed by users.

  By creating an application for a bookstore, you'll get explore the different layers of the Rails framework.

  Are you ready?!

  ![Yes!]({{ site.baseurl }}/assets/images/yes.gif)
{% endaside %}



