---
url: 14.html
number: 14
title: Logged In vs Logged Out Users
layout: rails_tutorial
---
{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}


{% aside %}
  You're logged out, but isn't it a little weird that you still see the "Log Out" link?

  {% screenshot %}
  ![Browser showing bookstore after logging out. The "Log Out" link is still on the page.]({{site.baseurl}}/assets/images/log_out_still.png)
  {% endscreenshot %}

  Let's change that! We'll only show the "Log Out" link to users who are logged in.
{% endaside %}

{% steps %}
{% list %}
  1.  If we only want to show the "Log Out" link to *logged in* users, we first have to figure out if a user is logged in or not. Fortunately, we already have the parts in place to figure this out.

  1.  After a user successfully logs in, you're saving their user id in the session. You did this in the `SessionsController` `create` method.

      ```ruby
      def create
        user = User.find_by(username: params[:session][:username])

        if user && user.authenticate(params[:session][:password])
          ...
          session[:user_id] = user.id
          ...
        else
          ...
        end
      end
      ```

      When a user logs out, you remove their user id from the session. You did this in the `SessionsController` `destroy` method.

      ```ruby
      def destroy
        session[:user_id] = nil
        ...
      end
      ```

      We can tell if a user is logged in or not by checking in the session. If a user id is present, we know that user is logged in. Otherwise, no one is logged in.

  1.  We've only used the session in your controllers, but it's also avaialble in your templates. Let's see what we can do with it.

  1.  Before we get to far, you'll need to log in again.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Open Terminal and go to the `bookstore` directory.

  1.  Now, start you application's web server.

  1.  Go to [http://localhost:3000/session/new](http://localhost:3000/session/new) and log in as "CatPower" with password "password".
{% endlist %}

{% highlight shell %}
  › pwd
  /Users/alimi/Projects/bookstore

  › rails server
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing homepage with "Welcome back, CatPower!" login message]({{site.baseurl}}/assets/images/welcome_back_cat_power.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Now that you're logged in, we can start making some changes 😊

  1.  Open `app/views/layouts/application.html.erb`.

  1.  Above the "Log Out" link, add the following line:

      ```erb
      <p> Hi, my user id is <%= session[:user_id] %> </p>
      ```

      The same session hash you used in the `SessionsController` is also available here in this template.

      With this change, you're going to show what user id is saved in the session. Since you're logged in as "CatPower", it's going to show CatPower's user id.

  1.  Save your changes and revist [http://localhost:3000](http://localhost:3000).
{% endlist %}

{% highlight erb linenos %}
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
        <div class="left">
        </div>

        <div class="center">
          <%= link_to "My Super Rad Bookstore", root_path %>
        </div>

        <div class="right">
          <p> Hi, my user id is <%= session[:user_id] %> </p>
          <%= link_to "Log Out", session_path, method: :delete %>
        </div>
      </div>

      <% if flash[:notice] %>
        <p class="notice"> <%= flash[:notice] %> </p>
      <% end %>

      <% if flash[:alert] %>
        <p class="alert"> <%= flash[:alert] %> </p>
      <% end %>

      <div class="container">
        <%= yield %>
      </div>
    </body>
  </html>
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing "Hi, my user id is 1" above the "Log Out" link]({{site.baseurl}}/assets/images/hi_my_user_id.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Sweet! Now that we know how to access the session in your templates, let's put it to use.

  1.  Reopen `app/views/layouts/application.html.erb`.

  1.  Change the "Log Out" link and its parent `div` from

      ```erb
      <div class="right">
        <p> Hi, my user id is <%= session[:user_id] %> </p>
        <%= link_to "Log Out", session_path, method: :delete %>
      </div>
      ```

      to

      ```erb
      <div class="right">
        <% if session[:user_id].present? %>
          <%= link_to "Log Out", session_path, method: :delete %>
        <% else %>
          I'm not logged in
        <% end %>
      </div>
      ```

      If a `user_id` is set in the session, we'll show the "Log Out" link. Otherwise, we'll just show "I'm not logged in".

  1.  Save your changes and revisit [http://localhost:3000](http://localhost:3000). Log out and you should no longer see the "Log Out" link.
{% endlist %}

{% highlight erb linenos %}
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
        <div class="left">
        </div>

        <div class="center">
          <%= link_to "My Super Rad Bookstore", root_path %>
        </div>

        <div class="right">
          <% if session[:user_id].present? %>
            <%= link_to "Log Out", session_path, method: :delete %>
          <% else %>
            I'm not logged in
          <% end %>
        </div>
      </div>

      <% if flash[:notice] %>
        <p class="notice"> <%= flash[:notice] %> </p>
      <% end %>

      <% if flash[:alert] %>
        <p class="alert"> <%= flash[:alert] %> </p>
      <% end %>

      <div class="container">
        <%= yield %>
      </div>
    </body>
  </html>
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing "I'm not logged in"]({{site.baseurl}}/assets/images/yay_logout_button.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Progress!

      Now that we aren't showing the "Log Out" link to logged out users, let's show them a "Login" link instead.

  1.  In `app/views/layouts/application.html.erb`, replace "I'm not logged in" with a link labeled "Login". The link should go to the `new_session` path.

      Use the other links in the template as examples.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What does your link look like? It should look something like this:

      ```erb
      <%= link_to "Log In", new_session_path %>
      ```

  1.  If you didn't already, add the "Log In" link. Save your changes, revist [http://localhost:3000](http://localhost:3000), and try logging in!
{% endlist %}

{% highlight erb linenos %}
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
        <div class="left">
        </div>

        <div class="center">
          <%= link_to "My Super Rad Bookstore", root_path %>
        </div>

        <div class="right">
          <% if session[:user_id].present? %>
            <%= link_to "Log Out", session_path, method: :delete %>
          <% else %>
            <%= link_to "Log In", new_session_path %>
          <% end %>
        </div>
      </div>

      <% if flash[:notice] %>
        <p class="notice"> <%= flash[:notice] %> </p>
      <% end %>

      <% if flash[:alert] %>
        <p class="alert"> <%= flash[:alert] %> </p>
      <% end %>

      <div class="container">
        <%= yield %>
      </div>
    </body>
  </html>
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing "Log In" link]({{site.baseurl}}/assets/images/login_link.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  If you're anything like me, you probably tried to log out just as soon as you logged in so you could see the link change back and forth.

      ![Sure I did]({{site.baseurl}}/assets/images/Yes-No-Not-Really-GIF.gif)

      But if you're not like me, give it a try! You've got to appreciate the small things in life 😝

  1.  You might also notice that the "Log Out"/"Login" links are on every page of your bookstore.

      `app/views/layouts/application.html.erb` is the main layout file of your application, and it's used by every template in your bookstore. Since we added the links this layout, they will get rendered on every page.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that we have logged in and logged out users, can you think of things logged out users shouldn't be able to do?

      I can think of one - logged out users shouldn't be able to add books. This is *your* super rad bookstore after all. You don't want some random person to come along and start adding books to your bookstore.

  1.  Open `app/views/books/index.html.erb` and find the "Add a book" link. 

      Take some time and try updating the template so the "Add a book" link is only visible to logged in users. Logged out users shouldn't see anything.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What does your solution look like? It should look a lot like the code you used to show the "Log Out" link.

      ```erb
      <% if session[:user_id].present? %>
        <%= link_to("Add a book", new_book_path, class: "button") %>
      <% end %>
      ```

      The difference here is we don't have an `else` statement. Before, we wanted to show a "Login" link to logged out users.

      ```erb
      <% if session[:user_id].present? %>
        <%= link_to "Log Out", session_path, method: :delete %>
      <% else %>
        <%= link_to "Log In", new_session_path %>
      <% end %>
      ```

      Now, we don't want to show anything to logged out users. Therefore, we don't need the `else` statement.

  1.  Update your solution to match this solution and save your changes.

  1.  Go to [http://localhost:3000](http://localhost:3000), and switch between being logged in and logged out.

      When you log out, the "Add a book" link will disappear...

      ![Poof!]({{site.baseurl}}/assets/images/poof.gif)
{% endlist %}

{% highlight erb linenos %}
  <h1>Welcome to My Super Rad Bookstore!</h1>

  <ul>
    <% @books.each do |book| %>
      <li>
        <%= link_to(book.title, book_path(book)) %> by <%= book.author %>
      </li>
    <% end %>
  </ul>

  <% if session[:user_id].present? %>
    <%= link_to("Add a book", new_book_path, class: "button") %>
  <% end %>
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing homepage without "Add a book" link for logged out users]({{site.baseurl}}/assets/images/add_book_link_gone.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Can you think of other things logged out users shouldn't be able to do?

      Right now, if you go to a book's page, anyone can edit, review, or delete a book. I wouldn't want to give such broad powers to anyone in *my* super rad bookstore, and you shouldn't either!

  1.  Open `app/views/books/show.html.erb`. At the end of the template, you have links to edit a book and add a review. You also have a button to delete a book.

      ```erb
      <%= link_to("Edit book", edit_book_path(@book), class: "button") %>

      <%= link_to("Add a Review", new_book_review_path(@book), class: "button") %>

      <%= button_to("Delete Book", book_path(@book), method: :delete, class: "button danger") %>
      ```

      Update the template so the links and button are only available to logged in users.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What did you come up with? Maybe you did something like this:

      ```erb
      <% if session[:user_id].present? %>
        <%= link_to("Edit book", edit_book_path(@book), class: "button") %>
      <% end %>

      <% if session[:user_id].present? %>
        <%= link_to("Add a Review", new_book_review_path(@book), class: "button") %>
      <% end %>

      <% if session[:user_id].present? %>
        <%= button_to("Delete Book", book_path(@book), method: :delete, class: "button danger") %>
      <% end %>
      ```

      This works really well, but doesn't it feel a little repetitive? We're using the same condition for all three elements to decide if they should be rendered or not.

      You can simplify things a bit with something like this:

      ```erb
      <% if session[:user_id].present? %>
        <%= link_to("Edit book", edit_book_path(@book), class: "button") %>
        <%= link_to("Add a Review", new_book_review_path(@book), class: "button") %>
        <%= button_to("Delete Book", book_path(@book), method: :delete, class: "button danger") %>
      <% end %>
      ```

  1.  If you don't have a similar solution, update your solution to match the last solution.

  1.  Save your changes and check out the book details page as a logged in and logged out user.
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

  <% if session[:user_id].present? %>
    <%= link_to("Edit book", edit_book_path(@book), class: "button") %>
    <%= link_to("Add a Review", new_book_review_path(@book), class: "button") %>
    <%= button_to("Delete Book", book_path(@book), method: :delete, class: "button danger") %>
  <% end %>
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing book details page without action elements]({{site.baseurl}}/assets/images/hide_buttons.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Alright, I think we've hidden everything we need to hide from logged out users. Your bookstore is super secure now, right?!

      ![This cop thinks everything is fine]({{site.baseurl}}/assets/images/tenor.gif)

  1.  Make sure you're logged out and try going to [http://localhost:3000/books/new](http://localhost:3000/books/new).

      Anyone can add books!

      ![No!]({{site.baseurl}}/assets/images/no.gif)

  1.  We made it more difficult for logged out users to mess with your bookstore, but that won't stop them if they can figure out the paths to go to.

  1.  We can stop mischievous users from snooping around by checking for logged out users in your controllers.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's start by looking at the `BooksController` `new` method.

      The session is available to us in all of our controllers. Let's use it to check if a user is logged in. If they're logged in, we can do what we've always been doing. Otherwise, let's redirect the user to the login page.

  1.  Open `app/controllers/books_controller.rb`. Change the `new` method from

      ```ruby
      def new
        @book = Book.new
      end
      ```

      to

      ```ruby
      def new
        if session[:user_id].blank?
          flash[:alert] = "Please login to continue"
          redirect_to new_session_path
        else
          @book = Book.new
        end
      end
      ```

      If a user is logged in, their user id will be in the session. If their user id is not in the session, we'll add a flash message and send them to the `new_session_path`. Otherwise, we'll continue with the method's previous behavior.

  1.  Save your changes and revist [http://localhost:3000/books/new](http://localhost:3000/books/new). You should now be redirected to the login page.
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
      if session[:user_id].blank?
        flash[:alert] = "Please login to continue"
        redirect_to new_session_path
      else
        @book = Book.new
      end
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

{% screenshot %}
![Browser showing login page with alert to login before continuing]({{site.baseurl}}/assets/images/oh_no_login.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Now that we have this check in place, we should probably add them to a few more of the `BooksController` methods.

      `index` and `show` should be available to all users, but logged out users shouldn't have access to `create`, `edit`, `update`, or `destroy`.

  1.  One solution to this problem would be to copy the check we added to the `new` method to the rest of the methods we want to secure. This would work, but copying code is suprisingly time consuming. Fortunately, Rails has a method that will help us out.

  1.  Open the `BooksController`. Just after the beginning of the controller, add the following line:

      ```ruby
      before_action :verify_user_session
      ```

      Before every method in the `BooksController`, Rails will first call `verify_user_session`.

  1.  If you try to go to [http://localhost:3000/books/new](http://localhost:3000/books/new) now, you'll get an error. Can you guess why?

      We haven't defined a `verify_user_session` method!

  1.  At the end of the `BooksController`, add the `verify_user_session` method:

      ```ruby
      def verify_user_session
        if session[:user_id].blank?
          flash[:alert] = "Please login to continue"
          redirect_to new_session_path
        end
      end
      ```

  1.  This should look *very* familiar. It's the same logic you used in the `new` method!

      ```ruby
      def new
        if session[:user_id].blank?
          flash[:alert] = "Please login to continue"
          redirect_to new_session_path
        else
          @book = Book.new
        end
      end
      ```

      Since you're doing the check in `verify_user_session`, you don't need it in the `new` method anymore. Remove the check so the `new` method is back to its old self.

      ```ruby
      def new
        @book = Book.new
      end
      ```

  1.  Save your changes and revisit [http://localhost:3000/books/new](http://localhost:3000/books/new). You should still be redirected to the login page.

      Try visiting another page like the edit book page. For example, if you still have your first book you can go to [http://localhost:3000/books/1/edit](http://localhost:3000/books/1/edit). Once again, you should be redirected to the login page.
{% endlist %}

{% highlight ruby linenos %}
  class BooksController < ApplicationController
    before_action :verify_user_session

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
  1.  Now that we have all this security in place, log out and visit [http://localhost:3000](http://localhost:3000).

      ![Wat]({{site.baseurl}}/assets/images/full-house-o.gif)

      We made the `BooksController` a little *too* secure 😅

      Remember, logged out users should still be able to access the `BooksController` `index` and `show` methods.

  1.  Open the `BooksController`. After the `before_action`, add the following line:

      ```ruby
      skip_before_action :verify_user_session, only: [:index, :show]
      ```

      This tells Rails to skip the `before_action` that calls `verify_user_session` for the `index` and `show` methods.

  1.  Save your changes and revisit [http://localhost:3000](http://localhost:3000).

      Now that you're back in, try going directly to a book's detail page. For example, you could go to [http://localhost:3000/books/1](http://localhost:3000/books/1).

      Try visiting different paths directly as logged in and logged out users. The book index and details page should be available to both, but only logged in users can reach things like the edit book page.
{% endlist %}

{% highlight ruby linenos %}
  class BooksController < ApplicationController
    before_action :verify_user_session
    skip_before_action :verify_user_session, only: [:index, :show]

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
  1.  Now that we have the `BooksController` locked down, let's add the same checks to the `ReviewsController`.

  1.  Open the `ReviewsController` (`app/controllers/reviews_controller.rb`).

  1.  Using the `BooksController` as an example, add a `before_action` to the `ReviewsController` that calls `verify_user_session` before each of the controller's methods.

      `verify_user_session` should redirect logged out users to the `new_session` path so they can login.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  How did you change the `ReviewsController`. The `before_action` line should've been a spitting image of the `before_action` line from the `BooksController`.

      ```ruby
      before_action :verify_user_session
      ```

      What about the `verify_user_session` method? It should also be a spitting image 😊

      ```ruby
      def verify_user_session
        if session[:user_id].blank?
          flash[:alert] = "Please login to continue"
          redirect_to new_session_path
        end
      end
      ```

  1.  If you didn't already, add the `before_action` and the `verify_user_session` method to the `ReviewsController`.

  1.  Save your changes and trying visting a new review page as both a logged out and logged in user. For example, you would add a new review for your first book by visiting [http://localhost:3000/books/1/reviews/new](http://localhost:3000/books/1/reviews/new).

  1.  When you're done exploring all your changes, stop your application's web server.
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
