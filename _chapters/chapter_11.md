---
url: 11.html
number: 11
title: Adding Reviews from the Browser
layout: rails_tutorial
---
{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}

{% steps %}
{% list %}
  1.  Now you can see your beautiful reviews, but wouldn't it be nice if you could also *add* reviews??

  1.  Let's start by taking a look at your application's routes file. In your text editor, open `config/routes.rb`.

  1.  So far, you've specified one resource in your routes file - books.

      ```ruby
      resources :books
      ```

  1.  It's been a while since we've been inside the routes file, but your application now has a new resource - reviews. You've defined a relationship between these two resources in your application. A book can have many reviews, and review belongs to a book.

      We can define this relationship in your routes file.

  1.  In your routes file, change

      ```ruby
      resources :books
      ```

      to

      ```ruby
      resources :books do
        resources :reviews
      end
      ```

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root "books#index"

    resources :books do
      resources :reviews
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's see how that changed your application's routes.

      Open Terminal, go to the `bookstore` directory, and run `rake routes`.

  1.  Whoa! Your application's routing table got waaaaay bigger.

      Your application now has a bunch of review routes. Do you notice a pattern in their paths?

      ```shell
      /books/:book_id/reviews
      /books/:book_id/reviews
      /books/:book_id/reviews/new
      ```

      They all start with `/books/:book_id` because of the change you made to your application's routes file:

      ```ruby
      resources :books do
        resources :reviews
      end
      ```

      By nesting `:reviews` inside of `:books`, you're setting up all your review routes to go through the book they belong to.

      For example, instead of having a route to get all your application's reviews (`/reviews`), you have a route to get all of a books reviews (`/books/:book_id/reviews`).

  1.  *Why are we doing this again?*

      We're setting up your application's routes to reflect the `belongs_to/has_many` relationship that exists between books and reviews.

      It might feel a little abstract, but this will come in handy when we're adding reviews.
{% endlist %}

{% highlight shell %}
  › pwd
  /Users/alimi/Projects/bookstore

  › rake routes
            Prefix Verb   URI Pattern                                Controller#Action
              root GET    /                                          books#index
      book_reviews GET    /books/:book_id/reviews(.:format)          reviews#index
                   POST   /books/:book_id/reviews(.:format)          reviews#create
   new_book_review GET    /books/:book_id/reviews/new(.:format)      reviews#new
  edit_book_review GET    /books/:book_id/reviews/:id/edit(.:format) reviews#edit
       book_review GET    /books/:book_id/reviews/:id(.:format)      reviews#show
                   PATCH  /books/:book_id/reviews/:id(.:format)      reviews#update
                   PUT    /books/:book_id/reviews/:id(.:format)      reviews#update
                   DELETE /books/:book_id/reviews/:id(.:format)      reviews#destroy
             books GET    /books(.:format)                           books#index
                   POST   /books(.:format)                           books#create
          new_book GET    /books/new(.:format)                       books#new
         edit_book GET    /books/:id/edit(.:format)                  books#edit
              book GET    /books/:id(.:format)                       books#show
                   PATCH  /books/:id(.:format)                       books#update
                   PUT    /books/:id(.:format)                       books#update
                   DELETE /books/:id(.:format)                       books#destroy
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Given the changes to your application's routes, what route would we use to add new reviews?

      One route stands out

      ```shell
      new_book_review GET    /books/:book_id/reviews/new(.:format)      reviews#new
      ```

      I mean...it has a prefix of `new_book_review` 😉

  1.  Let's try visiting that path. Start your application's web server, and go to [http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new). Since the path starts with `/books/1`, this is where we'd go to add a review for your first book.

  1.  Those errors sure do get old, don't they...
{% endlist %}

{% highlight shell %}
  › rails s
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing Routing Error: "uninitialized constant ReviewsController"]({{site.baseurl}}/assets/images/review_controller_routing_error.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  You got a `Routing Error` with a message that says "uninitialized constant ReviewsController". Any ideas why you're seeing that error?

      ...

      You don't have a `ReviewsController`!

  1.  Go back to Terminal, stop your application's web server, and run the following command:

      ```shell
      touch app/controllers/reviews_controller.rb
      ```

      This will create an empty file named `app/controllers/reviews_controller.rb`.

  1.  Restart your application's web server, and open `app/controllers/reviews_controller.rb` in your text editor.
{% endlist %}

{% highlight shell %}
› rails server
=> Booting Puma
...
^CExiting

› touch app/controllers/reviews_controller.rb

› rails server
=> Booting Puma
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now you have a file for the `ReviewsController`, but you still haven't defined it.

  1.  Add the following code to `app/controllers/reviews_controller.rb`

      ```ruby
      class ReviewsController < ApplicationController
      end
      ```

  1.  Save your changes and revisit [http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new).
{% endlist %}

{% highlight ruby linenos %}
  class ReviewsController < ApplicationController
  end
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing Unknown action error: "The action 'new' could not be found for ReviewsController"]({{site.baseurl}}/assets/images/reviews_new.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Another error, but we know how to deal with these.

      Right?!

      ![Fake it 'til you make it]({{ site.baseurl }}/assets/images/fake-it.jpg)

  1.  You're seeing an `Unknown action` error that says "The action 'new' could not be found for ReviewsController". How would you fix this error?

  1.  The `ReviewsController` needs a `new` action!

  1.  Add an empty `new` method to the `ReviewsController`.

      ```ruby
      def new
      end
      ```

  1.  Save your changes and revisit [http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new).
{% endlist %}

{% highlight ruby linenos %}
  class ReviewsController < ApplicationController
    def new
    end
  end
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing ActionController::UnknownFormat error: "ReviewsController#new is missing a template for this request format and variant."]({{site.baseurl}}/assets/images/missing_reviews_template.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  You have a `ReviewsController` that has a `new` method, but you're *still* getting an error when you visit the new reviews path ([http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new)).

  1.  The `ActionController::UnknownFormat` error might seem intense, but do you remember seeing it before? There's one key piece of information burried in the weeds.

      > ReviewsController#new is missing a template for this request format and variant.

      We're missing a template!

  1.  First, go back to Terminal and stop your application's web server.

  1.  Now, you'll need to create directory for the review templates. Run the following command:

      ```shell
      mkdir app/views/reviews
      ```

      This created an empty `reviews` directory inside of `app/views`.

  1.  Then, you can create the new reviews template with the following command:

      ```shell
      touch app/views/reviews/new.html.erb
      ```

  1.  Restart your application's web server, and try going back to [http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new).

      What do you think will happen?

      ![Fingers crossed!]({{ site.baseurl }}/assets/images/fingers-crossed.gif)
{% endlist %}

{% highlight shell %}
  › rails server
  ...
  ^CExiting

  › mkdir app/views/reviews

  › touch app/views/reviews/new.html.erb

  › rails server
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Have you ever been so excited to see a blank page?!

      Please, contain your excitement!

      ![Someone's not excited]({{ site.baseurl }}/assets/images/not-excited.gif)

  1.  We're rendering a blank page for the new reviews page, but what should we be rendering instead?
      
      We're going to follow the same we pattern we used back in Chapter 5 to add books.

  1.  To add a book, you start by visiting the new book page ([http://localhost:3000/books/new](http://localhost:3000/books/new)). When you get there, you see a form where you can enter data for the new book you want to add.

      ![Browser showing new book page](screenshot.jpg)

      When you're done adding the data for the new book, you click on "Create Book" to add the new book.

  1.  We're going to repeat this workflow, but instead of creating a book we're going to create a *review* for a given book.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's get started by showing the title of the book that's being reviewed at the top of the page.

  1.  Open the `ReviewsController` in your text editor, and add the following code to `new` method.

      ```ruby
      @book = Book.find(params[:book_id])
      ```

      This will make the book's data available in the new review template.

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  class ReviewsController < ApplicationController
    def new
      @book = Book.find(params[:book_id])
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now, open `app/views/reviews/new.html.erb` and add the following line:

      ```erb
      <h1> New review for <%= @book.title %> </h1>
      ```

  1.  Save your changes and revisit [http://localhost:3000/books/1/review/new](http://localhost:3000/books/1/review/new).

      The top of the page should have a message that says "New review for why's (poignant) Guide to Ruby".

  1.  Try visiting the new review path for different books in your bookstore.

      For example, to visit the new review path for the second book in your bookstore you would go to [http://localhost:3000/books/2/review/new](http://localhost:3000/books/2/review/new).

      As you go to different paths, the message at the top of the page should change to show that book's title.
{% endlist %}

{% highlight erb linenos %}
  <h1> New Review for <%= @book.title %> </h1>
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now, we need to make the new review form.

  1.  To get started, we'll update the `ReviewsController` `new` method to make a new review available in the new review template.

      *That's a lot of new 😅*

  1.  Open the `ReviewsController` and add the following line at the end of the `new` method.

      ```ruby
      @review = @book.reviews.build
      ```

      This will create an empty review for the book that we can use in the new review template.

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  class ReviewsController < ApplicationController
    def new
      @book = Book.find(params[:book_id])
      @review = @book.reviews.build
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now, we can build the review form!

      ![Jake and Finn are excited!]({{ site.baseurl }}/assets/images/excited.gif)

  1.  This form is going to be pretty simmilar to the new book form, but with less fields.

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

        <%= f.submit(class: "button") %>
      <% end %>
      ```

  1.  Using the new book form as an example, add a new review form to `app/views/reviews/new.html.erb`. The only field you need to set on a review is its body.

      When you're done, try add a reviewing!

      *Psst..not to be a downer, but chances are your solution won't work*
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What did you come up with? If you're anything like me, you followed the pattern in the new book form and came up with something like this:

      ```erb
      <%= form_for(@review) do |f| %>
        <ul>
          <li>
            <%= f.label :body %>
            <%= f.text_field :body %>
          </li>
        </ul>

        <%= f.submit(class: "button") %>
      <% end %>
      ```

  1.  For some reason, that doesn't work. This solution leads to an error...

      {% screenshot %}
      ![Browser showing NoMethodError in Reviews#new: "undefined method `reviews_path'"]({{site.baseurl}}/assets/images/new_review_unknown_path.png)
      {% endscreenshot %}

  1.  This is a tricky error, but the gist of it is that we have an undefined method for `reviews_path`.

  1.  By doing `<%= form_for(@review) do |f| %>`, we're creating a form for a new review that will get submitted to the `reviews_path`. What's wrong with that?

      We don't have a `reviews_path`...we have a `book_reviews_path`.

      Do you remember what your application's routes file looks like?

      ```ruby
      Rails.application.routes.draw do
        # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
        root "books#index"

        resources :books do
          resources :reviews
        end
      end
      ```

      Reviews are resources nested under books. Therefore, all review routes have to be referenced through a book.

  1.  To make this form work, we need to change

      ```erb
      <%= form_for(@review) do |f| %>
      ```

      to

      ```erb
      <%= form_for([@book, @review]) do |f| %>
      ```

      With this change, the form will use the `book_reviews_path` instead of the invalid `reviews_path`.

  1.  Your form should now look like this:

      ```erb
      <%= form_for([@book, @review]) do |f| %>
        <ul>
          <li>
            <%= f.label :body %>
            <%= f.text_field :body %>
          </li>
        </ul>

        <%= f.submit(class: "button") %>
      <% end %>
      ```

      Update your form to match this solution.

  1.  Save your changes and try adding a review to your first book by visiting [http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new).
{% endlist %}

{% highlight erb linenos %}
  <h1> New Review for <%= @book.title %> </h1>

  <%= form_for([@book, @review]) do |f| %>
    <ul>
      <li>
        <%= f.label :body %>
        <%= f.text_field :body %>
      </li>
    </ul>

    <%= f.submit(class: "button") %>
  <% end %>
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing an Unknown action error when trying to add a review]({{site.baseurl}}/assets/images/unknownaction_create.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  An `Unknown action` error?! But we were so close!!!

      ![Jake is upset]({{ site.baseurl }}/assets/images/upset.gif)

      Don't be so down! We've gotten through this before...we can fix this.

      ![Fix it!]({{ site.baseurl }}/assets/images/fix-it.gif)

  1.  The error is telling us what we need to do.

      > The action 'create' could not be found for ReviewsController

  1.  Add an empty `create` method to the `ReviewsController`.

      ```ruby
      def create
      end
      ```

  1.  Save your changes and try adding a review for your first book again by visiting [http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new).
{% endlist %}

{% highlight ruby linenos %}
  class ReviewsController < ApplicationController
    def new
      @book = Book.find(params[:book_id])
      @review = @book.reviews.build
    end

    def create
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Nothing happened, right?

      RIGHT?!?

      Of course nothing happened, the `create` method is empty.

  1.  We need to update the `ReviewsController` `create` method so it creates a review for the requested book.

  1.  Add the followling lines to the `ReviewsController` `create` method:

      ```ruby
      book = Book.find(params[:book_id])
      book.reviews.create(params)
      ```

      First, we find the requested book and assign it to a variable called `book`. Then, we create a review for the book using the data that was sent with the form. The data is available in the params hash.

  1.  Save your changes, revisit [http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new), and try adding a review one more time.
{% endlist %}

{% highlight ruby linenos %}
  class ReviewsController < ApplicationController
    def new
      @book = Book.find(params[:book_id])
      @review = @book.reviews.build
    end

    def create
      book = Book.find(params[:book_id])
      book.reviews.create(params)
    end
  end
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing ActiveModel::ForbiddenAttributesError in ReviewsController#create]({{site.baseurl}}/assets/images/reviews_forbidden.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Are you really surprised to see another error? 😉

  1.  What do you think is going on? You're getting an `ActiveModel::ForbiddenAttributesError`, but why?

  1.  If you look closely at the browser, Rails is telling you *where* the problem is. It's inside the `create` method.

      ```ruby
      book.reviews.create(params)
      ```

      Why would you get an `ActiveModel::ForbiddenAttributesError` from doing `book.reviews.create(params)`...🤔

  1.  Check out the `ActiveModel::ForbiddenAttributesError` [doc](http://api.rubyonrails.org/v5.0.0/classes/ActiveModel/ForbiddenAttributesError.html). What does the description say?

      > Raised when forbidden attributes are used for mass assignment.

      Ah! We're trying to create the review using all the data from the params hash, but we haven't allowed any attributes to be set. This is that security feature we looked at earlier called [strong parameters](http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters).

      Strong parameters forces us to explcitly state what attributes can be set to prevent malicious data from entering our applications. When you try to assign attributes that haven't been permitted, you get an `ActiveModel::ForbiddenAttributesError` error.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  To fix the `ReviewsController` `create` method, we need to specify the attributes that can be set on reviews. There is only one attribute we care about - `body`.

  1.  Add the following method to the end of the `ReviewsController`:

      ```ruby
      def review_params
        params.require(:review).permit(:body)
      end
      ```

      Inside this `review_params` method, we're saying the `params` hash must have a `review` hash. Inside the `review` hash, we'll allow a `body` attribute to be used on a new review.

  1.  Do you remember what the `params` hash looks like? It looks something like this:

      ```ruby
      {"utf8"=>"✓", "authenticity_token"=>"JYZD9Lsnb6RbMX7OW/QUXNY6Uzxd0MYZNcDKHKZjAmggVeGwKb6lPkOE60zgptRlquzdhJo9tOU5r7mLthxXog==", "review"=>{"body"=>"Wooooooooo"}, "commit"=>"Create Review", "book_id"=>"1"}
      ```

      There's a bunch of stuff in there, but now we're restricted to only using the `body` attribute from the `review` hash.

  1.  Now we can use `review_params` inside the `create` method. Replace

      ```ruby
      book.reviews.create(params)
      ```

      with

      ```ruby
      book.reviews.create(review_params)
      ```

  1.  Save your changes, revisit [http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new), and try adding a review!
{% endlist %}

{% highlight ruby linenos %}
  class ReviewsController < ApplicationController
    def new
      @book = Book.find(params[:book_id])
      @review = @book.reviews.build
    end

    def create
      book = Book.find(params[:book_id])
      book.reviews.create(review_params)
    end

    def review_params
      params.require(:review).permit(:body)
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Nothing happened...or did it?

  1.  Go back to your first book's details page at [http://localhost:3000/books/1](http://localhost:3000/books/1).

      Notice anything different???

      Your new review!!! 🎉

  1.  Nothing happens at the end of the `ReviewsController` `create` method so it feels like your review wasn't created. Let's fix this.

  1.  Add the following line to the end of the `ReviewsController` `create` method:

      ```ruby
      redirect_to book_path(book)
      ```

      After a review is added for the book, we'll redirect to the book details page for the book so we can verify the new review was created.

  1.  Save your changes, revisit [http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new), and watch what happens when you add a new review.
{% endlist %}

{% highlight ruby linenos %}
  class ReviewsController < ApplicationController
    def new
      @book = Book.find(params[:book_id])
      @review = @book.reviews.build
    end

    def create
      book = Book.find(params[:book_id])
      book.reviews.create(review_params)
      redirect_to book_path(book)
    end

    def review_params
      params.require(:review).permit(:body)
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  You've done *a lot* of work in this chapter, but look at your bookstore! Now you can write all those book reviews you've been putting off for all these years.

      ![Typing!]({{ site.baseurl }}/assets/images/typing.gif)

  1.  Before you jump into writing those reviews, let's clean up *one* more thing...

  1.  To create a review for a book, you have to know the URL you want to visit. We can make this a little nicer by adding a link to the new review page from the book details pages.

      You'll be able to quickly write a review for the book you're looking at.

  1.  Let's start by looking at your application's routes. Go to Terminal, stop your application's web server, and run `rake routes`.

  1.  Which row has the path we've been using to get to the new review page?

      ```shell
      new_book_review GET    /books/:book_id/reviews/new(.:format)      reviews#new
      ```

      The first column in the row is a `prefix`. The new review page has a `prefix` of `new_book_review`. We'll use this `prefix` to build a link to the new review path.

  1.  Restart your application's web server.
{% endlist %}

{% highlight shell %}
  › rails server
  => Booting Puma
  ...
  ^CExiting

  › rake routes
            Prefix Verb   URI Pattern                                Controller#Action
              root GET    /                                          books#index
      book_reviews GET    /books/:book_id/reviews(.:format)          reviews#index
                   POST   /books/:book_id/reviews(.:format)          reviews#create
   new_book_review GET    /books/:book_id/reviews/new(.:format)      reviews#new
  edit_book_review GET    /books/:book_id/reviews/:id/edit(.:format) reviews#edit
       book_review GET    /books/:book_id/reviews/:id(.:format)      reviews#show
                   PATCH  /books/:book_id/reviews/:id(.:format)      reviews#update
                   PUT    /books/:book_id/reviews/:id(.:format)      reviews#update
                   DELETE /books/:book_id/reviews/:id(.:format)      reviews#destroy
             books GET    /books(.:format)                           books#index
                   POST   /books(.:format)                           books#create
          new_book GET    /books/new(.:format)                       books#new
         edit_book GET    /books/:id/edit(.:format)                  books#edit
              book GET    /books/:id(.:format)                       books#show
                   PATCH  /books/:id(.:format)                       books#update
                   PUT    /books/:id(.:format)                       books#update
                   DELETE /books/:id(.:format)                       books#destroy

  › rails server
  => Booting Puma
  ...
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now, open `app/views/books/show.html.erb` in your text editor.

  1.  Find the "Edit book" link.

      ```erb
      <%= link_to("Edit book", edit_book_path(@book), class: "button") %>
      ```

  1.  After the link "Edit book" link, add a link to "Add a Review".

      The link should say "Add a Review". It should link to the `new_book_review_path` for `@book`, and it should have a "button" class so it gets styled like an actionable element.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What did you come up with?

      The link should look something like this:

      ```erb
      <%= link_to("Add a Review", new_book_review_path(@book), class: "button") %>
      ```

  1.  Update your solution to match this solution.

  1.  Save your changes, find some books, and review them!

  1.  When you're done writing reviews, stop your application's web server.
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

  <%= link_to("Add a Review", new_book_review_path(@book), class: "button") %>

  <%= button_to("Delete Book", book_path(@book), method: :delete, class: "button danger") %>
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing book details page with a link to "Add a Review"]({{site.baseurl}}/assets/images/review_button.png)
{% endscreenshot %}
