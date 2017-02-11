---
url: 10.html
number: 10
title: Showing Reviews
layout: rails_tutorial
---
{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}


{% steps %}
{% list %}
  1.  Now that your books have some reviews, let's share them with world!

  1.  Open Terminal, go to your `bookstore` directory, and start your application's web server.

  1.  Now, open the details page for your first book ([http://localhost:3000/books/1](http://localhost:3000/books/1)).

  1.  This page shows the details of your first book, and your first book has reviews. Doesn't this feel like a good place to show those reviews?
{% endlist %}

{% highlight shell %}
  › pwd
  /Users/awesomesauce/Projects/bookstore

  › rails server
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Do you remember how the book details page gets rendered?

      When you go to [http://localhost:3000/books/1](http://localhost:3000/books/1), a GET request is sent to your application's web server. This request gets routed to the `BooksController` `show` method.

      ```ruby
      def show
        @id = params[:id]
        @book = Book.find(@id)
      end
      ```

      In the `show` method, you made the requested book's data available by assigning the book to `@book`. Then, the `show` template (`app/views/books/show.html.erb`) can use `@book` to show the book's data.

  1.  Since the `show` template has access to the book, it also has access to the book's reviews.

      We can take advantage of this to show a book's reviews.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  In your text editor, open `app/views/books/show.html.erb`.

  1.  Let's start by showing how many reviews the book has. Add the following line before the "Edit book" link:

      ```erb
      <p> Number of reviews: <%= @book.reviews.count %> </p>
      ```

  1.  Save your changes and revisit [http://localhost:3000/books/1](http://localhost:3000/books/1).

      You should now see how many reviews your first book has! 🎉
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

  <p> Number of reviews: <%= @book.reviews.count %> </p>

  <%= link_to("Edit book", edit_book_path(@book), class: "button") %>

  <%= button_to("Delete Book", book_path(@book), method: :delete, class: "button danger") %>
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now we need to **show** the reviews... 😅

  1.  Since a book has many reviews, it would make sense to list them out. Maybe, in an unordered list?

      *Didn't we do something like this already?*

      Yeah! You used an unordered list to show books on the books index (`app/views/books/index.html.erb`).

      ```erb
      <ul>
        <% @books.each do |book| %>
          <li>
            <%= link_to(book.title, book_path(book)) %> by <%= book.author %>
          </li>
        <% end %>
      </ul>
      ```

      For each book in `@books`, you added a list item (`li`) to the unordered list (`ul`) with some information about the book.

      We'll want to do something similiar for book reviews.

  1.  Using the books index as an example, add an unordered list to the `show` template with the book's reviews.

      Add the unordered list before the "Edit book" link. For each review, add a list item with the review's body.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What does your unordered list look like? It should look something like this:

      ```erb
      <ul>
        <% @book.reviews.each do |review| %>
          <li> <%= review.body %> </li>
        <% end %>
      </ul>
      ```

  1.  If you didn't come up with a similar solution, update your solution to match this one.

  1.  Save your changes, and go check out those reviews!

  1.  When you're done, stop your application's web server.
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

  <p> Number of reviews: <%= @book.reviews.count %> </p>

  <ul>
    <% @book.reviews.each do |review| %>
      <li> <%= review.body %> </li>
    <% end %>
  </ul>

  <%= link_to("Edit book", edit_book_path(@book), class: "button") %>

  <%= button_to("Delete Book", book_path(@book), method: :delete, class: "button danger") %>
{% endhighlight %}
{% endsteps %}

![Browser showing book details page with reviews]({{site.baseurl}}/assets/images/reviews_in_browser.png){: .screenshot}
