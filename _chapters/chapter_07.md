---
url: 7.html
number: 7
title: Styling Your Bookstore
layout: rails_tutorial
chapter: 7
---

{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}

{% aside %}
  You're bookstore is really starting to take shape. But doesn't it look a little...spartan?

  Don't get me wrong, there's a beauty in the simplicity. However, there are a few changes we can make that'll make your bookstore easier to use.

  We'll add a [CSS](https://developer.mozilla.org/en-US/docs/Web/CSS) file to add some style rules. Then, we'll update your templates to take advantage of the new style rules.
{% endaside %}

{% steps %}
{% list %}
  1.  Download the stylesheet file `bookstore.scss` [here](link-to-file.com).

  1.  Move `bookstore.scss` to `app/assets/stylesheets`.

      Rails will automatically load all stylesheet files defined in `app/assets/stylesheets`.
{% endlist %}

{% highlight shell %}
  $ ls -l app/assets/stylesheets
  total 16
  -rw-r--r--  1 awesomesauce  staff   736 Dec 30 12:13 application.css
  -rw-r--r--  1 awesomesauce  staff  2812 Dec 30 12:14 bookstore.scss
{% endhighlight %}
{% endsteps %}

{% protip %}
  Hey - I thought we were adding a CSS file?! What's a `.scss` file?

  `bookstore.scss` is a [Sass](http://sass-lang.com/) file!

  As they say at the top of their homepage, Sass is "CSS with superpowers."

  We can use both Sass and CSS files in your application because Rails ships with support for both.

  If you're curious, you can read the [Sass docs](http://sass-lang.com/guide) to learn more about it.
{% endprotip %}

{% steps %}
{% list %}
  1.  Now that your application has some styles, let's use them!

  1.  Let's start by adding a header that will get rendered on every page.

  1.  Open `app/views/layouts/application.html.erb` in your text editor.

      This file makes up the skeleton of every page in your application.

      All your content is rendered inside the `body` tag.

      ```ruby
      <body>
        <%= yield %>
      </body>
      ```

  1.  After the beginning of the `body` tag, add the following code:

      ```ruby
      <div class="navigation">
        <div class="center">
          <%= link_to "My Super Rad Bookstore", books_path %>
        </div>
      </div>
      ```

      On every page of your bookstore, there will be a header with a link "My Super Rad Bookstore" that links to the books index. No matter what page your on, you'll be able to get back to your bookstore's main page.

  1.  Now, let's add a containing `div` around your application's content.

      Inside the `body` tag, change the `yield` line from

      ```ruby
      <%= yield %>
      ```

      to

      ```ruby
      <div class="container">
        <%= yield %>
      </div>
      ```

      This let's us add some styling to make your application's content consistent across the different pages.

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  <!DOCTYPE html>
  <html>
    <head>
      <title>Bookstore</title>
      <%= csrf_meta_tags %>

      <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
      <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
    </head>

    <body>
      <div class="navigation">
        <div class="center">
          <%= link_to "My Super Rad Bookstore", books_path %>
        </div>
      </div>

      <div class="container">
        <%= yield %>
      </div>
    </body>
  </html>
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now, let's take a look at the books index. Open `app/views/books/index.html.erb`.

  1.  At the end of the template, you have a link to add a book.

      Let's make that link look like a button. This will help people recognize the link as an actionable item.

  1.  Change the link from

      ```ruby
      <%= link_to("Add a book", new_book_path) %>
      ```

      to

      ```ruby
      <%= link_to("Add a book", new_book_path, class: "button") %>
      ```

      With this change, you're adding a CSS class called `button` to the link. The CSS class `button` is defined in `bookstore.scss`.

  1.  Save your changes.
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

  <%= link_to("Add a book", new_book_path, class: "button") %>
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that we have some styles in place, let's see what they look like.

  1.  Go to Terminal and make sure you're in the `bookstore` directory.

  1.  Now, start your application's web server and go to [http://localhost:3000/books](http://localhost:3000/books).
{% endlist %}

{% highlight shell %}
  $ pwd
  /Users/alimi/Projects/bookstore

  $ rails server
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
{% endhighlight %}
{% endsteps %}

![Browser showing styled books index](screenshot.jpg)

{% steps %}
{% list %}
  1.  Wow! Doesn't it look so different?!

      Let's add a few more finishing touches.

  1.  Open `app/views/new.html.erb`.

  1.  We'll add the `button` CSS class to the form submission button to make it look like a...button.

      Trust me, it'll be a reall good looking button 😉

  1.  Change the `submit` button from

      ```ruby
      <%= f.submit %>
      ```

      to

      ```ruby
      <%= f.submit(class: "button" )%>
      ```

      This change is very simmilar to the change we made to the "Add a book" link. Before, you weren't passing any arguments to the `submit` button. Now, you're setting the class to `button`.

  1.  Save your changes and go to the new book page to see your changes.
{% endlist %}

{% highlight ruby linenos %}
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

    <%= f.submit(class: "button") %>
  <% end %>
{% endhighlight %}
{% endsteps %}

![Browser showing new book page with a styled button](screenshot.jpg)

{% steps %}
{% list %}
  1.  There's one more link we'll style as a button. Can you guess which one it is?

      It's a sneaky one - the "Edit book" link on the book details page.

      Once again, we'll style the link as a button to help people recognize it as an actionable item.

  1.  Open `app/views/books/show.html.erb`.

  1.  Just as we've done before, add the `button` class as the last option to the link.

  1.  Save your changes and visit [http://localhost:3000/books/1/show](http://localhost:3000/books/1/show) to see your changes.
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

  <%= link_to("Edit book", edit_book_path(@book), class: "button") %>
{% endhighlight %}
{% endsteps %}

![Browser showing book details page with styled edit link](screenshot.jpg)

{% steps %}
{% list %}
  1.  Finally, we have one more button to style as a...button.

  1.  Open `app/views/books/edit.html.erb`.

  1.  Just like the submit button on the new book template, add the `button` class as the last option to the edit book template's submit button.

  1.  Save your changes, go to [http://localhost:3000/books/1/edit](http://localhost:3000/books/1/edit), and admire your freshly styled button.
{% endlist %}

{% highlight ruby linenos %}
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

    <%= f.submit(class: "button") %>
  <% end %>
{% endhighlight %}
{% endsteps %}

![Browser showing book edit page with styled update button](screenshot.jpg)

{% aside %}
  Your bookstore looks sooooo purrdy 😍

  ![Purrdy cat](http://stuffpoint.com/cats/image/104659-cats-cute-cat.jpg "We should serve this file locally")

  But there's one thing that's kinda bugging me. Take a look at [http://localhost:3000](http://localhost:3000).

  The default Rails homepage is a great way to verify things are working when you're just getting started, but we're well past that.

  The books index at [http://localhost:3000/books](http://localhost:3000/books) is your application's *true* homepage, so let's treat it that way!
{% endaside %}

{% steps %}
{% list %}
  1.  To make the books index your application's homepage, we'll need to update your application's routes.

  1.  Open `config/routes.rb` in your text editor.

  1.  Before the line with `resources :books`, add the following line:

      ```ruby
      root "books#index"
      ```

      This will update your application's routes so requests to [http://localhost:3000](http://localhost:3000) get routed to the `BooksController` `index` action.

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root "books#index"

    resources :books
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's take a look at how the change to `config/routes.rb` changed your application's routes.

  1.  Go back to Terminal, stop your application's web server, and run `rake routes`.

  1.  You might not notice it, but there's a new row at the beginning of the table.

      ```shell
      root GET    /                         books#index
      ```

      The root route has an empty path (there's nothing after `/`).

  1.  It's a small change, but it's pretty powerful. Restart your application's web server and go to [http://localhost:3000](http://localhost:3000).
{% endlist %}

{% highlight shell %}
  $ rails server
  ...
  ^CExiting

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
{% endhighlight %}
{% endsteps %}

![Browser showing the books index as the bookstore's homepage](screenshot.jpg)

{% steps %}
{% list %}
  1.  Now that your bookstore has a `root` route, let's make one more change.

  1.  Open `app/views/layouts/application.html.erb`.

  1.  Change the "My Super Rad Bookstore" link from

      ```ruby
      <%= link_to "My Super Rad Bookstore", books_path %>
      ```

      to

      ```ruby
      <%= link_to "My Super Rad Bookstore", root_path %>
      ```

      By changing the link to `root_path`, we can always be sure that it will go to your application's homepage.


  1.  Save your changes and take your updated bookstore for a spin. When you're done, stop your application's web server.
{% endlist %}

{% highlight ruby linenos %}
  <!DOCTYPE html>
  <html>
    <head>
      <title>Bookstore</title>
      <%= csrf_meta_tags %>

      <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
      <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
    </head>

    <body>
      <div class="navigation">
        <div class="center">
          <%= link_to "My Super Rad Bookstore", root_path %>
        </div>
      </div>

      <div class="container">
        <%= yield %>
      </div>
    </body>
  </html>
{% endhighlight %}
{% endsteps %}
