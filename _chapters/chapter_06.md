---
url: 6.html
number: 6
title: Updating Books
layout: rails_tutorial
---

{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}


{% aside %}
  You have so many books in your bookstore! 🎉

  What would happen if you suddenly sold every copy of a book? What about if the price changes?

  You'd have to open `rails console` to change your book's data. That doesn't sound very great.

  What if you could update books in your browser? Wouldn't that be a little easier?

  Let's make it so you can can update books in the browser.
{% endaside %}

{% steps %}
{% list %}
  1.  Open Terminal and go to your `bookstore` directory. Then, run `rake routes`.

  1.  Now that we want to edit and update books, a couple of rows in the routing table should stand out.

      First, take a look at the row with `edit_book`.

      ```shell
      edit_book GET    /books/:id/edit(.:format) books#edit
      ```

      The path to `edit_book` is `/books/:id/edit`. Doesn't that look a little familiar? You've been going to `/books/:id` to see the details for a given book. Now, you'll go to `/books/:id/edit` to edit the given book.

  1.  Start your application's web server and go to [http://localhost:3000/books](http://localhost:3000/books). From the index, click the link for *why's (poignant) Guide to Ruby*.

      Your browser should have URL of `http://localhost:3000/books/1` in its address bar. Edit the URL so it's `http://localhost:3000/books/1/edit` to visit the edit path for *why's (poignant) Guide to Ruby*. Now, try going to the new URL.

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

  $ rails server
  => Booting Puma
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing `/books/1/edit` with an Unknown action error: "The action 'edit' could not be found for BooksController"]({{site.baseurl}}/assets/images/unknown_action_edit.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  You got an error, right?

      Good.

      Can you guess why you're seeing an `Unknown action` error?

  1.  You're getting an `Unknown action` error because your `BooksController` doesn't have an `edit` method. Let's add it.

  1.  Open the `BooksController` in your text editor. Add the `edit` method to the end of the controller.

      ```ruby
      def edit
      end
      ```

  1.  Try going to [http://localhost:3000/books/1/edit](http://localhost:3000/books/1/edit) again.

      What do you think will happen?
{% endlist %}
{% endsteps %}

{% screenshot %}
![Browser showing ActionController::UnknownFormat error: "BooksController#edit is missing a template for this request format and variant"]({{site.baseurl}}/assets/images/UnknownFormat_in_BooksController_edit.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Did you guess you'd see an `ActionController::UnknownFormat` error? Me either. 😅

      However, you might have guessed that the request was going to error. You added the `edit` action to the `BooksController`, but it doesn't have a template to render.

      Let's add it.

  1.  Go back to Terminal and stop your application's web server.

  1.  Run `touch app/views/books/edit.html.erb` to create the edit book template.

  1.  Restart your application's web server and revisit [http://localhost:3000/books/1/edit](http://localhost:3000/books/1/edit).

      A blank page has never looked better!
{% endlist %}

{% highlight shell %}
  $ rails server
  ...
  ^CExiting

  $ touch app/views/books/edit.html.erb

  $ rails server
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  In the edit template, we'll take advantage of forms again. We'll use them to gather new book data.

      Before we add the form to the template, let's make some of the existing book data available.

  1.  Open the `BooksController` and add the following line inside the `edit` method:

      ```ruby
      @book = Book.find(params[:id])
      ```

      (Doesn't that look a lot like the `show` method?)

  1.  Save your changes.
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

    def edit
      @book = Book.find(params[:id])
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  The edit book form is going be similiar to the new book form.

      Remember what the new book form looked like?

      ```erb
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

        <%= f.submit %>
      <% end %>
      ```

  1.  Let's start the edit form by adding a field to edit the book's title.

      ```erb
      <%= form_for(@book) do |f| %>
        <ul>
          <li>
            <%= f.label :title %>
            <%= f.text_field :title %>
          </li>
        </ul>
      <% end %>
      ```

  1.  Save your changes and revist [http://localhost:3000/books/1/edit](http://localhost:3000/books/1/edit).
{% endlist %}
{% endsteps %}

{% screenshot %}
![Browser showing "/books/1/edit" with a filled-in text_field for the book's title]({{site.baseurl}}/assets/images/edit_field_for_title.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Whoa! The title is already filled-in!

      In the `BooksController` `edit` method, you found the requested book in your database and assigned it to `@book`. When you called `form_for` in `app/views/books/edit.html.erb`, you passed it `@book`.

      Since `@book` is a book in your database with a title, the title `text_field` was populated with `@book`'s title.

      ([*Magic*](https://www.youtube.com/watch?v=MzlK0OGpIRs))

  1.  Update the form so it has fields for all the book attributes: title, author, price_cents, quantity, and description.

      Use the new book form in `app/views/books/new.html.erb` as an example.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  How's your form look? It should look like this:

      ```erb
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

  1.  Update your solution to match this solution. Save your changes and revisit [http://localhost:3000/books/1/edit](http://localhost:3000/books/1/edit).
{% endlist %}

{% highlight erb linenos %}
  <%= form_for(@book) do |f| %>
    <ul>
      <li>
        <%= if.label :title %>
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
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing "/books/1/edit" with a form but no button]({{site.baseurl}}/assets/images/all_the_edit_fields.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Now you can edit all your book data, but there's no way to save your changes.

      We need to add a `submit` button so you can submit your changes via the form.

  1.  Open `app/views/books/edit.html.erb` and add a `submit` button as the last line inside the `form_for` block.

      ```erb
      <%= f.submit %>
      ```

      This will add a button to your form labeled "Update Book". *Magic*

  1.  Save your changes and revisit [http://localhost:3000/books/1/edit](http://localhost:3000/books/1/edit). Try making a change and submitting the form.
{% endlist %}

{% highlight erb linenos %}
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

    <%= f.submit %>
  <% end %>
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing "/books/1/edit" with a submit button]({{site.baseurl}}/assets/images/update_form_with_button.png)
{% endscreenshot %}

{% screenshot %}
![Browser showing Unknown action error: "The action 'update' could not be found for BooksController"]({{site.baseurl}}/assets/images/unknown_action_update.png)
{% endscreenshot %}
{% steps %}
{% list %}
  1.  We've been through this drill before...

  1.  Open the `BooksController` and add an `update` method to the end of it.

  1.  Save your changes and revisit [http://localhost:3000/books/1/edit](http://localhost:3000/books/1/edit). Try making a change to the book and submitting the form.
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

    def edit
      @book = Book.find(params[:id])
    end

    def update
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Nothing happened!

      The form is being submitted to the `BooksController` `update` method, and the method is...empty. I think I'd be more surprised if something *did* happen. 😉

      The `update` method should probably do something. Maybe it should update the book.

  1.  First, let's find the book you're trying to update.

      Open the `BooksController` and add the following line insided the `update` method:

      ```ruby
      book = Book.find(params[:id])
      ```

      We've done this in a few of the `BooksController` methods.

  1.  Now that we have the book, how will we `update` it?

      You've updated books before. Do you remember when you added descriptions to all your books? How did you do it?

      You did something along the lines of `my_first_book.update(description: "Woooo")`.

      You called the `update` method on each of your books to give them descriptions. We'll use `update` again to make the requested changes.

  1.  We could simply do `book.update(params[:book])`, but that won't work because of strong parameters.

      Instead, add the following line to the end of the `BooksController` `update` method.

      ```ruby
      book.update(params.require(:book).permit(:title, :author, :price_cents, :quantity, :description))
      ```

  1.  Save your changes, revisit [http://localhost:3000/books/1/edit](http://localhost:3000/books/1/edit), make some changes, and submit that form!
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

    def edit
      @book = Book.find(params[:id])
    end

    def update
      book = Book.find(params[:id])
      book.update(params.require(:book).permit(:title, :author, :price_cents, :quantity, :description))
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Nothing happened, right?

      Go to [http://localhost:3000/books/1](http://localhost:3000/books/1), and make sure to refresh the page.

      Your change is there!

      Don't believe me? Try making another change?

  1.  How are changes happening when it looks like the form isn't being submitted?

      The form is being submitted to the `BooksController` `update` method, and the requested changes are being made to the book. But that's where the `update` method ends. It looks like nothing happened because there's no visual queue that something happened.

  1.  After a book is updated, let's redirect to that book's details. That way, we can see the changes.

      Add the end of the `BooksController` `update` method, add the following line:

      ```ruby
      redirect_to book_path(book)
      ```

  1.  Save your changes, revisit [http://localhost:3000/books/1/edit](http://localhost:3000/books/1/edit), and try making another change. When you submit your changes, you should be redirected to the first book's details. Keep an out to see your changes.
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

    def edit
      @book = Book.find(params[:id])
    end

    def update
      book = Book.find(params[:id])
      book.update(params.require(:book).permit(:title, :author, :price_cents, :quantity, :description))
      redirect_to book_path(book)
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Yay! In addition to adding books from the browser, you can now edit books too.

  1.  Before we move on, let's take a look at cleaning up some stuff. Let's start with the `BooksController`.

  1.  In both the `create` and `update` methods, you're authorizing and getting the same params.

      ```ruby
      def create
        Book.create(params.require(:book).permit(:title, :author, :price_cents, :quantity, :description))
        ...
      end

      ...

      def update
        ...
        book.update(params.require(:book).permit(:title, :author, :price_cents, :quantity, :description))
        ...
      end

      ```

      Fortunately, there's a convention to help manage this shared bit of code.

  1.  Open the `BooksController` in your text editor, and add the following code to the end of it:

      ```ruby
      def book_params
        params.require(:book).permit(:title, :author, :price_cents, :quantity, :description)
      end
      ```

      By defining a new `book_params` method, we have one place to deal with getting and authorizing book params.

  1.  Now, update the `create` method so it uses `book_params`. Change

      ```ruby
      Book.create(params.require(:book).permit(:title, :author, :price_cents, :quantity, :description))
      ```

      to

      ```ruby
      Book.create(book_params)
      ```

  1.  Make the same change to the `update` method.

  1.  Save your changes and try creating and editing books. Everything should still work the same as it did before these changes.
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
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's make one more change to improve the edit workflow.

      Right now, you can only edit books if you know the `edit_book_path` URL. Let's make this a little user friendly by adding a link to the edit page from the book show page.

  1.  Open `app/views/books/show.html.erb` in your text editor. Add the following line to the end of the file:

      ```erb
      <%= link_to "Edit book", edit_book_path(@book) %>
      ```

      This will create a link with text "Edit book". It will link to the `edit_book_path` for `@book` which will evaluate to `/books/:id/edit`.

      Adding the link here works really well because we already have the book we want to edit as `@book`.

  1.  Save your changes and visit a few books. Clicking the "Edit book" link should take you to the edit page for the book you're viewing.

  1.  When you're done exploring, stop your application's web server.
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

  <%= link_to "Edit book", edit_book_path(@book) %>
{% endhighlight %}
{% endsteps %}
