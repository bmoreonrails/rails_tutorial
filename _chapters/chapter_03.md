---
url: 3.html
number: 3
title: Viewing Data in the Browser
layout: rails_tutorial
---

{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}

{% aside %}
  You've added a lot of books to your bookstore, but wouldn't it be nice if you could actually *see* them in your browser? You are building a web application after all. 😉
{% endaside %}

{% steps %}
{% list %}
  1.  Before you can see your books, you'll need make some changes. Open the `bookstore` directory in your text editor.

  1.  Now open `config/routes.rb` and add the following line inside the only block in the file:

      ```ruby
      resources :books
      ```

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
    Rails.application.routes.draw do
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
      resources :books
    end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Go back to Terminal and make sure you're in the `bookstore` directory.

  1.  Run `rake routes`.

      You should see a bunch of stuff about books along the lines of...

      ```shell
         Prefix Verb   URI Pattern               Controller#Action
          books GET    /books(.:format)          books#index
                POST   /books(.:format)          books#create
       new_book GET    /books/new(.:format)      books#new
      edit_book GET    /books/:id/edit(.:format) books#edit
           book GET    /books/:id(.:format)      books#show
                PATCH  /books/:id(.:format)      books#update
                PUT    /books/:id(.:format)      books#update
                DELETE /books/:id(.:format)      books#destroy
      ```

      `rake routes` prints a table of the available routes in your application. Since you added `books` as a resource in `config/routes.rb`, your application now has a bunch of book routes.

        The `URI Pattern` column in the table tells you how to reach the routes from a browser.

        For example, when your application is running locally you can reach `/books` by going to `http://localhost:3000/books`.
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
  Let's trying going to the `/books` route.

  1.  In Terminal, run `rails server` to start your application's web server.

  1.  Now, open your favorite web browser and go to [http://localhost:3000/books](http://localhost:3000/books).

      If I had to guess, you probably got an error 🙃
{% endlist %}

{% highlight shell %}
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
  Started GET "/books" for ::1 at 2016-11-28 22:24:04 -0500
    ActiveRecord::SchemaMigration Load (0.4ms)  SELECT "schema_migrations".* FROM "schema_migrations"

  ActionController::RoutingError (uninitialized constant BooksController):
  ...
{% endhighlight %}
{% endsteps %}

![Browser showing Routing Error: "uninitialized constant BooksController"]({{ site.baseurl}}/assets/images/uninitialized_constant_BooksController.png){: .screenshot}

{% steps %}
{% list %}
  We've run into a problem, but Rails is giving us some info to help us understand what's going on.

  You're getting a `Routing Error` because there's an `uninitialized constant` called `BooksController`. Rails is expecting your application to have a `BooksController`, but it doesn't have one. Let's create it!

  1.  Go back to Terminal and stop your rails server by running `Ctrl-c`.

  1.  Create the `BooksController` by running `touch app/controllers/books_controller.rb`.

  1.  Restart your web server by running `rails server`, and try going to [http://localhost:3000/books](http://localhost:3000/books) again.

      That still errored, didn't it? But hey, at least you got a new error!
{% endlist %}

{% highlight shell %}
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
  ...
  ^CExiting

  $ touch app/controllers/books_controller.rb

  $ rails server
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
  ...
  Use Ctrl-C to stop
  Started GET "/books" for ::1 at 2016-11-29 20:55:26 -0500
    ActiveRecord::SchemaMigration Load (0.2ms)  SELECT "schema_migrations".* FROM "schema_migrations"

  LoadError (Unable to autoload constant BooksController, expected /Users/awesomesauce/Projects/bookstore/app/controllers/books_controller.rb to define it):
{% endhighlight %}
{% endsteps %}

{% aside %}
Now you got a `LoadError` because `BooksController` isn't defined.

![Browser showing LoadError: "LoadError in BooksController#index
  Unable to autoload constant BooksController, expected /Users/awesomesauce/Projects/bookstore/app/controllers/books_controller.rb to define it"]({{site.baseurl}}/assets/images/LoadError_in_BooksController_index.png){: .screenshot}

Remember the `touch` command you used to create the `BooksController`?

```shell
touch app/controllers/books_controller.rb
```

It created the `BooksController` file, but the file is empty. Don't believe me? Let's take a look at it.
{% endaside %}

{% steps %}
{% list %}
  1.  If your text editor isn't already open, open it and go to the `bookstore` directory.

  1.  Now, open `app/controllers/books_controller.rb`.

  1.  See, it's empty 😝

      `touch` creates empty files. You used it to create an empty file called `app/controllers/books_controller.rb`.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  The error you got said something about there being a missing constant `BooksController`. Let's add it.

  1.  Add the following code to `app/controllers/books_controller.rb`:

      ```ruby
      class BooksController < ApplicationController
      end
      ```

      That should define the constant Rails was looking for.

  1.  Save the file and try going to [http://localhost:3000/books](http://localhost:3000/books) again.

      New error!
{% endlist %}

{% highlight ruby linenos %}
class BooksController < ApplicationController
end
{% endhighlight %}
{% endsteps %}

![Browser showing Unknown action error: "The action 'index' could not be found for BooksController"]({{site.baseurl}}/assets/images/unknown_action.png){: .screenshot}

{% steps %}
{% list %}
  This new error is telling us that your `BooksController` doesn't have an `index` action. That kinda makes sense - we didn't add very much code to the `BooksController`. But why does it care that the `index` action is missing?

  Remember the routing table? Kinda? Don't worry, it's fuzzy for me too. Let's pull it up again.

  1.  Go back to Terminal and stop the `rails server` by running `Ctrl-c`.

  1.  Now, run `rake routes`. Voila - the routing table.

      The first entry in the routing table is for the `/books` path.

      ```shell
      Prefix Verb   URI Pattern       Controller#Action
       books GET    /books(.:format)  books#index
      ```

      The last column tells us which controller and action get run when we go to the `/books` path.

      The URI Pattern `/books(.:format)` maps to the Controller#Action pair of `books#index`. This tells us requests to the `/books` path will be routed to the `BooksController` `index` action.

      Clear as mud, right? Don't worry, it'll make more sense later.

  1.  Now that we (kinda) know why we're trying to run the `index` action, let's add it.

      Before we go on, restart your web server by running `rails server`.
{% endlist %}

{% highlight shell %}
  $ rails server
  => Booting Puma
  ...
  ^CExiting

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

  $ rails server
  => Booting Puma
  ...
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  In your text editor, open the `BooksController` and add the following method inside the `BooksController` class.

      ```ruby
      def index
      end
      ```

  1.  Save your changes and try going to [http://localhost:3000/books](http://localhost:3000/books) again.

      ![Aaugh!]({{ site.baseurl }}/assets/images/aaugh.gif)
{% endlist %}

{% highlight ruby linenos %}
  class BooksController < ApplicationController
    def index
    end
  end
{% endhighlight %}
{% endsteps %}

![Browser showing ActionController::UnknownFormat error: "ActionController::UnknownFormat in BooksController#index - BooksController#index is missing a template for this request format and variant."]({{site.baseurl}}/assets/images/ActionController_UnknownFormat.png){: .screenshot}

{% aside %}
### Progress!

We're making progress.

...

Seriously!

The `/books` path is sucessfully reaching the `BooksController` `index` action, but we're getting an error because we're missing a template.

A template is a view that get's rendered at the end of a controller action. In this case, Rails is expecting your application to have an `index` template to go with the `BooksController` `index` action.

Let's make that happen!
{% endaside %}


{% steps %}
{% list %}
  1.  Stop your `rails server` by running `Ctrl-c`.

  1.  All templates live in the `app/views` directory.

      `app/views` will have directories for each of the controllers in your application. By default, a controller's template directory will be the name of the controller...minus the controller.

      For example, the templates for the `BooksController` will live in the `app/views/books` directory.

      Create the `BooksController` template directory by running `mkdir app/views/books`.

  1.  Now, create the template for the `BooksController`'s `index` action by running `touch app/views/books/index.html.erb`.

  1.  Restart your web server.

      (Remember? Start your web server by running `rails server`.)

  1.  Now, try going to [http://localhost:3000/books](http://localhost:3000/books).

      The page might be blank, but that means no errors!
{% endlist %}

{% highlight shell %}
  $ rails server
  => Booting Puma
  ...
  ^CExiting

  $ mkdir app/views/books

  $ touch app/views/books/index.html.erb

  $ rails server
  ...
  Started GET "/books" for ::1 at 2016-11-29 22:15:07 -0500
    ActiveRecord::SchemaMigration Load (0.2ms)  SELECT "schema_migrations".* FROM "schema_migrations"
  Processing by BooksController#index as HTML
    Rendering books/index.html.erb within layouts/application
    Rendered books/index.html.erb within layouts/application (1.7ms)
  Completed 200 OK in 645ms (Views: 631.6ms | ActiveRecord: 0.0ms)
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  Ok, let's make this page a little more interesting.

  1.  In your text editor, open the template we made (`app/views/books/index.html.erb`) and add the following line:

      ```erb
      <h1>Welcome to My Super Rad Bookstore!</h1>
      ```

  1.  Save your changes and go to [http://localhost:3000/books](http://localhost:3000/books) again.

      Yay! 🎉
{% endlist %}

{% highlight erb linenos %}
  <h1>Welcome to My Super Rad Bookstore!</h1>
{% endhighlight %}
{% endsteps %}

![Browser showing the index page rendering your html"]({{site.baseurl}}/assets/images/welcome_to_my_super_rad_bookstore.png){: .screenshot}

{% aside %}
### Listing All the Things

You've been going to the `/books` path a bunch and as a result you've been running the `BooksController` `index` action a lot.

You can think of an `index` action in a Rails application as the index of a book. It's used to list all of a controller's resources.

Since we're dealing with the `BooksController`, this `index` action is going to list all of your bookstore's books.
{% endaside %}

{% steps %}
{% list %}
  Before you can show all of your books in the browser, you have to make the books data available through your application's `BooksController index` action.

  1.  In your text editor, open `app/controllers/books_controller.rb`. Inside the `index` method, add the following line:

      ```ruby
      @books = Book.all
      ```

      That line might look a little familiar. In Chapter 2, we used `Book.all` to list all your books on the `rails console`.

      We're using the same method again so we can render your books in the browser.

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  class BooksController < ApplicationController
    def index
      @books = Book.all
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  By making that change to the `BooksController` `index` action, you've made book data available to your `index` template.

  Let's see what you can do with it.

  1.  In your text editor, open `app/views/books/index.html.erb` and add the following line to the end of the file:

      ```erb
      <%= @books[0].title %>
      ```

  1.  Save your changes and try going to [http://localhost:3000/books](http://localhost:3000/books) again.
{% endlist %}

{% highlight erb linenos %}
  <h1>Welcome to My Super Rad Bookstore!</h1>
  <%= @books[0].title %>
{% endhighlight %}
{% endsteps %}

![Browser showing /books view with the application's first book title]({{site.baseurl}}/assets/images/book_list_1.png){: .screenshot}

{% aside %}
Your application's data might be a little different than mine, but you're probably seeing the title to *MY* favorite book. Yippie!

(If your data is different, you're seeing the title of some other book...sigh 😉)

You had to do a couple of things to get that title to show up in your browser.

First in the `BooksController` `index` method, you defined an instance variable `@books` and assigned it all the books in your application.

```ruby
class BooksController < ApplicationController
  def index
    @books = Book.all
  end
end
```

Then in the associated `index` template (`app/views/books/index.html.erb`), you used some funny looking syntax to get the first book and show it's title.

```erb
<h1>Welcome to My Super Rad Bookstore!</h1>
<%= @books[0].title %>
```

Let's focus on that funny looking syntax for a few minutes.
{% endaside %}

{% steps %}
{% list %}
  1.  In your text editor, open `app/views/books/index.html.erb`.

  1.  Remember that line you added to the end of the file?

      ```erb
      <%= @books[0].title %>
      ```

      Change it so it looks like this:

      ```erb
      <%= @books[1].title %>
      ```

  1.  Can you guess what this will change? Reload [http://localhost:3000/books](http://localhost:3000/books) to see what happens.
{% endlist %}
{% highlight erb linenos %}
  <h1>Welcome to My Super Rad Bookstore!</h1>
  <%= @books[0].title %>
{% endhighlight %}
{% endsteps %}

![Browser showing /books view with the application's first book title]({{site.baseurl}}/assets/images/book_list_2.png){: .screenshot}

{% aside %}
You're seeing a different book title, aren't you?

You used `@books[0]` to get the first book from your database, and you changed it to `@books[1]` to get the next book.

I bet you could get all the books to render on the `index` template...
{% endaside %}

{% steps %}
{% list %}
  1.  Spend some time and see if you can get all the book titles to render. If you've been following along with the tutorial, you should have seven books in your application.

      If you know some HTML, try listing the titles in an unordered list.

      Don't know very much HTML? Don't worry about it - you'll get familiar with it reaaaal soon. Just focus on getting the titles to render.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What did you come up with?

      One way may have been to list out each book like this:

      ```erb
      <%= @books[0].title %>
      <%= @books[1].title %>
      <%= @books[2].title %>
      <%= @books[3].title %>
      <%= @books[4].title %>
      <%= @books[5].title %>
      <%= @books[6].title %>
      ```

      That renders all the book titles, but they end up getting rendered on a single line.

  1.  If you know some HTML, you may have thrown in a few `br`s to give the titles some space like this:

      ```erb
      <%= @books[0].title %>
      <br>
      <%= @books[1].title %>
      <br>
      <%= @books[2].title %>
      <br>
      <%= @books[3].title %>
      <br>
      <%= @books[4].title %>
      <br>
      <%= @books[5].title %>
      <br>
      <%= @books[6].title %>
      ```
  1.  Better yet, you may have even used an unordered list:

      ```erb
      <ul>
        <li><%= @books[0].title %></li>
        <li><%= @books[1].title %></li>
        <li><%= @books[2].title %></li>
        <li><%= @books[3].title %></li>
        <li><%= @books[4].title %></li>
        <li><%= @books[5].title %></li>
        <li><%= @books[6].title %></li>
      </ul>
      ```
  1.  If you used an unordered list, great!

      If not, no worries - update your solution to use an unordered list.
{% endlist %}

{% highlight erb linenos %}
  <h1>Welcome to My Super Rad Bookstore!</h1>

  <ul>
    <li><%= @books[0].title %></li>
    <li><%= @books[1].title %></li>
    <li><%= @books[2].title %></li>
    <li><%= @books[3].title %></li>
    <li><%= @books[4].title %></li>
    <li><%= @books[5].title %></li>
    <li><%= @books[6].title %></li>
  </ul>
{% endhighlight %}
{% endsteps %}

![Browser showing /books view with the application's first book title]({{site.baseurl}}/assets/images/book_list_3.png){: .screenshot}

{% aside %}
Yay! Book titles!

But doesn't a lot of that code in your template look just a little...repetitive?

```erb
<li><%= @books[0].title %></li>
<li><%= @books[1].title %></li>
<li><%= @books[2].title %></li>
...
```
*There has to be a better way!?*

There is! 😄

Remember when you defined `@books` in the `BooksController` `index` method?

```ruby
@books = Book.all
```

You defined `@books` to be a collection of all the books in your application's database. For our purposes, we can treat this collection like a [Ruby Array](http://ruby-doc.org/core-2.3.1/Array.html).

You can get each item of a Ruby array by its index, and the first item starts at index 0.

Does that sound familiar? It's what you used to render the book titles.

```ruby
  <li><%= @books[0].title %></li>
  <li><%= @books[1].title %></li>
  ...
```

This works well, but it's a very manual process. You have to individually access each book to render its title. It also depends on you knowing how many books there are in the database.

In Ruby, we don't have to access each book individually like this. We can use Array's [`each`](http://ruby-doc.org/core-2.3.1/Array.html#method-i-each) method to help us out.

Let's see what that would look like.
{% endaside %}

{% protip %}
You might remember reading about arrays in the [Ruby in 100 minutes](http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html#7.-arrays) tutorial. Arrays are most commonly used for storing a list or collection of things.
{% endprotip %}

{% steps %}
{% list %}
  1.  Go back to your terminal and quit the `rails server` by running `Ctrl-c`.

  1.  Now, start the `rails console` by running...`rails console`.

  1.  Run the following code:

      ```ruby
      books = Book.all
      ```

      You now have a `books` variable that's been assigned all the books in your application's database. `books` can be thought of as a Ruby Array.

      Sound familiar 😉

  1.  Now, try running the following:

      ```ruby
      books.each { |book| puts book.title }
      ```

      What happened?

      You used the `each` method to iterate over each book and print its title.

  1.  The curly braces ({}) after `each` are the start and end of a block. We've seen the other block notation before - it starts with a `do` and ends with an `end`.

      Try running the following:

      ```ruby
      books.each do |book|
        puts book.title
      end
      ```

      The syntax might be different, but it's the same result - each of the book titles are printed.

  1.  At the beginning of the block, you have a couple of pipes surronding `book`

      ```ruby
      books.each { |book| ... }
      ```

      This is called a block parameter. In this case, it lets you access each book so you can print its title.

      Before, we would've manually gone through each book to print its title.

      ```ruby
      puts books[0].title
      puts books[1].title
      ...
      ```

      Now, `each` lets us do it in a lot less code.

      ```ruby
      books.each { |book| puts book.title }
      ```

  1.  Try playing with the `each` method to see what else you can print out. You should be able print things like the book ids, authors, and quantities.

  1.  When you're done exploring, run `exit` to exit the `rails console`. Then, restart the `rails server`.
{% endlist %}

{% highlight ruby %}
  >> books = Book.all
    Book Load (1.4ms)  SELECT "books".* FROM "books"
  => #<ActiveRecord::Relation [#<Book id: 1, title: "why's (poignant) Guide to Ruby", author: "why the lucky stiff", price_cents: 100, created_at: "2016-11-24 03:30:53", updated_at: "2016-11-24 03:30:53", quantity: 500>, #<Book id: 2, title: "Oh, the Places You'll Go!", author: "Dr. Seuss", price_cents: 500, created_at: "2016-11-24 03:33:22", updated_at: "2016-11-24 03:33:22", quantity: 200>, #<Book id: 4, title: "1984", author: "George Orwell", price_cents: 0, created_at: "2016-11-30 01:35:44", updated_at: "2016-11-30 01:35:44", quantity: 200>, #<Book id: 5, title: "The Sound and The Fury", author: "William Faulkner", price_cents: 500, created_at: "2016-11-30 01:36:47", updated_at: "2016-11-30 01:36:47", quantity: 150>, #<Book id: 6, title: "Life of Pi", author: "Yann Martel", price_cents: 750, created_at: "2016-11-30 01:37:40", updated_at: "2016-11-30 01:37:40", quantity: 50>, #<Book id: 7, title: "The Kite Runner", author: "Khaled Hosseini", price_cents: 600, created_at: "2016-11-30 01:38:28", updated_at: "2016-11-30 01:38:28", quantity: 23>, #<Book id: 8, title: "Ender's Game", author: "Orson Scott Card", price_cents: 42, created_at: "2016-11-30 01:40:20", updated_at: "2016-11-30 01:40:20", quantity: 1000>]>

  >> books.each { |book| puts book.title }
  why's (poignant) Guide to Ruby
  Oh, the Places You'll Go!
  1984
  The Sound and The Fury
  Life of Pi
  The Kite Runner
  Ender's Game
  => [#<Book id: 1, title: "why's (poignant) Guide to Ruby", author: "why the lucky stiff", price_cents: 100, created_at: "2016-11-24 03:30:53", updated_at: "2016-11-24 03:30:53", quantity: 500>, #<Book id: 2, title: "Oh, the Places You'll Go!", author: "Dr. Seuss", price_cents: 500, created_at: "2016-11-24 03:33:22", updated_at: "2016-11-24 03:33:22", quantity: 200>, #<Book id: 4, title: "1984", author: "George Orwell", price_cents: 0, created_at: "2016-11-30 01:35:44", updated_at: "2016-11-30 01:35:44", quantity: 200>, #<Book id: 5, title: "The Sound and The Fury", author: "William Faulkner", price_cents: 500, created_at: "2016-11-30 01:36:47", updated_at: "2016-11-30 01:36:47", quantity: 150>, #<Book id: 6, title: "Life of Pi", author: "Yann Martel", price_cents: 750, created_at: "2016-11-30 01:37:40", updated_at: "2016-11-30 01:37:40", quantity: 50>, #<Book id: 7, title: "The Kite Runner", author: "Khaled Hosseini", price_cents: 600, created_at: "2016-11-30 01:38:28", updated_at: "2016-11-30 01:38:28", quantity: 23>, #<Book id: 8, title: "Ender's Game", author: "Orson Scott Card", price_cents: 42, created_at: "2016-11-30 01:40:20", updated_at: "2016-11-30 01:40:20", quantity: 1000>]

  >> books.each do |book|
  ?>     puts book.title
  >>   end
  why's (poignant) Guide to Ruby
  Oh, the Places You'll Go!
  1984
  The Sound and The Fury
  Life of Pi
  The Kite Runner
  Ender's Game
  => [#<Book id: 1, title: "why's (poignant) Guide to Ruby", author: "why the lucky stiff", price_cents: 100, created_at: "2016-11-24 03:30:53", updated_at: "2016-11-24 03:30:53", quantity: 500>, #<Book id: 2, title: "Oh, the Places You'll Go!", author: "Dr. Seuss", price_cents: 500, created_at: "2016-11-24 03:33:22", updated_at: "2016-11-24 03:33:22", quantity: 200>, #<Book id: 4, title: "1984", author: "George Orwell", price_cents: 0, created_at: "2016-11-30 01:35:44", updated_at: "2016-11-30 01:35:44", quantity: 200>, #<Book id: 5, title: "The Sound and The Fury", author: "William Faulkner", price_cents: 500, created_at: "2016-11-30 01:36:47", updated_at: "2016-11-30 01:36:47", quantity: 150>, #<Book id: 6, title: "Life of Pi", author: "Yann Martel", price_cents: 750, created_at: "2016-11-30 01:37:40", updated_at: "2016-11-30 01:37:40", quantity: 50>, #<Book id: 7, title: "The Kite Runner", author: "Khaled Hosseini", price_cents: 600, created_at: "2016-11-30 01:38:28", updated_at: "2016-11-30 01:38:28", quantity: 23>, #<Book id: 8, title: "Ender's Game", author: "Orson Scott Card", price_cents: 42, created_at: "2016-11-30 01:40:20", updated_at: "2016-11-30 01:40:20", quantity: 1000>]
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  Let's put this new knowledge to work.

  1.  In your text editor, open `app/views/books/index.html.erb`.

  1.  At the end of the file, add a new, empty unordered list. It should look like this:

      ```html
      <ul>
      </ul>
      ```

      Inside the new unordered list, we'll want to iterate over all the books assigned to `@books` and render a list item for each book title.

      We can iterate over `@books` by using the `each` method.

      You've used the `each` method on the `rails console`, but how will you use it in your template?

  1.  To run Ruby code in your template, you have to put it inside some funny looking brackets:

      ```erb
      <% ... %>
      ```

      Everything inside `<% %>` will get run in your template.

      We've seen something similar before. Remember how you got the book titles to render?

      ```erb
      <%= @books[0].title %>
      ```

      The syntax is slightly different. `<%= %>` runs Ruby code *and* renders the result in your template.

      `<% %>` on the other hand *only* runs Ruby code. It *does not* render the
      result of that code.

      With that in mind, add the following code inside your new unordered list:

      ```erb
      <% @books.each do |book| %>
      <% end %>
      ```

  1.  Save your changes and revisit [http://localhost:3000/books](http://localhost:3000/books). Did anything change?

      Nothing changed! You're running `@books.each` in your template, but since it's inside `<% %>` the result of that block isn't rendered.
{% endlist %}

{% highlight erb linenos %}
  <h1>Welcome to My Super Rad Bookstore!</h1>

  <ul>
    <li><%= @books[0].title %></li>
    <li><%= @books[1].title %></li>
    <li><%= @books[2].title %></li>
    <li><%= @books[3].title %></li>
    <li><%= @books[4].title %></li>
    <li><%= @books[5].title %></li>
    <li><%= @books[6].title %></li>
  </ul>

  <ul>
    <% @books.each do |book| %>
    <% end %>
  </ul>
{% endhighlight %}
{% endsteps %}

{% protip %}
You can use that funny looking syntax in your templates because they're [ERB templates](http://guides.rubyonrails.org/v5.0.0/action_view_overview.html#templates).

ERB templates are available in all Rails applications. Any file that ends in `.html.erb` is an ERB template.
{% endprotip %}

{% steps %}
{% list %}
  Now that you have your block set up, you're ready to render some book titles.

  1.  Spend a few minutes and try to get each book title to render as a list item inside the block.

      Remember, inside the block each book is availble to you as `book`.

      When you're done, you should see two identical unordered lists on [http://localhost:3000/books](http://localhost:3000/books).
{% endlist %}
{% endsteps %}

![Browser showing /books view with two unordered lists]({{site.baseurl}}/assets/images/book_list_4.png){: .screenshot}

{% steps %}
{% list %}
  1.  Did you get it?! Your new unordered list should look something like this:

      ```erb
      <ul>
        <% @books.each do |book| %>
          <li><%= book.title %></li>
        <% end %>
      </ul>
      ```

      Update your solution to match this solution.

  1.  Compare your two unordered lists. They both end in the same result, but one required a little more effort.

      ```erb
      <ul>
        <li><%= @books[0].title %></li>
        <li><%= @books[1].title %></li>
        <li><%= @books[2].title %></li>
        <li><%= @books[3].title %></li>
        <li><%= @books[4].title %></li>
        <li><%= @books[5].title %></li>
        <li><%= @books[6].title %></li>
      </ul>

      <ul>
        <% @books.each do |book| %>
          <li><%= book.title %></li>
        <% end %>
      </ul>
      ```

      We can take advantage of the ability to run Ruby code inside Rails templates to do things quickly.

  1.  You don't need to show both unordered lists, so go ahead and remove the first one.
{% endlist %}

{% highlight erb linenos %}
  <h1>Welcome to My Super Rad Bookstore!</h1>

  <ul>
    <% @books.each do |book| %>
      <li><%= book.title %></li>
    <% end %>
  </ul>
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  Now that you have book titles rendering, let's try adding some information.

  1.  Update the books unordered lists so it includes the book author next to each author like this:

      why's (poignant) Guide to Ruby by why the lucky stiff
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What did you come up with? Compare your solution with people around you.

      Inside the `@books.each` block, you should've edited the list item so it renders each book's author next to its title.

      ```erb
      <li><%= book.title %> by <%= book.author %></li>
      ```

  1.  Update your solution to match this solution.

  1.  When you're done, stop your application's web server by running `Ctrl-C`.
{% endlist %}

{% highlight erb linenos %}
  <h1>Welcome to My Super Rad Bookstore!</h1>

  <ul>
    <% @books.each do |book| %>
      <li><%= book.title %> by <%= book.author %></li>
    <% end %>
  </ul>
{% endhighlight %}
{% endsteps %}
