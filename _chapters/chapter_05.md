---
url: 5.html
number: 5
title: Creating Books Through the Browser
layout: rails_tutorial
---

{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}


{% aside %}
  So far you've created books on the `rails console`. It works, but it's not best experience. In most web applications, you enter data through...the web.

  Your bookstore *is* a web application, so let's treat it like one. Let's set up your application so you can create books from your browser.
{% endaside %}

{% steps %}
{% list %}
  1.  Open Terminal and go to the `bookstore` directory.

  1.  Now, run `rake routes`.

  1.  We've worked through a couple of the books routes. First, we used the `index` action to list all your application's books. Then, we used the `show` action to show details for a given book.

      Now, we'll use the `new` action to create a new book.

  1.  The path for the `new` action is `/books/new`.

      ```shell
      new_book GET    /books/new(.:format)      books#new
      ```

  1. Let's try going to that path.
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
  1.  In Terminal, start your application's web server by running `rails server`.

  1.  Now, try going to [http://localhost:3000/books/new](http://localhost:3000/books/new).

  1.  You got an error, but doesn't it look familiar?

      Why you think you got an Unknown action error?
{% endlist %}

{% highlight shell %}
  $ rails server
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
  => Run `rails server -h` for more startup options
{% endhighlight %}
{% endsteps %}

![Browser showing Unknown action error: "The action 'new' could not be found for BooksController"](screenshot.jpg)

{% steps %}
{% list %}
  1.  The error message gives you a hint as to why you're getting an Unknown action error.

      ```
      The action 'new' could not be found for BooksController
      ```

      When you make a request to `/books/new`, your request gets routed to the `BooksController` `new` action. What does your `BooksController` look like? Does it have a `new` action?

      The `BooksController` doesn't have a `new` action because we haven't defined it yet.

  1.  In your text editor, open the `BooksController` (`app/controllers/boooks_controller.rb`).

  1.  At the end of the `BooksController` add the `new` method.

      ```ruby
      def new
      end
      ```

  1.  Save your changes, and revisit [http://localhost:3000/books/new](http://localhost:3000/books/new).
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

    def new
    end
  end
{% endhighlight %}
{% endsteps %}

![Browser showing ActionController::UnknownFormat error: "BooksController#new is missing a template for this request format and variant."](screenshot.jpg)

{% steps %}
{% list %}
  1.  Another error, but it should also look familiar.

      ```
      BooksController#new is missing a template for this request format and variant.
      ```

      You've added the `new` method to the BooksController, but you haven't created the `new` action's template.

      Let's add it!

  1.  Go back to terminal and stop your application's web server by running `Ctrl-C`.

  1.  Now, run `touch app/views/books/new.html.erb` to create the `new` action's template.

  1.  Restart your application's web server and revisit [http://localhost:3000/books/new](http://localhost:3000/books/new). What do you see?

      A blank page! 🎉
{% endlist %}

{% highlight shell %}
  $ rails server
  ...
  ^CExiting

  $ touch app/views/books/new.html.erb

  $ rails server
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
  => Run `rails server -h` for more startup options
{% endhighlight %}
{% endsteps %}

{% aside %}
  Data is usually added to web applications through forms.

  You probably have never noticed them, but forms are everywhere on the internet. When you login to a site, you enter your credentials into a form. When you post a status on Facebook, you enter your status into a form. When you're Googling for programming resources, you enter your search terms into a form.

  After you add your data to a form, you submit it by clicking a submit button. For example, a login form might have a submit button that says "Login".

  We're going to use forms to create new books in your application.
{% endaside %}

{% steps %}
{% list %}
  1.  In your text editor, open `app/views/books/new.html.erb` and add the following code:

      ```ruby
      <%= form_for(@book) do |f| %>
      <% end %>
      ```

  1.  `form_for` is a method provided by Rails. It provides a consistent interface to build forms inside Rails applications.

      Here, we're passing `@book` to `form_for` because we want to create a form for a book.

      `form_for` takes a block as its last argument. We haven't done anything interesting inside the block, but that'll change soon :)

  1.  Save your changes and revisit [http://localhost:3000/books/new](http://localhost:3000/books/new).
{% endlist %}

{% highlight ruby linenos %}
  <%= form_for(@book) do |f| %>
  <% end %>
{% endhighlight %}
{% endsteps %}

![Browser showing Argument Error in Books#new: "First argument in form cannot contain nil or be empty"](screenshot.jpg)

{% steps %}
{% list %}
  1.  Hmm...an error.

      You're seeing an `ArgumentError` in `Books#new`.

      There's a lot going on in the error, but the message has a helpful hint.

      ```
      First argument in form cannot contain nil or be empty
      ```

      Remember the code we used to start the form?

      ```ruby
      <%= form_for(@book) do |f| %>
      ```

      `@book` is the first argument in the form, so the error is telling us `@book` must be nil or empty.

      How could `@book` be nil?

  1.  Open the `BooksController` in your text editor and take a look at the `new` method.

      Is `@book` defined inside in the new method?

      ```ruby
      def new
      end
      ```

      It's nowhere to be found! That explains that error 😅
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

    def new
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's fix that error.

  1.  Inside the `BooksController` `new` method, add the following line:

      ```ruby
      @book = Book.new
      ```

      `@book` is set to be a new book because we want to create a form for new books.

  1.  Save your changes and revisit [http://localhost:3000/books/new](http://localhost:3000/books/new).

      No errors! But we have a blank page. Let's start building out that form.
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

    def new
      @book = Book.new
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  In your text editor, open `app/views/books.new.html.erb`.

  1.  Inside the `form_for` block, add the following:

      ```ruby
      <ul>
        <li>
          <%= f.label :title %>
          <%= f.text_field :title %>
        </li>

        <li>
          <%= f.label :author %>
          <%= f.text_field :author %>
        </li>
      </ul>
      ```

      We're putting your form elememnts inside an unordered list. The form will have two fields, one for title and one for author.

      `f.label` defines labels for each field.

      `f.text_field` creates a text input field for each field.

  1.  Save your changes and revisit [http://localhost:3000/books/new](http://localhost:3000/books/new).

      Can you match the code you added to the different elements on the page?
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Your `new` book form has fields for title and author, try adding a field for the price. Remember, we named the field `price_cents`.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What did you come up with? If you followed the pattern used for the other two fields, you probably came up with something like this:

      ```ruby
      <li>
        <%= f.label :price_cents %>
        <%= f.text_field :price_cents %>
      </li>
      ```

  1.  That works well, but `price_cents` isn't a text field. It's a number.

  1.  To make it a number field, simply change

      ```ruby
      <%= f.text_field :price_cents %>
      ```

      to

      ```ruby
      <%= f.number_field :price_cents %>
      ```

  1.  Your full solution should look like this:

      ```ruby
      <li>
        <%= f.label :price_cents %>
        <%= f.number_field :price_cents %>
      </li>
      ```

  1.  Update your solution, save your changes, and revisit [http://localhost:3000/books/new](http://localhost:3000/books/new).

      Does the `price_cents` field differ from other fields on the page?
{% endlist %}

{% highlight ruby linenos %}
  <ul>
    <li>
      <%= f.label :title %>
      <%= f.text_field :title %>
    </li>

    <li>
      <%= f.label :author %>
      <%= f.text_field :author %>
    </li>

    <li>
      <%= f.label :price_cents %>
      <%= f.number_field :price_cents %>
    </li>
  </ul>
<% end %>
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  We have a couple more fields to add to the form. We need fields for quantity and description.

  1.  Add `quantity` to your form as a `number_field`.

  1.  Add `description` to your form as a `text_area`.

      (`text_area` differs from `text_field` by offering more space for text - which is useful for long descriptions.)
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What does your solution look like? Your compelte form should look like this:

      ```ruby
      <%= form_for(@book) do |f| %>
        <ul>
          <li>
            <%= f.label :title %>
            <%= f.text_field :title %>
          </li>

          <li>
            <%= f.label :author %>
            <%= f.text_field :author %>
          </li>

          <li>
            <%= f.label :price_cents %>
            <%= f.number_field :price_cents %>
          </li>

          <li>
            <%= f.label :quantity %>
            <%= f.number_field :quantity %>
          </li>

          <li>
            <%= f.label :description %>
            <%= f.text_area :description %>
          </li>
        </ul>
      <% end %>
      ```

  1.  Update your solution to match this solution and save your changes.
{% endlist %}
{% endsteps %}

![Browser showing "/books/new" with a form full of fields](screenshot.jpg)

{% steps %}
{% list %}
  1.  Now you have a beautiful form full of fields. You can enter so much book data! 😍

      But there's no way for you to save that data in your application's database 😞

      Don't worry! We can fix that!

  1.  At the end of the `form_for` block`, add the following line:

      ```ruby
      <%= f.submit %>
      ```

      This will add a submission button to your form.

  1.  Save your changes and revisit [http://localhost:3000/books/new](http://localhost:3000/books/new).

      `f.submit` generates a button labeled "Create Book"
{% endlist %}
{% endsteps %}

![Browser showing "/books/new" with a form you can submit](screenshot.jpg)

{% steps %}
{% list %}
  1.  Now that you have a form with a shinny "Create Book" button, why don't you try creating a book?

      Fill out the form and click "Create Book".

  1.  Error? ERROR?!

      ![Anger!]({{ site.baseurl }}/assets/images/anger.gif)

  1.  You're getting an `Unknown action` error that says "The action 'create' could not be found for BooksController".

      Huh?

      We've been working with the `BooksController` `new` action? How did we end up with an error for the `create` action?
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Take a look at what happened in your application's web server when you clicked "Create Book".

      ```shell
      Started POST "/books" for ::1 at 2016-12-27 14:32:50 -0500

      AbstractController::ActionNotFound (The action 'create' could not be found for BooksController):
      ```

      Before the error happened, the server received a POST request to the `/books` path. This request happened when you clicked the "Create Book" button.

      Your form's data was submitted as a POST request to the `/books` path.

  1.  Real interesting, right? Let's take a look at your application routes again.

  1.  Go back to Terminal and stop your application's web server by running `Ctrl-C`. Then, run `rake routes`.

  1.  Take a look at the second row of the routing table.

      ```shell
      POST   /books(.:format)          books#create
      ```

      Does that look familiar? 😉

      POST requests to `/books` get sent to the `BooksController` `create` action!

  1.  It looks like we were destined to reach the `BooksController` `create` action, but how did the form know to go there?

      By default, a `form_for` with a new record will be wired up to POST requests to its matching `create` action.

      In our case, we setup `form_for` with a new book. Therefore, the form was setup to POST to the `BooksController` `create` action.

  1.  Does this make sense to you?

      If it does, I'm impressed. I'm having a hard understanding it all 😅

  1.  Don't worry if you don't understand everything that is going on. It will make more sense over time.

      The key take away here is the `new` book form gets submitted to the `BooksController` create action.

  1.  Restart your application's web server.
{% endlist %}

{% highlight shell %}
  $ rails server
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
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Open the `BooksController` in your text editor.

  1.  Add a `create` method to the end of the controller.

      ```ruby
      def create
      end
      ```

  1.  Save your changes and try adding a book again.

      Nothing happens! Hey, it's better than an error...
{% endlist %}

{% highlight ruby %}
  class BooksController < ApplicationController
    def index
      @books = Book.all
    end

    def show
      @id = params[:id]
      @book = Book.find(@id)
    end

    def new
      @book = Book.new
    end

    def create
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  The `BooksController` `create` action is going to be responsible for using your form data to create a new book.

  1.  Take a look at the request parameters that are sent when you submit the new book form.

      ```shell
      Started POST "/books" for ::1 at 2016-12-27 15:29:52 -0500
      Processing by BooksController#create as HTML
        Parameters: {"utf8"=>"✓", "authenticity_token"=>"AOZpk66Fc20R/9xHVhxZLiSwsQj29isG2ohi9gS6TKXT0PUP3n9hYJQrPpY8iSx6uessf9Sgsd3Uv3rEuB/TvQ==", "book"=>{"title"=>"The Cat in the Hat", "author"=>"Dr. Seuss", "price_cents"=>"500", "quantity"=>"1000", "description"=>"That crazy cat!"}, "commit"=>"Create Book"}
      ```

      Inside the parameters hash, there's a "book" key with its own hash.

      ```shell
      "book"=>{"title"=>"The Cat in the Hat", "author"=>"Dr. Seuss", "price_cents"=>"500", "quantity"=>"1000", "description"=>"That crazy cat!"}
      ```

      This is the server output for the book *I* was trying to add, but your server output should look similar.

      (Unless you were trying add *The Cat in the Hat*. Then, it should look pretty much the same...)

      To get the book data that's POSTed to the server, we need to access the `book` key in the `params` hash.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Add the following code to your `BooksController` `create` method:

      ```ruby
      Book.create(title: params[:book][:title], author: params[:book][:author], price_cents: params[:book][:price_cents], quantity: params[:book][:quantity], description: params[:book][:description])
      ```

      We're using `Book.create` to create a new book. The new book's attributes are being set with values from the `params` hash `book` key.

  1.  Save you changes and try adding a book again.
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

    def new
      @book = Book.new
    end

    def create
      Book.create(title: params[:book][:title], author: params[:book][:author], price_cents: params[:book][:price_cents], quantity: params[:book][:quantity], description: params[:book][:description])
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Nothing happened, right?

      Not exactly...

  1.  Go to Terminal and stop your application's web server.

  1.  Now, run `rails console` and get the last book in your database.

      Does it look familiar?

      It's the book you created!

  1.  Although it looked like nothing happened when you clicked submit, the request made it to the `BooksController` `create` action and `Book.create` was run.

  1.  The `create` action is almost done. Now, we just need make the experience a little better.

  1.  Exit `rails console` and restart your application's web server.
{% endlist %}

{% highlight ruby %}
  $ rails server
  ...
  ^CExiting

  $ rails console
  Loading development environment (Rails 5.0.0.1)
  >> Book.last
    Book Load (0.5ms)  SELECT  "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<Book id: 8, title: "The Cat in the Hat", author: "Dr. Seuss", price_cents: 500, created_at: "2016-12-27 20:46:15", updated_at: "2016-12-27 20:46:15", quantity: 1000, description: "That crazy cat!">

  >> exit

  $ rails server
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  In your text editor, open the `BooksController`.

  1.  At the end of the `create` method, add the following line:

      ```ruby
      redirect_to books_path
      ```

      With this change, you'll be redirected to the `books_path` after a new book is created.

      `books_path` is a Rails helper method. It evaluates to `/books` or your book index page.

  1.  Save your changes and revisit [http://localhost:3000/books/new](http://localhost:3000/books/new).

      Add a new book and you will be redirected to the books index. The new book will show up at the end of the index.

      *Magic*

      ![Magic]({{ site.baseurl }}/assets/images/shia-magic.gif)
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

    def new
      @book = Book.new
    end

    def create
      Book.create(title: params[:book][:title], author: params[:book][:author], price_cents: params[:book][:price_cents], quantity: params[:book][:quantity], description: params[:book][:description])
      redirect_to books_path
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Ah, it feels like we've come so far from those days of creating books on the console...

      What? It hasn't been that long?

      Anyways...

      Things are coming together nicely. Let's take a look at cleaning some stuff up. First, we'll start with the `BooksController`.

  1.  Open the `BooksController` in your text editor and take a look at the `create` method.

  1.  In the first line of the `create` method, you're calling `Book.create` and setting attributes one by one from the params hash.

      ```ruby
      Book.create(title: params[:book][:title], author: params[:book][:author], price_cents: params[:book][:price_cents], quantity: params[:book][:quantity], description: params[:book][:description])
      ```

      Do you notice a pattern in the attributes that are being set?

      Every attribute that you're setting is in `params[:book]`.

      ```ruby
      title: params[:book][:title]
      author: params[:book][:author]
      price_cents: params[:book][:price_cents]
      ...
      ```

      Since every attribute you're setting is in `params[:book]`, we can simplify that line.

  1.  Change `Book.create` from

      ```ruby
      Book.create(title: params[:book][:title], author: params[:book][:author], price_cents: params[:book][:price_cents], quantity: params[:book][:quantity], description: params[:book][:description])
      ```

      to

      ```ruby
      Book.create(params[:book])
      ```

  1.  Save your changes, revisit [http://localhost:3000/books/new](http://localhost:3000/books/new), and try creating a book.
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

    def new
      @book = Book.new
    end

    def create
      Book.create(params[:book])
      redirect_to books_path
    end
  end
{% endhighlight %}
{% endsteps %}

![Browser showing ActiveModel::ForbiddenAttributesError in BooksController#create](screenshot.jpg)


{% steps %}
{% list %}
  1.  So...that didn't work.

      The change we made is valid, but we're running into a Rails security feature.

  1.  Rails won't let you set several attributes at once with data from a request. In this case, the data came from a request you generated. However, it's not hard to imagine a malicious user sending harmful data.

      Before you can set several attributes at once from request data, you have to explicitly state which attributes can be set. That's why you're seeing an `ActiveModel::ForbiddenAttributesError` - you haven't permitted any attributes.

      This security feature is called [strong parameters](http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters).

  1.  To use strong parameters, change `Book.create` from

      ```ruby
      Book.create(params[:book])
      ```

      to

      ```ruby
      Book.create(params.require(:book).permit(:title, :author, :price_cents, :quantity, :description)
      ```

      When we want to create a book from the `params` hash, the `params` hash must have a `book` hash. From the `book` hash, we'll get any of the permitted attributes and assign them to the new book.

  1.  Save your changes, revisit [http://localhost:3000/books/new](http://localhost:3000/books/new), and try creating a book again.
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

    def new
      @book = Book.new
    end

    def create
      Book.create(params.require(:book).permit(:title, :author, :price_cents, :quantity, :description))
      redirect_to books_path
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  To create books in the browser, you've been going directly to [http://localhost:3000/books/new](http://localhost:3000/books/new). That works, but it isn't very convenient.

      Let's add a link to the book index that will take us to [http://localhost:3000/books/new](http://localhost:3000/books/new).

  1.  Open `app/view/books/index.html.erb` in your text editor.

  1.  After the unordered list, add the following line:

      ```ruby
      <%= link_to("Add a book", new_book_path) %>
      ```

      We're using the `link_to` helper to create a link. The link's text will be "Add a book", and it will link to the new_book_path (`/books/new`).

  1.  Save your changes and go to [http://localhost:3000/books/new](http://localhost:3000/books/new).

      You should see the new link. Clicking it should take you to the new book form.
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

  <%= link_to("Add a book", new_book_path) %>
{% endhighlight %}
{% endsteps %}

![Browser showing book index with link to "Add a book"](screenshot.jpg)

{% steps %}
{% list %}
  1.  Now you can add all the books you heart desires from the comfort of your browser.

  1.  When you're done adding books and basking in the glory, stop your application's web server and give yourself a high five.

      ![Liz Lemon with the self high five]({{ site.baseurl }}/assets/images/liz-high-five.gif)
{% endlist %}
{% endsteps %}
