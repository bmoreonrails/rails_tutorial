---
url: 12.html
number: 12
title: Adding Users to Your Database
layout: rails_tutorial
---
{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}

{% aside %}
  How does it feel to get all those reviews out of your system? I'm sure it feels good 😆

  You worked really hard to write those reviews, but how will anyone know you wrote them?

  What if people show up and start leaving reviews? How will you keep to track of who's reviewing what?

  We need users!

  A user should be able to login to your bookstore. Once they're logged in, any reviews they write can be attributed to them.

  We'll start by adding users to your database.
{% endaside %}

{% steps %}
{% list %}
  Let's start by creating a migration for the `users` table.

  1.  Open Terminal and go to the `bookstore` directory.

  1.  Now, run `rails generate model user`.

      This command should be a little familiar. We used it earlier when added the `books` and `reviews` tables. It will generate a `CreateUsers` migration.
{% endlist %}

{% highlight shell %}
  $ pwd
  /Users/awesomesauce/Projects/bookstore

  $ rails generate model user
        invoke  active_record
        create    db/migrate/20170112224318_create_users.rb
        create    app/models/user.rb
        invoke    test_unit
        create      test/models/user_test.rb
        create      test/fixtures/users.yml
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Open the `CreateUsers` migration in your text editor.

      Remember, the `CreateUsers` migration file has a timestamped filename.

      `db/migrate/TIMESTAMP_create_users.rb`
{% endlist %}

{% highlight ruby linenos %}
  class CreateUsers < ActiveRecord::Migration[5.0]
    def change
      create_table :users do |t|

        t.timestamps
      end
    end
  end
{% endhighlight %}
{% endsteps %}

{% aside %}
### There's a Pattern to Creating Tables in Migrations...

Does the `CreateUsers` migration look familiar? It doesn't do much yet, but it looks a lot like the `CreateBooks` and `CreateReviews` migrations.

Take a look at the `CreateBooks` migration to refresh your memory.

```ruby
class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :price_cents
      t.timestamps
      t.integer :quantity
    end
  end
end
```

Just like the `CreateBooks` migration, the `CreateUsers` migration has a `change` method. Inside the `change` method, there's a `create_table` block with the name of the table to create. In the `CreateBooks` migration the table name is `:books`, but in the the `CreateUsers` migration it's `users`.

You define the columns you want to add to the table inside the `create_table` block. You added a bunch of columns in the `CreateBooks` migration, but you haven't added any to the `CreateUsers` migration...yet 😉
{% endaside %}

{% steps %}
{% list %}
  To support users logging in, we need to add a couple of columns to the `users` table.

  First, we'll need to add a `username` for the...user's name.

  Then, we'll need to add a `password_digest` column. This will be used to securely store user passwords (more on that later).

  Both columns will be `string` columns.

  1.  Using your other migrations as examples, update the `create_table` block in the `CreateUsers` migration so `username` and `password_digest` are added as `string` columns to the `users` table.

  1.  When you're done, save your changes, and run the migration by running `rake db:migrate`.

      If you make any mistakes, you can always undo the migration by running `rake db:rollback`. Then, you can make changes to the `CreateUsers` migration and re-run it with `rake db:migrate`.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  What does your solution look like?! Did you add the columns to the `users` table??

  1.  Your `create_table` block should look something like this:

      ```ruby
      create_table :users do |t|
        t.string :username
        t.string :password_digest
        t.timestamps
      end
      ```

  1.  If your `create_table` block doesn't look like this, update your solution to match this solution and run the migration.

      If you ran the migration without the `username` or `password_digest` columns, you'll need to rollback the migration and run it again.
{% endlist %}

{% highlight ruby linenos %}
  class CreateUsers < ActiveRecord::Migration[5.0]
    def change
      create_table :users do |t|
        t.string :username
        t.string :password_digest
        t.timestamps
      end
    end
  end
{% endhighlight %}
{% endsteps %}

{% aside %}
### What's a Password Digest?

You're bookstore application now has a `users` table with a couple of columns. The `username` column probably seems reasonable, but I'm sure the `password_digest` column looks questionable. What's a *password digest* anyways?

Rails provides a feature to make password management convienient. By adding the `passowrd_digest` column, you've already taken the first step towards using this feature.

The next step is going to require a code change.
{% endaside %}

{% steps %}
{% list %}
  1.  Open `app/models/user.rb` in your text editor.

  1.  Inside the `User` class, add the following line:

      ```ruby
      has_secure_password
      ```

      This will call Rails' `has_secure_password` method to make the password management feature available on all users.

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  class User < ApplicationRecord
    has_secure_password
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  Let's see what we can do with the `User` class.

  1.  Go to Terminal and start the `rails console`.

  1.  Now, let's try building your bookstore's first user. Run the following code:

      ```ruby
      my_first_user = User.new(username: "CatPower")
      ```

      Woah! That's a gnarly error!

  1.  If you look closely at the error, it's trying to tell you what's wrong. It even has a suggestion on how you can fix it.

      ```ruby
      You don't have bcrypt installed in your application. Please add it to your Gemfile and run bundle install
      ```

      Let's break down this error, but first - exit the rails console.
{% endlist %}

{% highlight ruby %}
  $ rails console
  Loading development environment (Rails 5.0.0.1)
  >> my_first_user = User.new(username: "CatPower")
  You don't have bcrypt installed in your application. Please add it to your Gemfile and run bundle install
  LoadError: cannot load such file -- bcrypt
  ...

  >> exit
{% endhighlight %}
{% endsteps %}

{% aside %}
### bcrypt, RubyGems, and Gemfiles
Let's take a look at the first part of the error.

```ruby
You don't have bcrypt installed in your application.
```

Your bookstore application doesn't have bcrypt installed, and it never did. Why's that a problem now?

`has_secure_password` is being run on every `User`, including `my_first_user`. Under the hood, `has_secure_password` uses bcrypt to encrypt and save passwords.

Since your bookstore application doesn't have bcrypt, `has_secure_password` can't run and it throws this error.

Now that we have some idea of what the problem is, how can we fix it? Let's take a look at the second part of the error.

```ruby
Please add it to your Gemfile and run bundle install
```

Hmm...I guess we have to add bcrypt to your Gemfile.

*What's a Gemfile?*

Ah, a Gemfile! It's a really important part of the Ruby ecosystem.

A lot of Ruby projects have Gemfiles to manage the RubyGems they use.

*Huh...what's a RubyGem?*

A RubyGem is a bundle of Ruby code that can be used in any Ruby project. Some RubyGems are [small](https://rubygems.org/gems/rspec-pride), and others are [pretty big](https://rubygems.org/gems/rails).

RubyGems are usually referred to as Gems because who has time for all those syllables.

[bcrypt](https://rubygems.org/gems/bcrypt) is a RubyGem.

Your bookstore application **is** a Ruby project, it just happens to be a Rails application too 😉

As a Ruby project that uses RubyGems, it has a Gemfile. Let's take a look at it.
{% endaside %}

{% steps %}
{% list %}
  Your application's Gemfile is a file named...`Gemfile`. It's not nested inside any directories, and it's one of the first files in the `bookstore` directory.

  1.  Open the `Gemfile` in your text editor.

      Woah! Your application's Gemfile already has some stuff in it!

      Turns out your application has been using a Gemfile this whole time.

      ![Who knew?]({{site.baseurl}}/assets/images/whoknew.gif)

      Your application's `Gemfile` is the default Gemfile that ships with all new Rails applications. You can choose different RubyGems, but this default list helps you get started quickly.

      If you read through the `Gemfile`, you might recongize some RubyGems we've been using. You might even come across a RubyGem that brought us here in the first place...
{% endlist %}

{% highlight ruby linenos %}
  source 'http://rubygems.org'


  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Use Puma as the app server
  gem 'puma', '~> 3.0'
  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 5.0'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .coffee assets and views
  gem 'coffee-rails', '~> 4.2'
  # See https://github.com/rails/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  # Use jquery as the JavaScript library
  gem 'jquery-rails'
  # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
  gem 'turbolinks', '~> 5'
  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 2.5'
  # Use Redis adapter to run Action Cable in production
  # gem 'redis', '~> 3.0'
  # Use ActiveModel has_secure_password
  # gem 'bcrypt', '~> 3.1.7'

  # Use Capistrano for deployment
  # gem 'capistrano-rails', group: :development

  group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platform: :mri
  end

  group :development do
    # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
    gem 'web-console'
    gem 'listen', '~> 3.0.5'
    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
  end

  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
  gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Did you find find bcrypt in your Gemfile?! It's tucked in there...

      ```ruby
      # Use ActiveModel has_secure_password
      # gem 'bcrypt', '~> 3.1.7'
      ```

      *Wait a minute...if bcrypt is in my Gemfile why isn't it in my application?*

      bcrypt is in your Gemfile, but it's only included as comment. In Ruby, any line that starts with `#` is a comment. Comments are never run; they're just messages to help you understand what's going on.

  1.  To include bcrypt, you just need to uncomment that line. Change

      ```ruby
      # gem 'bcrypt', '~> 3.1.7'
      ```

      to

      ```ruby
      gem 'bcrypt', '~> 3.1.7'
      ```

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  source 'http://rubygems.org'


  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Use Puma as the app server
  gem 'puma', '~> 3.0'
  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 5.0'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .coffee assets and views
  gem 'coffee-rails', '~> 4.2'
  # See https://github.com/rails/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  # Use jquery as the JavaScript library
  gem 'jquery-rails'
  # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
  gem 'turbolinks', '~> 5'
  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 2.5'
  # Use Redis adapter to run Action Cable in production
  # gem 'redis', '~> 3.0'
  # Use ActiveModel has_secure_password
  gem 'bcrypt', '~> 3.1.7'

  # Use Capistrano for deployment
  # gem 'capistrano-rails', group: :development

  group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platform: :mri
  end

  group :development do
    # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
    gem 'web-console'
    gem 'listen', '~> 3.0.5'
    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
  end

  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
  gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
{% endhighlight %}
{% endsteps %}

{% aside %}
### How Do We Install RubyGems From the Gemfile?

Now that bcrypt is part of your `Gemfile`, you're ready to install it.

The RubyGems in your `Gemfile` are installed by `bundle install`.

You might remember `bundle install` from a looooong time ago. `rails new` runs `bundle install` as its last step in creating your application.
{% endaside %}

{% steps %}
{% list %}
  1.  Open Terminal and run `bundle install`.

      `bundle install` goes through each RubyGem in your `Gemfile` and decides if it needs to install it or not. If your application already has the RubyGem, it will output "Using..." and move on to the next RubyGem.

      We're only adding one RubyGem to your application - bcrypt. When `bundle install` gets to bcrypt, it will tell you that it's being installed:

      ```shell
      Installing bcrypt 3.1.11 with native extensions
      ```

  1.  When `bundle install` finishes, you'll get a message telling you how many RubyGems your application is using.

      ```shell
      Bundle complete! 16 Gemfile dependencies, 63 gems now installed.
      ```
{% endlist %}

{% highlight shell %}
  $ bundle install
  Fetching gem metadata from http://rubygems.org/.........
  Fetching version metadata from http://rubygems.org/..
  Fetching dependency metadata from http://rubygems.org/.
  Using rake 11.3.0
  Using concurrent-ruby 1.0.2
  Using i18n 0.7.0
  Using minitest 5.9.1
  Using thread_safe 0.3.5
  Using builder 3.2.2
  Using erubis 2.7.0
  Using mini_portile2 2.1.0
  Using rack 2.0.1
  Using nio4r 1.2.1
  Using websocket-extensions 0.1.2
  Using mime-types-data 3.2016.0521
  Using arel 7.1.4
  Installing bcrypt 3.1.11 with native extensions
  Using byebug 9.0.6
  Using coffee-script-source 1.10.0
  Using execjs 2.7.0
  Using method_source 0.8.2
  Using thor 0.19.1
  Using debug_inspector 0.0.2
  Using ffi 1.9.14
  Using multi_json 1.12.1
  Using rb-fsevent 0.9.8
  Using puma 3.6.0
  Using bundler 1.13.6
  Using sass 3.4.22
  Using tilt 2.0.5
  Using sqlite3 1.3.12
  Using turbolinks-source 5.0.0
  Using tzinfo 1.2.2
  Using nokogiri 1.6.8.1
  Using rack-test 0.6.3
  Using sprockets 3.7.0
  Using websocket-driver 0.6.4
  Using mime-types 3.1
  Using coffee-script 2.4.1
  Using uglifier 3.0.3
  Using rb-inotify 0.9.7
  Using turbolinks 5.0.1
  Using activesupport 5.0.0.1
  Using loofah 2.0.3
  Using mail 2.6.4
  Using listen 3.0.8
  Using rails-dom-testing 2.0.1
  Using globalid 0.3.7
  Using activemodel 5.0.0.1
  Using jbuilder 2.6.0
  Using spring 2.0.0
  Using rails-html-sanitizer 1.0.3
  Using activejob 5.0.0.1
  Using activerecord 5.0.0.1
  Using spring-watcher-listen 2.0.1
  Using actionview 5.0.0.1
  Using actionpack 5.0.0.1
  Using actioncable 5.0.0.1
  Using actionmailer 5.0.0.1
  Using railties 5.0.0.1
  Using sprockets-rails 3.2.0
  Using coffee-rails 4.2.1
  Using jquery-rails 4.2.1
  Using web-console 3.4.0
  Using rails 5.0.0.1
  Using sass-rails 5.0.6
  Bundle complete! 16 Gemfile dependencies, 63 gems now installed.
  Use `bundle show [gemname]` to see where a bundled gem is installed.
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  Now that you're application is using bcrypt, maybe we can start doing stuff with `User`s. 😄

  1.  Open the `rails console` and run the following:

      ```ruby
      my_first_user = User.new(username: "CatPower")
      ```

      *Yay! No errors* 🎉

      This assigns a new `User` with `username` "CatPower" to `my_first_user`.

      `my_first_user` has a `username`, but she doesn't have a password.

      Fortunately, `has_secure_password` added a method to `User` so you can set passwords.

  1.  Try setting a password for `my_first_user` by running:

      ```ruby
      my_first_user.password = "password"
      ```

  1.  Now, try saving `my_first_user`.

      ```ruby
      my_first_user.save
      ```

      Wait...that worked?

      ![No way]({{site.baseurl}}/assets/images/noway.gif)
{% endlist %}

{% highlight ruby %}
  >> my_first_user = User.new(username: 'CatPower')
  => #<User id: nil, username: "CatPower", password_digest: nil, created_at: nil, updated_at: nil>

  >> my_first_user.password = 'password'
  => "password"

  >> my_first_user.save
     (0.1ms)  begin transaction
    SQL (0.6ms)  INSERT INTO "users" ("username", "password_digest", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["username", "CatPower"], ["password_digest", "$2a$10$T9KFCyIrtgFhBtEixMYm9e757ZXa7UlBVOyaAzCtbwt2rNP5snSle"], ["created_at", 2017-01-13 02:57:39 UTC], ["updated_at", 2017-01-13 02:57:39 UTC]]
     (1.1ms)  commit transaction
  => true
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Take a look at how the password was saved into the `users` table. Run `my_first_user.password_digest`.

      That's not the generic password you were expecting, was it?

      `has_secure_password` transformed the plain text password you set on `my_first_user` into an encrypted password. Then, the encrypted password was stored in the `password_digest` column.

  1.  Now that you have a user with a password, you can authenticate her.

      What do you think will happen when you run the following code?

      ```ruby
      my_first_user.authenticate("password")
      ```

      What about if you do something like this instead?

      ```ruby
      my_first_user.authenticate("I'm just guessing")
      ```

      Give them a try!
{% endlist %}

{% highlight ruby %}
  >> my_first_user.password_digest
  => "$2a$10$T9KFCyIrtgFhBtEixMYm9e757ZXa7UlBVOyaAzCtbwt2rNP5snSle"
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  When you run `my_first_user.authenticate` with `my_first_user`'s password, `authenticate` returned the user.

      ```ruby
      >> my_first_user.authenticate("password")
      => #<User id: 1, username: "CatPower", password_digest: "$2a$10$T9KFCyIrtgFhBtEixMYm9e757ZXa7UlBVOyaAzCtbwt...", created_at: "2017-01-13 02:57:39", updated_at: "2017-01-13 02:57:39">
      ```

  1.  When you run `my_first_user.authenticate` with an invalid password, `authenticate` returned false.

      ```ruby
      >> my_first_user.authenticate("bad password")
      => false
      ```
{% endlist %}

{% highlight ruby %}
  >> my_first_user.authenticate("password")
  => #<User id: 1, username: "CatPower", password_digest: "$2a$10$T9KFCyIrtgFhBtEixMYm9e757ZXa7UlBVOyaAzCtbwt...", created_at: "2017-01-13 02:57:39", updated_at: "2017-01-13 02:57:39">

  >> my_first_user.authenticate("bad password")
  => false
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Yay! Now you can create users, securely store their passwords, and authenticate them.

      Exit the `rails console` and do your happy dance.

      ![Lisa's happy dance]({{site.baseurl}}/assets/images/happy_dance.gif)
{% endlist %}
{% endsteps %}
