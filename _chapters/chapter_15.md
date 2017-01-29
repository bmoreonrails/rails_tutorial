---
url: 15.html
number: 15
title: Associating Reviews with Users
layout: rails_tutorial
---

{% aside %}
  Now that you can keep track of logged in users, you can keep track of their actions. A great example where this could be useful is with your reviews. Wouldn't it be nice to know which users are leaving which reviews?
{% endaside %}

{% steps %}
{% list %}
  1.  To track which users are leaving which reviews, we need to establish a relationship between users and reviews.

      A user can leave many reviews, and a review can only be written by one user. Does this sound familiar?

  1.  You've already defined a similar relaltionship between books and reviews.

      ```ruby
      class Book < ApplicationRecord
        has_many :reviews
      end
      ```

      ```ruby
      class Review < ApplicationRecord
        belongs_to :book
      end
      ```

      A book has many reviews, and a review belongs to a book.

  1.  Open the `User` class (`app/models/user.rb`) in your text editor.

      Using the `Book` class as an example, update `User` so a user has many reviews.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What do your changes look like? You should have added the following line to `User`:

      ```ruby
      has_many :reviews
      ```

  1.  If you didn't already, make this change to `User`.

  1.  Save your changes.
{% endlist %}

{% highlight ruby linenos %}
  class User < ApplicationRecord
    has_secure_password

    has_many :reviews
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that we've defined a relationship between users and reviews, let's see what we can do with it on the `rails console`.

  1.  Open Terminal, make sure you're in the `bookstore` directory, and start the `rails console`.

  1.  Find your first user and assign it to a variable called `my_first_user`.

  1.  Now, try running `my_first_user.reviews`.

  1.  Yikes! That looks like a gnarly error... 😅

      The `ActiveRecord::StatementInvalid` error is giving you hint to what's going on. Burried inside the error, you have this message:

      ```ruby
      no such column: reviews.user_id
      ```

      We've defined the relationship between users and reviews on the model level, but we haven't defined it on the database level.

      Since we said a user can have many reviews, Rails is expecting the reviews table to have a `user_id` column. Let's add it!

  1.  Before you continue, exit the `rails console`.
{% endlist %}

{% highlight ruby %}
  › pwd
  /Users/awesomesauce/Projects/bookstore
  › rails console
  Loading development environment (Rails 5.0.0.1)

  >> my_first_user = User.first
    User Load (0.2ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<User id: 1, username: "CatPower", password_digest: "$2a$10$T9KFCyIrtgFhBtEixMYm9e757ZXa7UlBVOyaAzCtbwt...", created_at: "2017-01-13 02:57:39", updated_at: "2017-01-13 02:57:39">

  >> my_first_user.reviews
    Review Load (0.3ms)  SELECT "reviews".* FROM "reviews" WHERE "reviews"."user_id" = ?  [["user_id", 1]]
  ActiveRecord::StatementInvalid: SQLite3::SQLException: no such column: reviews.user_id: SELECT "reviews".* FROM "reviews" WHERE "reviews"."user_id" = ?
  ...

  >> exit
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  To add a `user_id` column to the `reviews` table, we'll need to create a new migration.

  1.  In Terminal, run the following command:

      ```shell
      rails generate migration add_user_id_to_reviews
      ```

      This will generate a new timestamped migration file named `AddUserIdtoReviews`. It's filename will be something along the lines of `db/migrate/TIMESTAMP_add_user_id_to_reviews.rb`
{% endlist %}

{% highlight shell %}
  › rails generate migration add_user_id_to_reviews
        invoke  active_record
        create    db/migrate/20170124223830_add_user_id_to_reviews.rb
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  The `AddUserIdtoReviews` migration will be very similiar to another migration you've created. Can you think of which one?

  1.  `AddUserIdtoReviews` is gonna look a lot like `AddBookIdToReviews`.

      ```ruby
      class AddBookIdToReviews < ActiveRecord::Migration[5.0]
        def change
          add_column :reviews, :book_id, :integer
        end
      end
      ```

      You added a `book_id` column to the `reviews` table because you wanted to define the relationship between books and reviews on the database level. Remember, a book can have many reviews.

      We want to do the same thing in `AddUserIdtoReviews`, except we're adding a `user_id` to `reviews`.

  1.  Using this as an example, update the `change` method of the `AddUserIdtoReviews` migration to add a `user_id` column to the `reviews` table. The `user_id` column should be an integer column.
{% endlist %}

{% highlight ruby %}
  class AddUserIdToReviews < ActiveRecord::Migration[5.0]
    def change
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What does your change look like? You should've added the following line to the `change` method:

      ```ruby
      add_column :reviews, :user_id, :integer
      ```

  1.  If you didn't already, add this line, save your changes, and run the migration.
{% endlist %}

{% highlight ruby %}
  class AddUserIdToReviews < ActiveRecord::Migration[5.0]
    def change
      add_column :reviews, :user_id, :integer
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that we've defined the relationship between users and reviews on both the model **and** the database levels, we can go back to exploring the relationship on the `rails console`.

  1.  Go to Terminal and start the `rails console`.

  1.  Assign your first user to a variable called `my_first_user`.

  1.  Now, try running `my_first_user.reviews`.

      You get an empty collection because `my_first_user` doesn't have any reviews. Let's change that!

  1.  Assign your first book to a variable called `my_first_book`.

  1.  Now, run the following code to create a new review for `my_first_book` that will also be associated with `my_first_user`.

      ```ruby
      my_first_book.reviews.create(body: "This review was written by a user!", user_id: my_first_user.id)
      ```

      By running `my_first_book.reviews.create`, we're creating a new review for `my_first_book`.

      On the new review, we're setting a `body` and a `user_id`. The `user_id` is set to `my_first_user`'s id so the review can be assigned to `my_first_user`.

  1.  Now that `my_first_user` has a review, try running `my_first_user.reviews` again.

      *I thought `my_first_user` would have reviews 😔*

      But `my_first_user` *does* have reviews!

      `my_first_user.reviews` is still returning an empty collection because `my_first_user` doesn't have the new data.

      First, run `my_first_user.reload`. Then, you can run `my_first_user.reviews`.

   1.  Yay! 🎉
{% endlist %}

{% highlight ruby %}
  › rails console
  Loading development environment (Rails 5.0.0.1)
  >> my_first_user = User.first
    User Load (0.2ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]

  => #<User id: 1, username: "CatPower", password_digest: "$2a$10$T9KFCyIrtgFhBtEixMYm9e757ZXa7UlBVOyaAzCtbwt...", created_at: "2017-01-13 02:57:39", updated_at: "2017-01-13 02:57:39">

  >> my_first_user.reviews
    Review Load (0.1ms)  SELECT "reviews".* FROM "reviews" WHERE "reviews"."user_id" = ?  [["user_id", 1]]
  => #<ActiveRecord::Associations::CollectionProxy []>

  >> my_first_book = Book.first
    Book Load (0.3ms)  SELECT  "books".* FROM "books" ORDER BY "books"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => #<Book id: 1, title: "why's (poignant) Guide to Ruby", author: "why the lucky stiff", price_cents: 100, created_at: "2016-12-26 15:51:15", updated_at: "2016-12-30 20:29:14", quantity: 500, description: "Chunky Bacon!">

  >> my_first_book.reviews.create(body: "This review was written by a user!", user_id: my_first_user.id)
     (0.1ms)  begin transaction
    SQL (1.4ms)  INSERT INTO "reviews" ("body", "created_at", "updated_at", "book_id", "user_id") VALUES (?, ?, ?, ?, ?)  [["body", "This review was written by a user!"], ["created_at", 2017-01-25 00:46:42 UTC], ["updated_at", 2017-01-25 00:46:42 UTC], ["book_id", 1], ["user_id", 1]]
     (1.4ms)  commit transaction
  => #<Review id: 8, body: "This review was written by a user!", created_at: "2017-01-25 00:46:42", updated_at: "2017-01-25 00:46:42", book_id: 1, user_id: 1>

  >> my_first_user.reviews
  => #<ActiveRecord::Associations::CollectionProxy []>

  >> my_first_user.reload
    User Load (0.4ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  => #<User id: 1, username: "CatPower", password_digest: "$2a$10$T9KFCyIrtgFhBtEixMYm9e757ZXa7UlBVOyaAzCtbwt...", created_at: "2017-01-13 02:57:39", updated_at: "2017-01-13 02:57:39">

  >> my_first_user.reviews
    Review Load (0.2ms)  SELECT "reviews".* FROM "reviews" WHERE "reviews"."user_id" = ?  [["user_id", 1]]
  => #<ActiveRecord::Associations::CollectionProxy [#<Review id: 8, body: "This review was written by a user!", created_at: "2017-01-25 00:46:42", updated_at: "2017-01-25 00:48:55", book_id: 1, user_id: 1>]>
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that your first user has a review, let's take a closer look at that review.

  1.  Run the following code to assign the new review to a variable called `my_last_review`:

      ```ruby
      my_last_review = Review.last
      ```

  1.  `my_last_review` should have a `user_id`. Try running `my_last_review.user_id`.

      This will return the `user_id` of the user who's associated to `my_last_review`. Since we set it to `my_first_user`'s id, it will most likely be 1.

  1.  Now, let's try to get the user from the review. Try running `my_last_review.user`.

  1.  Hmm...that's an interesting error. Any thoughts on why you got a `NoMethodError`.

      (The hint is in the error)

      You got a `NoMethodError` because we haven't completely defined the relationship between users and reviews. You defined part of the relationship - a user has many reviews. However, you haven't defined the relationship between reviews and users.
{% endlist %}

{% highlight ruby %}
  >> my_last_review = Review.last
    Review Load (0.2ms)  SELECT  "reviews".* FROM "reviews" ORDER BY "reviews"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<Review id: 8, body: "This review was written by a user!", created_at: "2017-01-25 00:46:42", updated_at: "2017-01-25 00:48:55", book_id: 1, user_id: 1>

  >> my_last_review.user_id
  => 1

  >> my_last_review.user
  NoMethodError: undefined method `user' for #<Review:0x007fce9e4a5b90>
  Did you mean?  user_id
  ...
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  We need to define the relationship between reviews and users - a review belongs to a user.

  1.  Open `app/models/reviews.rb`. You might notice another relationship we already defined 😉

      Since a review also belongs to a book, you previously added this line:

      ```ruby
      belongs_to :book
      ```

      Now, we need to do the same thing for users.

  1.  Update `Review` so a review `belongs_to` a user.
{% endlist %}

{% highlight ruby linenos %}
  class Review < ApplicationRecord
    belongs_to :book
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  That probably sounded more challenging than it was 😅

  1.  You should've added this line

      ```ruby
      belongs_to :user
      ```

  1.  If you didn't already, add this line to `Review` and save your changes.
{% endlist %}

{% highlight ruby linenos %}
  class Review < ApplicationRecord
    belongs_to :book
    belongs_to :user
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now, let's see if we can't get your last review's user.

  1.  Go back to the `rails console` and run the following line to pull in your changes.

      ```ruby
      reload!
      ```

  1.  Get your last review again and assign it to `my_last_review`.

  1.  Now, try running `my_last_review.user`.

  1.  Yayay!!!

      ![YES!](https://media.tenor.co/images/8eec658600640ea3f7f2f583f156f5cc/raw "We should serve this file locally")

  1.  Exit the `rails console`.
{% endlist %}

{% highlight ruby %}
  >> reload!
  Reloading...
  => true

  >> my_last_review = Review.last
    Review Load (0.1ms)  SELECT  "reviews".* FROM "reviews" ORDER BY "reviews"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<Review id: 8, body: "This review was written by a user!", created_at: "2017-01-25 00:46:42", updated_at: "2017-01-25 00:48:55", book_id: 1, user_id: 1>

  >> my_last_review.user
    User Load (0.2ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  => #<User id: 1, username: "CatPower", password_digest: "$2a$10$T9KFCyIrtgFhBtEixMYm9e757ZXa7UlBVOyaAzCtbwt...", created_at: "2017-01-13 02:57:39", updated_at: "2017-01-13 02:57:39">

  >> exit
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that we have a way to assign reviews to their users, let's update your bookstore so we always know who's leaving reviews.

  1.  Do you remember how reviews get created when users visit your bookstore?

      After a user has logged in, they can go to a book and click the "Add a Review" link. The link will take them to the new review page (`app/views/reviews/new.html.erb`).

      Then, users write their reviews in the "Body" field of the new review form. When they're done, they submit the form and its data by clicking the "Create Review" button.

      The form gets submitted to the `ReviewsController` `create` method. Let's take a look at it.

  1.  In you text editor, open the `ReviewsController` (`app/controllers/reviews_controller.rb`) and take a look at the `create` method.

      ```ruby
      def create
        book = Book.find(params[:book_id])
        book.reviews.create(review_params)
        redirect_to book_path(book)
      end
      ```

      In the `create` method, you first find the book that's being reviewed. After you get a hold of that book, you create a new review using `review_params`.

      `review_params` is a method that defines which of the form's fields can be set on the new review.

      ```ruby
      def review_params
        params.require(:review).permit(:body)
      end
      ```

      You set it up so the form must submit a `review` hash, and the only field you're permitting in that hash is the `body` field.

  1.  *This is great and all, but what does it have to do with assigning reviews to their users?*

      Right now the only thing we can set on new reviews is a `body`. If we want assign reviews to their users, we also need to be able to set the new review's `user_id`.

      This raises a couple of questions...
{% endlist %}

{% highlight ruby linenos %}
  class ReviewsController < ApplicationController
    before_action :verify_user_session

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

    def verify_user_session
      if session[:user_id].blank?
        flash[:alert] = "Please login to continue"
        redirect_to new_session_path
      end
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What are some questions that come to mind?

      One question I can think of is how do we know what the new review's `user_id` should be?

      Well, logged in users are the only users who can create reviews, and we know when users are logged in!

      When a user logs in, you save their id in the session hash as `user_id`.

      ```ruby
      class SessionsController < ApplicationController
        ...

        def create
          user = User.find_by(username: params[:session][:username])

          if user && user.authenticate(params[:session][:password])
            ...
            session[:user_id] = user.id
            ...
          end
        end

        ...
      end
      ```

      The session hash is available in all your controllers, so we always know the logged in user's id.

  1.  The next question I have is how are we going to set this thing?

      🤔

      What does the `ReviewsController` `create` method look like again?

      ```ruby
      def create
        book = Book.find(params[:book_id])
        book.reviews.create(review_params)
        redirect_to book_path(book)
      end
      ```

      Right. To create a new review for the book being reviewed, we do `book.reviews.create`. We're using `review_params` to decide which values can be set on the new review.

      Maybe we should change `review_params`...
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's change the `ReviewsController` `review_params` method!

      Change `review_params` from

      ```ruby
      def review_params
        params.require(:review).permit(:body)
      end
      ```

      to

      ```ruby
      def review_params
        permitted_params = params.require(:review).permit(:body)
        permitted_params.merge(user_id: session[:user_id])
      end
      ```

      We still need to use strong parameters to permit the form fields that'll get set on the new review, but we'll assign them to a variable called `permitted_params`.

      Then, we'll use `merge` to add `user_id` to `permitted_params`. `user_id` will be set to `session[:user_id]`.

  1.  Save your changes and start your application's web server.

  1.  Now, login and write a new book review!
{% endlist %}

{% highlight ruby linenos %}
  class ReviewsController < ApplicationController
    before_action :verify_user_session

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
      permitted_params = params.require(:review).permit(:body)
      permitted_params.merge(user_id: session[:user_id])
    end

    def verify_user_session
      if session[:user_id].blank?
        flash[:alert] = "Please login to continue"
        redirect_to new_session_path
      end
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Did you write a really inspiring review?? 😉

      Let's take a look at it on the `rails console`.

  1.  Stop your application's web server and start the `rails console`.

  1.  Now, get your last review and assign it to a variable called `my_last_review`.

  1.  Let's see who write your last review...

      Run `my_last_review.user`.

      Yay! I hope "CatPower" left a good review 😝

  1.  Exit the `rails console` and restart your application's web server.
{% endlist %}

{% highlight ruby %}
  >> my_last_review = Review.last
    Review Load (0.2ms)  SELECT  "reviews".* FROM "reviews" ORDER BY "reviews"."id" DESC LIMIT ?  [["LIMIT", 1]]
  => #<Review id: 9, body: "New review, who this?", created_at: "2017-01-26 23:19:29", updated_at: "2017-01-26 23:19:29", book_id: 1, user_id: 1>

  >> my_last_review.user
    User Load (0.2ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  => #<User id: 1, username: "CatPower", password_digest: "$2a$10$T9KFCyIrtgFhBtEixMYm9e757ZXa7UlBVOyaAzCtbwt...", created_at: "2017-01-13 02:57:39", updated_at: "2017-01-13 02:57:39">

  >> exit
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that we know who's leaving reviews, let's share that information with your bookstore's visitors.

  1.  Do you remember where reviews are shown?

      In your text editor, open `app/views/books/show.html.erb`.

  1.  Towards the end of the template, you're showing all of a books reviews in an unordered list. Let's include review usernames in the unordered list.

      Change the reviews unordered list from

      ```erb
      <ul>
        <% @book.reviews.each do |review| %>
          <li> <%= review.body %> </li>
        <% end %>
      </ul>
      ```

      to

      ```erb
      <ul>
        <% @book.reviews.each do |review| %>
          <% if(review.user.present?) %>
            <li> <%= review.user.username %> - <%= review.body %> </li>
          <% else %>
            <li> Anonymous - <%= review.body %> </li>
          <% end %>
        <% end %>
      </ul>
      ```

      We'll show the usernames for reviews who have users. However, you probably have some older reviews in your database that don't have users. When that happens, we'll show "Anonymous" instead.

  1.  Save your changes and visit a book with reviews. You should see a mix of anonymous and not so anonymous users that have left behind some reviews 😊

  1.  Try adding new reviews. If you're still logged in as "CatPower", she'll start getting a lot of reviews in her name...

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
      <% if(review.user.present?) %>
        <li> <%= review.user.username %> - <%= review.body %> </li>
      <% else %>
        <li> Anonymous - <%= review.body %> </li>
      <% end %>
    <% end %>
  </ul>

  <% if session[:user_id].present? %>
    <%= link_to("Edit book", edit_book_path(@book), class: "button") %>
    <%= link_to("Add a Review", new_book_review_path(@book), class: "button") %>
    <%= button_to("Delete Book", book_path(@book), method: :delete, class: "button danger") %>
  <% end %>
{% endhighlight %}
{% endsteps %}
