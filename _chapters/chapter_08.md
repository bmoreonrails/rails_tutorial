---
url: 8.html
number: 8
title: Deleting a Book
layout: rails_tutorial
---

{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}

{% aside %}
  Your bookstore is starting to feel like a fully featured application. You can list, view, add, and edit books. Is there anything else you might want to do with your books?

  Maybe you accidentally added a book you don't have, or a book is no longer available. When these situations happen, wouldn't it be nice if you could delete the book?

  Let's add the ability to delete books.
{% endaside %}

{% steps %}
{% list %}
  1.  Let's start by looking at your application's routes.

  1.  Open Terminal and go to the `bookstore` directory.

  1.  Now, run `rake routes`.

  1.  Can you guess which path we'll use to delete a book?

      It's in the last row of the routing table:

      ```shell
      DELETE /books/:id(.:format)      books#destroy
      ```

      A DELETE request to `/books/:id` will get routed to the `BooksController` `destroy` action.

  1.  Let's try visiting that path. Start your application's web server and go to [http://localhost:3000/books/1](http://localhost:3000/books/1).
{% endlist %}

{% highlight shell %}
  $ pwd
  /Users/awesomesauce/Projects/bookstore

  $ rake routes
     Prefix Verb   URI Pattern               Controller#Action
       root GET    /                         books#index
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
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing /books/1]({{site.baseurl}}/assets/images/bookstore_1_pre_delete.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  What happened when you went to [http://localhost:3000/books/1](http://localhost:3000/books/1)?

      You pulled up the details for the first book in your application's database.

      *But I thought we were going to be deleting books*

  1.  When you visit [http://localhost:3000/books/1](http://localhost:3000/books/1), you send a GET request to your application's web server. GET requests to `/books/:id` don't have anything to do with deleting books.

      ```shell
      book GET    /books/:id(.:format)      books#show
      ```

      GET requests to `/books/:id` get routed to the `BooksController` `show` action. To delete a book, we need to send a `DELETE` request to `/books/:id`.

  1.  This may seem foreign, but we actually ran into this before when we were updating books.

      To reach the `BooksController` `update` action, we also send a request to `/books/:id`. However, this request is either a `PATCH` or `PUT` request.

      ```shell
      PATCH  /books/:id(.:format)      books#update
      PUT    /books/:id(.:format)      books#update
      ```

      Do you remember doing anything special to handle the different request type? Me neither. 😊

      You've been sending PATCH/PUT requests to update books thanks to `form_for`.

      ```erb
      <%= form_for(@book) do |f| %>
      ```

      With that one line, you created a form that is submitted as a PATCH/PUT request to your application's web server.

      We'll do something similiar to generate DELETE requests to delete books.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  To delete a book, we'll add a "Delete Book" button to the book details page.

  1.  In your text editor, open `app/views/books/show.html.erb`.

  1.  At the end of the file, add the following line:

      ```erb
      <%= button_to("Delete Book", book_path(@book), method: :delete, class: "button danger") %>
      ```

      This will create a button labeled "Delete Book". When the button is clicked, a request will be sent to `book_path` for the given book (`/books/:id`). The request will be a DELETE request because the method is set to `:delete`.

      The button has a couple of styling rules. First, the button will be styled as a...`button`. We'll also want the button to stand out because it's potentially dangerous. (We don't want anyone to accidentally delete a book). To make it stand out, we'll add the `danger` class.

  1.  Save your changes, and find a book you don't like. If you like all your books, find one you could live without. 😝

      Once you've found that book, go to its details page in the browser. Find the "Delete Book" button and click it.
{% endlist %}

{% highlight erb linenos %}
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

  <%= link_to("Edit book", edit_book_path(@book), class: "button") %>

  <%= button_to("Delete Book", book_path(@book), method: :delete, class: "button danger") %>
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing book details page with a red delete book button]({{site.baseurl}}/assets/images/new_delete_button.png)
{% endscreenshot %}

{% screenshot %}
![Browser showing Unknown action error: "The action 'destroy' could not be found for BooksController"]({{site.baseurl}}/assets/images/unknown_action_delete.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Ahh, another `Unknown action` error. Feels just like home. 😅

  1.  Spend a few minutes to see if you can get past the `Unknown action` error. Instead of erroring, the button should do nothing.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Did you get it?! The `BooksController` needs a `destroy` method.

  1.  If you haven't already, add an empty `destroy` method to your `BooksController`.
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
      Book.create(book_params)
      redirect_to books_path
    end

    def edit
      @book = Book.find(params[:id])
    end

    def update
      book = Book.find(params[:id])
      book.update(book_params)
      redirect_to book_path(book)
    end

    def book_params
      params.require(:book).permit(:title, :author, :price_cents, :quantity, :description)
    end

    def destroy
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now you have a "Delete Book" button that doesn't do anything. Let's change that.

  1.  In the `BooksController` `destroy` method, you need to first find the book you want to destroy. Then, you'll want to call `destroy` on the book to delete it from your database.

      ```ruby
      book.destroy
      ```

      After the book is deleted, you'll redirect to the books index page. This will let you verify that the book is no longer in your database.

  1.  Given this description, try wiring up the `BooksController` `destroy` method. Use the other `BooksController` methods for guidance, and compare your work with others around you.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What did you come up with?!

      Your solution should look something like this:

      ```ruby
      def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
      end
      ```

  1.  Don't worry if your solution doesn't look *exactly* like this. As long as you're destroying the requested book and redirecting to the books index, you're good.

      If that's not the case, update your solution to match this one.

  1.  Save your changes and delete some books! 😈

  1.  When you're done wreaking havoc, stop your application's web server.
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
      Book.create(book_params)
      redirect_to books_path
    end

    def edit
      @book = Book.find(params[:id])
    end

    def update
      book = Book.find(params[:id])
      book.update(book_params)
      redirect_to book_path(book)
    end

    def book_params
      params.require(:book).permit(:title, :author, :price_cents, :quantity, :description)
    end

    def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to books_path
    end
  end
{% endhighlight %}
{% endsteps %}
