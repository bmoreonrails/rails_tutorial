---
url: 4.html
number: 4
title: Showing Detailed Information in the Browser
layout: rails_tutorial
---

{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}

{% aside %}
  You're bookstore is starting to come along. You have an index that lists all the books in your database by title and author. This is great, but what about the other information you've stored about your books? It would be useful to see how much a book costs, or how many are available.

  Let's show this information.
{% endaside %}

{% steps %}
{% list %}
  1.  Let's start by looking at your application's routes again.

  1.  Open Terminal and go to your `bookstore` directory.

  1.  Run `rake routes`.

  1.  So far we've worked with the first row in the routes table. We used the `/books` path with the `BooksController` `index` action to list all your application's books.

  1.  Now that we want to show detailed book information we'll need to use a different route.

      ```ruby
      book GET    /books/:id(.:format)      books#show
      ```

      This time, we'll use the `/books/:id` path with the `BooksController` `show` action to show a book's information.
{% endlist %}

{% highlight shell %}
  $ pwd
  /Users/awesomesauce/Projects/bookstore

  $ rake routes
     Prefix Verb   URI Pattern               Controller#Action
      books GET    /books(.:format)          books#index
            POST   /books(.:format)          books#create
   new_book GET    /books/new(.:format)      books#new
  edit_book GET    /books/:id/edit(.:format) books#edit
       book GET    /books/:id(.:format)      books#show
            PATCH  /books/:id(.:format)      books#update
            PUT    /books/:id(.:format)      books#update
            DELETE /books/:id(.:format)      books#destroy
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  In the `/books/:id` path, we can take advantage of `:id` to get a book by it's id.

      What's that? You didn't know a book could have an id? Let's take a look.

  1.  Go back to Terminal and start `rails console`.

  1.  In the console, run `Book.first` to get the first book from your database.

  1.  Take a look at the output. It might be see, but at the beginning there's an id.

      ```
      #<Book id: 1, title: "why's (poignant) Guide to Ruby", ... >
      ```

      The first book in your database has an id of 1.

  1.  I wonder what id you second book will have...

      Run `Book.second` and look at the output.

      ```
      #<Book id: 2, title: "Oh, the Places You'll Go!", ... >
      ```

      The second book in your database has an id of ... 2!!!

  1.  By default, every book you create will be given a unique id, and it will be given an id in sequential order.

  1.  Exit the console.
{% endlist %}

{% highlight ruby %}
  $ rails c
  Loading development environment (Rails 5.0.0.1)
  >> Book.first
    Book Load (0.2ms)  SELECT  "books".* FROM "books" ORDER BY "books"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<Book id: 1, title: "why's (poignant) Guide to Ruby", author: "why the lucky stiff", price_cents: 100, created_at: "2016-12-26 15:51:15", updated_at: "2016-12-26 15:51:15", quantity: 500>

  >> Book.second
    Book Load (0.2ms)  SELECT  "books".* FROM "books" ORDER BY "books"."id" ASC LIMIT ? OFFSET ?  [["LIMIT", 1], ["OFFSET", 1]]
  => #<Book id: 2, title: "Oh, the Places You'll Go!", author: "Dr. Seuss", price_cents: 500, created_at: "2016-12-26 15:51:15", updated_at: "2016-12-26 15:51:15", quantity: 200>

  >> exit
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  How will the `/books/:id` path work in action?

  1.  Go back to Terminal and start your application's web server by running `rails server`.

  1.  `:id` can be replaced with specific ids. Since we know your first book's id is 1, we can go to `/books/1`.

  1.  Open your browser and go to [http://localhost:3000/books/1](http://localhost:3000/books/1).

  1.  An unknown action error?! Why does that look familiar... 😉

      You're trying to access the `BooksController` `show` action, but it doesn't exist. Let's make it.
{% endlist %}

{% highlight ruby %}
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
  Started GET "/books/1" for ::1 at 2016-12-26 12:07:18 -0500
    ActiveRecord::SchemaMigration Load (0.2ms)  SELECT "schema_migrations".* FROM "schema_migrations"

  AbstractController::ActionNotFound (The action 'show' could not be found for BooksController):

  ...
{% endhighlight %}
{% endsteps %}

![Browser showing Unknown action error: "The action 'show' could not be found for BooksController"](screenshot.jpg)

{% steps %}
{% list %}
  1.  Open your text editor and go to `app/controllers/books_controller.rb`.

  1.  After the index action, add the following:

      ```ruby
      def show
      end
      ```

  1.  Save your changes, and go to [http://localhost:3000/books/1](http://localhost:3000/books/1) again.

  1.  Now you get a different error:

      ```ruby
      ActionController::UnknownFormat (BooksController#show is missing a template for this request format and variant.
      ```

      We've seen this error too. You added the `show` action, but it doesn't have a template to go with it.
{% endlist %}

{% highlight ruby linenos %}
  class BooksController < ApplicationController
    def index
      @books = Book.all
    end

    def show
    end
  end
{% endhighlight %}
{% endsteps %}

![Browser showing ActionController::UnknownFormat error: "BooksController#show is missing a template for this request format and variant"](screenshot.jpg)

{% steps %}
{% list %}
  1.  Let's add the missing template.

  1.  Go back to Terminal and stop your application's web server by running `Ctrl-C`.

  1.  Now, run `touch app/views/books/show.html.erb` to create the empty template.

  1.  Restart your application's web server by running `rails server` and revisit [http://localhost:3000/books/1](http://localhost:3000/books/1).

  1.  Yay! No errors!

      Now that we have the `BooksController` `show` action rendering a template, we're ready to show a book's details.
{% endlist %}

{% highlight shell %}
  $ rails s

  ...

  ^CExiting

  $ touch app/views/books/show.html.erb

  $ rails s

  ...
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Before you can show a book's details, you have to figure out *which* book's details to show. How can we figure out which book to show?

  1.  When you visit [http://localhost:3000/books/1](http://localhost:3000/books/1), you send a request to your application's web server. Thanks to Rails routing, the book id (1) is included in that request.

      ```ruby
      Started GET "/books/1" for ::1 at 2016-12-26 16:12:07 -0500
      Processing by BooksController#show as HTML
        Parameters: {"id"=>"1"}
        Rendering books/show.html.erb within layouts/application
        Rendered books/show.html.erb within layouts/application (0.3ms)
      Completed 200 OK in 266ms (Views: 263.1ms | ActiveRecord: 0.0ms)
      ```

      It's tucked in there, but the id is inside the parameters hash.

      ```ruby
      Parameters: {"id"=>"1"}
      ```

  1.  Let's see how we can access the parameters hash in your `BooksController` `show` action.
{% endlist %}
{% endsteps %}
{% steps %} {% list %}
  1.  Open your text editor and go to `app/controllers/books_controller.rb`.

  1.  In your controllers, request parameters are available as `params`.

  1.  Inside the `show` method, add the following code:

      ```ruby
      @id = params[:id]
      ```
{% endlist %}

{% highlight ruby linenos %}
  class BooksController < ApplicationController
    def index
      @books = Book.all
    end

    def show
      @id = params[:id]
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  By defining `@id` in the `BooksController` `show` method, it's available in the `BooksController` `show` template.

  1.  Open `app/controllers/books/show.html.erb` in your text editor and add the following:

      ```ruby
      This book's id is <%= @id %>.
      ```

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  This book's id is <%= @id %>.
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that the `BooksController` `show` template is wired to up the render something, what do you expect to see if you visit [http://localhost:3000/books/1](http://localhost:3000/books/1)?

      Do you have an idea? Let's verify it!

  1.  Go to [http://localhost:3000/books/1](http://localhost:3000/books/1). What do you see??
{% endlist %}
{% endsteps %}

![Browser showing "/books/1" with the request book's id](screenshot.jpg)

{% steps %}
{% list %}
  1.  Did reality meet your expecations?

      The page renders "This book's id is 1." becuase you made a request from your browser with book id 1 ([http://localhost:3000/books/1](http://localhost:3000/books/1)).

      You're able to render the id because you grabbed it from the request parameters and assigned it to `@id` inside the `BooksController` `show` action.

  1.  What happens if you go to [http://localhost:3000/books/2](http://localhost:3000/books/2)?

      What about [http://localhost:3000/books/3](http://localhost:3000/books/3)?

      The new book id is rendered on every request because you wired up the template to show the requested book's id.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that we have the book id for the book we want to show, we can use it get that book from your application's database.

  1.  We've used a few methods to get books from the database. We've used `Book.all` to get all the books, and we've used `Book.first` to get the first book.

      But how do we get a book by it's id?

  1.  Let's explore on the `rails console`.

  1.  Go back to Terminal and quit your application's web server by running `Ctrl-C`. Then, start the `rails console`.

  1.  Now try running the following code:

      ```ruby
      Book.find(3)
      ```

  1.  What did it return? It returned the book in your application's database with id 3.

  1.  What do you get with `Book.find(1)` and `Book.find(5)`? You get the book with that id.

  1.  What happens if you do `Book.find(100)`?

      An error! `Book.find` returns an error when it doesn't find a book with the given book id.

  1.  So we can use `Book.find` to get books from your application's database with a given id. If a book doesn't exist with that id, we get an `ActiveRecord::RecordNotFound` error.

  1.  Exit the console and restart your application's web server.
{% endlist %}

{% highlight ruby %}
  $ rails server

  ...
  ^CExiting

  $ rails console
  Loading development environment (Rails 5.0.0.1)
  >> Book.find(3)
    Book Load (0.2ms)  SELECT  "books".* FROM "books" WHERE "books"."id" = ? LIMIT ?  [["id", 3], ["LIMIT", 1]]
  => #<Book id: 3, title: "1984", author: "George Orwell", price_cents: 0, created_at: "2016-12-26 15:51:15", updated_at: "2016-12-26 15:51:15", quantity: 200>

  >> Book.find(1)
    Book Load (0.2ms)  SELECT  "books".* FROM "books" WHERE "books"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  => #<Book id: 1, title: "why's (poignant) Guide to Ruby", author: "why the lucky stiff", price_cents: 100, created_at: "2016-12-26 15:51:15", updated_at: "2016-12-26 15:51:15", quantity: 500>

  >> Book.find(5)
    Book Load (0.2ms)  SELECT  "books".* FROM "books" WHERE "books"."id" = ? LIMIT ?  [["id", 5], ["LIMIT", 1]]
  => #<Book id: 5, title: "Life of Pi", author: "Yann Martel", price_cents: 750, created_at: "2016-12-26 15:51:15", updated_at: "2016-12-26 15:51:15", quantity: 50>

  >> Book.find(100)
    Book Load (0.2ms)  SELECT  "books".* FROM "books" WHERE "books"."id" = ? LIMIT ?  [["id", 100], ["LIMIT", 1]]
  ActiveRecord::RecordNotFound: Couldn't find Book with 'id'=100
	from /Users/alimi/.rvm/gems/ruby-2.3.1/gems/activerecord-5.0.0.1/lib/active_record/core.rb:173:in `find'
	from (irb):5
	from /Users/alimi/.rvm/gems/ruby-2.3.1/gems/railties-5.0.0.1/lib/rails/commands/console.rb:65:in `start'
	from /Users/alimi/.rvm/gems/ruby-2.3.1/gems/railties-5.0.0.1/lib/rails/commands/console_helper.rb:9:in `start'
	from /Users/alimi/.rvm/gems/ruby-2.3.1/gems/railties-5.0.0.1/lib/rails/commands/commands_tasks.rb:78:in `console'
	from /Users/alimi/.rvm/gems/ruby-2.3.1/gems/railties-5.0.0.1/lib/rails/commands/commands_tasks.rb:49:in `run_command!'
	from /Users/alimi/.rvm/gems/ruby-2.3.1/gems/railties-5.0.0.1/lib/rails/commands.rb:18:in `<top (required)>'
	from bin/rails:4:in `require'
	from bin/rails:4:in `<main>'

  >> exit

  $ rails server
  => Booting Puma
  ...
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's use our new knowledge of `Book.find` to get and show the requested book in the `BooksController` `show` action.

  1.  In your text editor, open the `BooksController`.

  1.  We've already grabbed the requested book id and set it to `@id`. Let's use that to find the requested book.

  1.  Inside the `show` method, add the following line:

      ```ruby
      @book = Book.find(@id)
      ```

  1.  Save your changes and go to [http://localhost:3000/books/1](http://localhost:3000/books/1).

      Did you notice anything different? I hope not, because we didn't update the template 😝
{% endlist %}

{% highlight ruby linenos %}
  class BooksController < ApplicationController
    def index
      @books = Book.all
    end

    def show
      @id = params[:id]
      @book = Book.find(@id)
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now, open the `BooksController` `show` template (`app/views/books/show.html.erb`).

  1.  Add the following line to the end of the file

      ```ruby
      This book is called <%= @book.title %>
      ```

  1.  Save your changes and go back to [http://localhost:3000/books/1](http://localhost:3000/books/1).
{% endlist %}

{% highlight ruby linenos %}
  This book's id is <%= @id %>.
  This book is called <%= @book.title %>.
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Yay! You got the request book and showed *some* of its information.

      Unfortunately, it's kinda smashed together on the page.

      Let's use a definition list to clean it up.

  1.  Open `app/views/books/show.html.erb` in your text editor and delete everything in the file.

      Yes, EVERYTHING.

      There's nothing wrong with what we've done so far, but adding the definition list is easier from scratch.

  1.  Now, add the following code to the file:

      ```ruby
      <dl>
        <dt>Id</dt>
        <dd><%= @book.id %></dd>

        <dt>Title</dt>
        <dd><%= @book.title %></dd>
      </dl>
      ```

      This is a definition list with a couple of terms: id and title. The terms are defined with values for the given book.

      Save your changes and go to [http://localhost:3000/books/1](http://localhost:3000/books/1) to see the results.
{% endlist %}

{% highlight ruby linenos %}
  <dl>
    <dt>Id</dt>
    <dd><%= @book.id %></dd>

    <dt>Title</dt>
    <dd><%= @book.title %></dd>
  </dl>
{% endhighlight %}
{% endsteps %}

![Browser show "/books/1" as a definition list](screenshot.jpg)

{% steps %}
{% list %}
  1.  Now that we have a definition list with the book's id and title, update it to include the rest of the book's information (author, price_cents, and quantity).
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What did you come up with? Your solution should look something like this:

      ```erb
      <dl>
        <dt>Id</dt>
        <dd><%= @book.id %></dd>

        <dt>Title</dt>
        <dd><%= @book.title %></dd>

        <dt>Author</dt>
        <dd><%= @book.author %></dd>

        <dt>Price Cents</dt>
        <dd><%= @book.price_cents %></dd>

        <dt>Quantity</dt>
        <dd><%= @book.quantity %></dd>
      </dl>
      ```

  1.  Update your solution to match this solution.
{% endlist %}

{% highlight ruby linenos %}
  <dl>
    <dt>Id</dt>
    <dd><%= @book.id %></dd>

    <dt>Title</dt>
    <dd><%= @book.title %></dd>

    <dt>Author</dt>
    <dd><%= @book.author %></dd>

    <dt>Price Cents</dt>
    <dd><%= @book.price_cents %></dd>

    <dt>Quantity</dt>
    <dd><%= @book.quantity %></dd>
  </dl>
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  The books details look great, but doesn't "Price Cents" look kinda weird?

      Do you ever wonder how much something would cost in pennies? Really?! I thought I was the only one!

      For most people, it would be easier to see the book's price in dollars. Fortunately, Rails has our back.

  1.  Rails provides a [`number_to_currency` method](http://api.rubyonrails.org/classes/ActionView/Helpers/NumberHelper.html#method-i-number_to_currency) that prints a number as currency.

      Let's see what happens when you use it.

  1.  Reopen `app/views/books/show.html.erb` and change the "Price Cents" definition from

      ```erb
      <dd><%= @book.price_cents %></dd>
      ```

      to

      ```erb
      <dd><%= number_to_currency(@book.price_cents) %>
      ```

  1.  Save your changes and revist [http://localhost:3000/books/1](http://localhost:3000/books/1).

{% highlight ruby linenos %}
  <dl>
    <dt>Id</dt>
    <dd><%= @book.id %></dd>

    <dt>Title</dt>
    <dd><%= @book.title %></dd>

    <dt>Author</dt>
    <dd><%= @book.author %></dd>

    <dt>Price Cents</dt>
    <dd><%= number_to_currency(@book.price_cents) %></dd>

    <dt>Quantity</dt>
    <dd><%= @book.quantity %></dd>
  </dl>
{% endhighlight %}
{% endlist %}
{% endsteps %}

![Browser showing "/books/1" with `number_to_currency(price_cents)`](screenshot.jpg)

{% steps %}
{% list %}
  1.  Looks great, right!

      Except *why's (poignant) Guide to Ruby* doesn't cost $100.00. We set the books price_cents to 100, and 100 cents is $1.00.

  1.  `number_to_currency` formats a number as a dollar amount, but the number has to be in dollars.

      We need to first convert `price_cents` to dollars before we can really use `number_to_currency`.

  1.  Reopen `app/views/books/show.html.erb` and change the "Price Cents" definition from

      ```erb
      <dd><%= number_to_currency(@book.price_cents) %></dd>
      ```

      to

      ```erb
      <dd><%= number_to_currency(@book.price_cents / 100.0) %></dd>
      ```

  1.  To convert from cents to dollars, we can simply divide by 100.

      (Actually we have to divide by 100.0 because [floating point math is fun](http://memecrunch.com/meme/ALWHK/if-you-use-floating-point-math/image.jpg))

      Then, the converted value is used by `number_to_currency`.

  1.  You can also go ahead and change the definition term from "Price Cents" to "Price".

  1.  Save your changes and try looking up a few of your books in your browser.
{% endlist %}

{% highlight ruby linenos %}
  <dl>
    <dt>Id</dt>
    <dd><%= @book.id %></dd>

    <dt>Title</dt>
    <dd><%= @book.title %></dd>

    <dt>Author</dt>
    <dd><%= @book.author %></dd>

    <dt>Price</dt>
    <dd><%= number_to_currency(@book.price_cents / 100.0) %></dd>

    <dt>Quantity</dt>
    <dd><%= @book.quantity %></dd>
  </dl>
{% endhighlight %}
{% endsteps %}

![Browser showing "/books/1" with a nicely formated price](screenshot.jpg)

{% aside %}
  We're making really good progress! Anyone can visit your bookstore to see what books you have, and they can learn a little about those books.

  I love that I can see what books you have and how much they cost, but what if I've never heard of one of your books before??

  Let's add book descriptions to help give just a little more info about your books.
{% endaside %}

{% steps %}
{% list %}
  1.  We can add descriptions to books by adding a `description` column to the `books` table.

  1.  Do you remember how we added columns to your application's database tables?

      We've done that through migrations. We created a migration to add the `books` table, and we changed that migration to add new columns.

      Now that you're bookstore application is coming along, we don't want to go back and edit past migrations. This is another one of those things you'll just have to trust me on.

      But how will we add the `description` column to the `books` table??

      A new migration!

  1.  Go back to Terminal and stop your application's web server by running `Ctrl-C`.

  1.  Now, run `rails generate migration add_description_to_books`.

      This creates a new timestamped migration file `db/migrate/CURRENT_TIMESTAMP_add_description_to_books.rb`.
{% endlist %}

{% highlight shell %}
  $ rails generate migration add_description_to_books
        invoke  active_record
        create    db/migrate/20161227020938_add_description_to_books.rb
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Open your new migration in your text editor.

  1.  Inside the change method, add the following line:

      ```ruby
      add_column :books, :description, :text
      ```

  1.  With this change, we're setting up the migration to add a column to the `books` table. The new column will be named `description` and it will store any amount of `text`.

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  class AddDescriptionToBooks < ActiveRecord::Migration[5.0]
    def change
      add_column :books, :description, :text
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now, go back to Terminal and run `rake db:migrate` to run your new migration against your application's database.
{% endlist %}

{% highlight shell %}
  $ rake db:migrate
  == 20161227020938 AddDescriptionToBooks: migrating ============================
  -- add_column(:books, :description, :text)
     -> 0.0049s
  == 20161227020938 AddDescriptionToBooks: migrated (0.0050s) ===================
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's take a look how this changes your application.

  1.  In Terminal, start `rails console`, get your first book and assign it to a variable called `my_first_book`.

  1.  Does the book look different?

      At the end, you should see a nil description.

      ```
      => #<Book id: 1, title: "why's (poignant) Guide to Ruby", ..., description: nil>
      ```

      `description` is nil because you just added it.

  1.  You can give `my_first_book` a description by running

      ```ruby
      my_first_book.update(description: "YOUR INSPIRING DESCRIPTION")
      ```

      Where YOUR INSPIRING DESCRIPTION is...YOUR INSPIRING DESCRIPTION.

      (Don't worry about your description being inspiring 😉)

  1.  After you've added YOUR INSPIRING DESCRIPTION to `my_first_book`, you can run `my_first_book.description` to see the new description.

  1.  Go ahead and add descriptions for the of rest your books. Your application's database should have seven books, which means you have six descriptions to write.

  1.  When you're done, exit the `rails console` and restart your application's web server by running `rails server`.
{% endlist %}

{% highlight ruby %}
  $ rails console
  Loading development environment (Rails 5.0.0.1)

  >> my_first_book = Book.first

  >> my_first_book.update(description: "Chunky Bacon")
     (0.1ms)  begin transaction
    SQL (0.6ms)  UPDATE "books" SET "updated_at" = ?, "description" = ? WHERE "books"."id" = ?  [["updated_at", 2016-12-27 02:28:28 UTC], ["description", "Chunky Bacon"], ["id", 1]]
     (2.3ms)  commit transaction
  => true

  >> my_first_book.description
  => "Chunky Bacon"

  ...

  >> exit
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that your books have descriptions, you can share them with the WORLD!

  1.  Reopen `app/views/books/show.html.erb` and add the book's description to the end of the definition list.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What did you come up with? Here's the complete template.

  1.  Save your changes and view your beautiful descriptions in your browser.
{% endlist %}

{% highlight ruby linenos %}
  <dl>
    <dt>Id</dt>
    <dd><%= @book.id %></dd>

    <dt>Title</dt>
    <dd><%= @book.title %></dd>

    <dt>Author</dt>
    <dd><%= @book.author %></dd>

    <dt>Price</dt>
    <dd><%= number_to_currency(@book.price_cents / 100.0) %></dd>

    <dt>Quantity</dt>
    <dd><%= @book.quantity %></dd>

    <dt>Description</dt>
    <dd><%= @book.description %></dd>
  </dl>
{% endhighlight %}
{% endsteps %}

![Browser showing "/books/1" with a lovely description of "why's (poignant) Guide to Ruby"](screenshot.jpg)

{% steps %}
{% list %}
  1.  Now you have a lovely books index and lots of individual book views, but there is no relationship between the two. Let's link them!

  1.  Since you have a books index with a little bit of book information and book views lots of specific information, it makes sense to link from the books index to specific book pages.

      A visitor to your bookstore viewing a book could click on it to get more detailed information.

      We'll update the index so book titles link to their book's page.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  In HTML, you add links using anchor elements (`<a>` tags). Anchor elements link to other pages by their `href` attribute.

      Fortunately, Rails gives us a convience method to abstract away some of that work.

  1.  In your text editor, open `app/views/books/index.html.erb`.

  1.  Change the list item that renders book titles and authors to this:

      ```erb
      <li>
        <%= link_to(book.title, book_path(book)) %> by <%= book.author %>
      </li>
      ```

      Rails gives us a `link_to` method we can use to create anchor elements.

      First, you give it the text for the link. In this case, we want to use the book's title as the link text.

      Then, you give it the path for the link. We want the link to go to `/books/:id`, but we passed it `book_path(book)`. `book_path(book)` is another Rails method. Long story short, it generates `/books/:id` for the given book.

  1.  Save your changes and go to [http://localhost:3000/books](http://localhost:3000/books). Try clicking all the links!

      When you're done, stop your application's web server.
{% endlist %}

{% highlight ruby linenos %}
  <h1>Welcome to My Super Rad Bookstore!</h1>

  <ul>
    <% @books.each do |book| %>
      <li>
        <%= link_to(book.title, book_path(book)) %> by <%= book.author %>
      </li>
    <% end %>
  </ul>
{% endhighlight %}
{% endsteps %}

![Browser showing books index with all the links!](screenshot.jpg)
