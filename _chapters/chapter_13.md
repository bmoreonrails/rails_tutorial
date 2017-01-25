---
url: 13.html
number: 13
title: Logging In and Logging Out
layout: rails_tutorial
---
{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}


{% steps %}
{% list %}
  1.  Your bookstore has users, but there's no way for them to login. Let's change that 😊

  1.  Let's start by looking at your application's routes file. Open `config/routes.rb` in your text editor.

  1.  You've added a couple of resources to the routes file. First, you defined `:books`. This added a series of routes to your application for creating, reading, updating, and deleting your books. Then, you added another resource `:reviews`. This added similar routes, but they're focused on reviews instead of books.

      Now that your application has users, it might be tempting to add a `:users` resource. This would be useful if we were going to change user data, but we don't need to change any user data to log someone in.

      We just need to keep track of a user once they've logged in to your bookstore. We'll represent this as a session - a user creates a new session when they log in.

  1.  Let's add a `:session` resource to your routes file. Before the end of `config/routes.rb`, add the following line:

      ```ruby
      resource :session
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

    resource :session
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's see what your application routes look like now.

  1.  Open Terminal, go the `bookstore` directory, and run `rake routes`.

  1.  Aww, your routes are getting so big 😍

      When a user logs in, they're going to create a new session. What path will they visit to create a new session?

      They'll go to `/session/new`.

      ```shell
      new_session GET    /session/new(.:format)                     sessions#new
      ```

  1.  Start your application's web server and visit the new session path at [http://localhost:3000/session/new](http://localhost:3000/session/new).
{% endlist %}

{% highlight shell %}
  › pwd
  /Users/awesomesauce/Projects/bookstore

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
           session POST   /session(.:format)                         sessions#create
       new_session GET    /session/new(.:format)                     sessions#new
      edit_session GET    /session/edit(.:format)                    sessions#edit
                   GET    /session(.:format)                         sessions#show
                   PATCH  /session(.:format)                         sessions#update
                   PUT    /session(.:format)                         sessions#update
                   DELETE /session(.:format)                         sessions#destroy

  › rails server
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing Routing Error: "uninitialized constant SessionsController"]({{site.baseurl}}/assets/images/uninitialized_constant_sessions.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Oh boy, another `Routing Error`! 😝

  1.  The error tells you what's wrong...

      ```
      uninitialized constant SessionsController
      ```

  1.  Fix this familiar error and come back when you get a different one.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Were you able to get past the `Routing Error`?

      No worries if you're stuck, we'll help you out 😊

  1.  You're getting a `Routing Error` because you application doesn't have a `SessionsController`.

      To fix this, you need to create a `SessionsController`.

  1.  All controllers follow a similar pattern. They live inside the `app/controllers` directory, and they're filename matches their name.

      For example, the `SessionsController` will be a file named `app/controllers/sessions_controller`.

  1.  Controllers also share the same roots. Do you remember what your `BooksController` looked like when you first added it?

      ```ruby
      class BooksControllers < ApplicationController
      end
      ```

      There wasn't much to it, remember?

  1.  If you didn't create an empty `SessionsController` (`app/controllers/sessions_controller`), go ahead and create now.

      ```ruby
      class SessionsController < ApplicationController
      end
      ```

  1.  Then, revisit [http://localhost:3000/session/new](http://localhost:3000/session/new) to see your next error!
{% endlist %}
{% endsteps %}

{% screenshot %}
![Browser showing Unknown action error: "The action 'new' could not be found for SessionsController"]({{site.baseurl}}/assets/images/session_unknown_new_action.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Now, you're getting an `Unknown action` error. Just like the last error, it's giving you a hint.

      ```
      The action 'new' could not be found for SessionsController
      ```

  1.  You know what to do, right?!

      ![...YES]({{site.baseurl}}/assets/images/yup.gif)

  1.  Fix that error. When you're done, you'll get *one more error*.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What did you come up with?! Are you seeing a new error??

  1.  You had to add a `new` method to the `SessionsController`.

      ```ruby
      def new
      end
      ```

  1.  If you didn't already add the `new` method, go ahead and add it now.
{% endlist %}

{% highlight ruby linenos %}
class SessionsController < ApplicationController
  def new
  end
end
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing ActionController::UnknownFormat error: "SessionsController#new is missing a template for this request format and variant."]({{site.baseurl}}/assets/images/missing_template_sessions_new.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  We're *sooooo* close to the end of the error train.

      Can you think of reason why you're getting an `ActionController::UnknownFormat` error? It looks crazy, but we've seen this plenty of times before.

  1.  You're getting an `ActionController::UnknownFormat` error because the `SessionsController` `new` action doesn't have a template.

  1.  Fix this error!

      Remember, templates for the `SessionsController` will live inside `app/views/sessions`.

      When you're done, [http://localhost:3000/session/new](http://localhost:3000/session/new) will render a blank page.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Did you figure out how to add the `SessionsController` `new` template?

      You had to add a new directory.

      ```shell
      mkdir app/views/sessions
      ```

      Then, you had to create an empty template file named `new.html.erb` inside `app/views/sessions`.

      ```shell
      touch app/views/sessions/new.html.erb
      ```

  1.  If you didn't already, add the empty `SessionsController` `new` template file (`app/views/sessions/new.html.erb`).

      If you're following the steps we just laid out, you'll have to stop your application's web server before running the commands. When you're done, you can restart it.

  1.  Ah, has a blank page ever looked so good...
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  A blank page is great and all, but wouldn't it be even better if a user could log in?!

      In the `SessionsController` `new` template, we need to render a form where users can enter their credentials to create a new session and log in.

  1.  Open `app/views/sessions/new.html.erb` and add the following:

      ```erb
      <%= form_for(:session, url: session_path) do |f| %>
      <% end %>
      ```

      The `form_for` might look a little familiar. We've used it to build forms for adding and updating books, and adding new reviews. However, there are a few differences.

      In the past forms you've built with `form_for`, you started by passing an instance of the record you wanted to update or create. For example, the new books form has a new instance of `Book`.

      ```erb
      <%= form_for(@book) do |f| %>
      ```

      We aren't doing this for the new session form because we're not going to save the session in the database. We're going to save it in the browser (more on that later).

      Unlike the other forms, we have to specify a URL for the new session form. `form_for` can figure out where to send the form data when given an instance of a class; otherwise, you have to expcitily set the URL.

      Other than that, the new session form is just like the other forms you've built.

  1.  Using the new book form in `app/views/books/new.html.erb` as an example, add two text fields to the new sessions form.

      First, add a text field labeled "Username".

      Then, add a text field labeled "Password".

      Finally, add a form submission button.
{% endlist %}

{% highlight erb linenos %}
  <%= form_for(:session, url: session_path) do |f| %>
  <% end %>
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  What does your solution look like? It should look something like this:

      ```erb
      <%= form_for(:session, url: session_path) do |f| %>
        <ul>
          <li>
            <%= f.label :username %>
            <%= f.text_field :username %>
          </li>

          <li>
            <%= f.label :password %>
            <%= f.text_field :password %>
          </li>
        </ul>

        <%= f.submit(class: "button") %>
      <% end %>
      ```

  1.  Update your soultion to match this solution. Save your changes and take a look at the form by visiting [http://localhost:3000/session/new](http://localhost:3000/session/new).
{% endlist %}

{% highlight erb linenos %}
  <%= form_for(:session, url: session_path) do |f| %>
    <ul>
      <li>
        <%= f.label :username %>
        <%= f.text_field :username %>
      </li>

      <li>
        <%= f.label :password %>
        <%= f.text_field :password %>
      </li>
    </ul>

    <%= f.submit(class: "button") %>
  <% end %>
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing new session form]({{site.baseurl}}/assets/images/new_session_form.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Yay! The form looks so good!!

      But you might've noticed a couple of...weird things.

  1.  First, did you try typing anything in the "Password" field. It shows up as plain text!

      That's not great if we're trying to protect passwords. Fortunately, we can change this behavior.

  1.  Also, the form submission button doesn't have the friendliest message. "Save Session" is *technically* right, but most users probably expect to see something like "Login".

  1.  Let's make these things better!

      ![Spongebob can't wait!]({{site.baseurl}}/assets/images/spongebobcantwait.gif)
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  First, we can change the "Password" field from a text field to a password field.

  1.  Reopen `app/views/sessions/new.html.erb` and change

      ```erb
      <%= f.text_field :password %>
      ```

      to

      ```erb
      <%= f.password_field :password %>
      ```

  1.  Now, let's change the text of the form submission button to "Login". Change

      ```erb
      <%= f.submit(class: "button") %>
      ```

      to

      ```erb
      <%= f.submit("Login", class: "button") %>
      ```

  1.  Save your changes, revisit [http://localhost:3000/session/new](http://localhost:3000/session/new), and try logging in!

      You should have a user with username "CatPower" and a password of "password".
{% endlist %}
{% endsteps %}

{% screenshot %}
![Browser showing Unknown action error: "The action 'create' could not be found for SessionsController"]({{site.baseurl}}/assets/images/unknown_create_session.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  ...

      ![Why'd it have to be errors?]({{site.baseurl}}/assets/images/cowboys.jpg)

      You know how to deal with `Unknown action` errors, right?!

      ![Of course]({{site.baseurl}}/assets/images/genewilder.gif)

  1.  Fix this error!

      When you're done, submitting the form shouldn't do anything.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  How did you get past that `Unknown action` error?

      You added an empty `create` method to the `SessionsController`, right?

      ```ruby
      def create
      end
      ```

  1.  If you didn't already, add an empty `create` method to the `SessionsController`.
{% endlist %}

{% highlight ruby linenos %}
  class SessionsController < ApplicationController
    def new
    end

    def create
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Nothing happens when you try to login, but how *could* anything happen. The new session form is being submitted to the `SessionsController` `create` method, and that method is empty.

      Let's update the `create` method so users can login.

  1.  Just like past forms, the new session form data is available in the `SessionsController` inside the `params` hash. If you take a look at your application's web server's output, you can see the params coming in.

      ```shell
      Parameters: {"utf8"=>"✓", "authenticity_token"=>"C2s/BLrDEpUMmOL+FMx6SqNzLTqKvcLlvpw32+lD2O32Aryi9Kt0tlWVM+gUS3DYhQt1+3q0Tn3kqakWdZylVw==", "session"=>{"username"=>"CatPower", "password"=>"[FILTERED]"}, "commit"=>"Login"}
      ```

      The form data is tucked in the `session` hash, and it includes a username and password.

      We can use the form data with the `authenticate` method to log users in.

  1.  First, we'll need to find the user by their username. Add the following code inside the `create` method:

      ```ruby
      user = User.find_by(username: params[:session][:username])
      ```

      `find_by` is a handy method that let's us get records from your database with something other than an id. We're using `find_by` here to get the user by their username.

  1.  Now that we have the user's record, we can check if they've given us a valid password. Add the following code to the `create` mehtod:

      ```ruby
      if user.authenticate(params[:session][:password])
        flash[:notice] = "Welcome back, #{user.username}!"
        session[:user_id] = user.id
        redirect_to root_path
      else
        flash[:alert] = "Sorry, your username or password is invalid."
        render :new
      end
      ```

      First, we'll try to `authenticate` the user. If the user is successfully authenticated, we'll

        * show them a success message
        * save their id in the browser's session as `user_id`
        * send them to the `root_path`

      If the user cannot be authenticated, we'll

        * show them a failure message
        * re-render the `new` template so they can try logging in again

  1.  There's a lot happening here, so let's try to break it down to get a better feel for what each of these lines of code is doing. 

      Before we continue, save your changes.
{% endlist %}

{% highlight ruby linenos %}
  class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.find_by(username: params[:session][:username])
      if user.authenticate(params[:session][:password])
        flash[:notice] = "Welcome back, #{user.username}!"
        session[:user_id] = user.id
        redirect_to root_path
      else
        flash[:alert] = "Sorry, your username or password is invalid."
        render :new
      end
    end
  end
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Let's start by looking at this line:

      ```ruby
      session[:user_id] = user.id
      ```

  1.  Rails saves a session for every user that visits your application. By default, these sessions are stored in the user's browser using something called [cookies](https://en.wikipedia.org/wiki/HTTP_cookie). Cookies are small files that browsers can use to save data on a user's machine.

      To protect the session's contents, Rails signs and encrypts it so the contents are only accessible by the Rails application.

  1.  Rails makes the session available as a `session` hash. You can save anything inside the `session` hash. For example, we decided to store a `user_id`.

      ```ruby
      session[:user_id] = user.id
      ```

  1.  Sessions are probably feeling really abstract right now, but they'll make more sense when you see them in action.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  In the `create` method, we also made use of the flash.

      ```ruby
      flash[:notice] = "Welcome back, #{user.username}!"
      ```

      ```ruby
      flash[:alert] = "Sorry, your username or password is invalid."
      ```

  1.  The flash is also part of the session, but it doesn't get saved in the user's browser. Instead, the flash is cleared after every request.

      We can take advantage of the flash's short life cycle to temporarily show messages. For example, imagine what happens after you a user logs in to your bookstore. It's nice to see the welcome back message, but you don't really need continue seeing that message as you make your rounds through the bookstore.

  1.  Just like the session, the flash is made available in your application as a `flash` hash. You can also store anything in the flash, but it's commonly used to save things like `notice`s and `alert`s.

  1.  In the `create` method, you're putting the succes message in `flash[:notice]` and the failure message is `flash[:alert]`. To show these messages, we need to make a change to your application's layout template.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Open `app/views/layouts/application.html.erb`.

  1.  Before the `container` `div`, add the following lines:

      ```erb
      <% if flash[:notice] %>
        <p class="notice"> <%= flash[:notice] %> </p>
      <% end %>

      <% if flash[:alert] %>
        <p class="alert"> <%= flash[:alert] %> </p>
      <% end %>
      ```

      If anything is inside `flash[:notice]` or `flash[:alert]`, we'll render their contents.

  1.  Save your changes.
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
        <div class="center">
          <%= link_to "My Super Rad Bookstore", root_path %>
        </div>
      </div>

      <% if flash[:notice] %>
        <p class="notice"> <%= flash[:notice] %> </p>
      <% end %>

      <% if flash[:alert] %
        <p class="alert"> <%= flash[:alert] %> </p>
      <% end %>

      <div class="container">
        <%= yield %>
      </div>
    </body>
  </html>
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that you have a fully functional `create` method, let's take it out for a spin!

      ![Car flying away]({{site.baseurl}}/assests/images/Flyingcar.gif)

  1.  Go to [http://localhost:3000/session/new](http://localhost:3000/session/new) and try logging in with an invalid username.

      ...

      ![Not again]({{site.baseurl}}/assets/images/ugh.gif)
{% endlist %}
{% endsteps %}

{% screenshot %}
![Browser showing NoMethodError: "undefined method `authenticate' for nil:NilClass"]({{site.baseurl}}/assets/images/invalid_user_name_error.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  This error is a little tricky. Remember when we used `find_by` in the `create` method to get the user by their username?

      ```ruby
      user = User.find_by(username: params[:session][:username])
      ```

      `find_by` will return the user only if a user with that username exists. Otherwise, it returns `nil`. So when you try to log in with an invalid username, `user` becomes nil.

      That's why you're seeing the `NoMethodError` - you can't call `authenticate` on `nil`.

  1.  To fix this error, we'll need to make a change in the `create` method.

  1.  Open `app/views/controllers/sessions_controller.rb`. Inside the `create` method change

      ```ruby
      if user.authenticate(params[:session][:password])
      ```

      to

      ```ruby
      if user && user.authenticate(params[:session][:password])
      ```

      With this change, `user.authenticate` will only be called if the user exists.

  1.  Save your changes, revisit [http://localhost:3000/session/new](http://localhost:3000/session/new), and try logging in with an invalid username again.
{% endlist %}

{% highlight ruby linenos %}
  class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.find_by(username: params[:session][:username])

      if user && user.authenticate(params[:session][:password])
        flash[:notice] = "Welcome back, #{user.username}!"
        session[:user_id] = user.id
        redirect_to root_path
      else
        flash[:alert] = "Sorry, your username or password is invalid."
        render :new
      end
    end
  end
{% endhighlight %}
{% endsteps %}

{% screenshot %}
![Browser showing failure message when logging in with an invalid username]({{site.baseurl}}/assets/images/successful_invalid_username.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Yay! That's a lot better, isn't it?

  1.  Now try logging in as "CatPower", but use an invalid password. You should still get the failure message.

  1.  Finally, try logging in as "CatPower" using "password" as the password.
{% endlist %}
{% endsteps %}

{% screenshot %}
![Browser showing success message when logging in]({{site.baseurl}}/assets/images/success_valid_login.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  YAYAY!!!

  1.  Try clicking around the bookstore. The success message should go way as soon as you visit a new page.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
  1.  Now that you're logged in, let's make it so you can log out!

      Let's add a "Log out" link to your bookstore's header.

  1.  Open `app/views/layouts/application.html.erb`. Change the "navigation" `div` from

      ```erb
      <div class="navigation">
        <div class="center">
          <%= link_to "My Super Rad Bookstore", root_path %>
        </div>
      </div>
      ```

      to:

      ```erb
      <div class="navigation">
        <div class="left">
        </div>

        <div class="center">
          <%= link_to "My Super Rad Bookstore", root_path %>
        </div>

        <div class="right">
          <%= link_to "Log Out", session_path, method: :delete %>
        </div>
      </div>
      ```

      Inside the "navigation" `div`, we're adding two `div`s: a "left" `div` and a "right" `div`. The "left" `div` is there to just keep things aligned. The "right" `div` is really the one we're interested in.

      In the "right" `div`, we're adding a "Log Out" link. When the link is clicked, it will send a DELETE request to the `session_path` (`/session`).

  1.  Visit [http://localhost:3000](http://localhost:3000) to see the new "Log Out" link.

      What do you think will happen if you try logging out? Give it a try 🙃
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
![Browser showing homepage with a "Log Out" link]({{site.baseurl}}/assets/images/yay_logout_link.png)
{% endscreenshot %}

{% screenshot %}
![Browser showing Unknown action error: "The action 'destroy' could not be found for SessionsController"]({{site.baseurl}}/assets/images/logout_destroy_unknown.png)
{% endscreenshot %}

{% steps %}
{% list %}
  1.  Since the "Log Out" link sends a DELETE request, it gets routed to the `SessionsController` `destroy` method. Whelp, that explains the error you're seeing.

      ```
      The action 'destroy' could not be found for SessionsController
      ```

  1.  Let's create the `destroy` method. Open the `SessionsController` (`app/controllers/sessions_controller.rb`), and add the following method:

      ```ruby
      def destroy
        session[:user_id] = nil
        flash[:notice] = "See ya next time!"
        redirect_to root_path
      end
      ```

      The first line of this method removes the user_id we saved in the session by setting `session[:user_id]` to nil. The second line show a friendly message confirming the user has been logged out. The final line redirects the user to the `root_path`.

  1.  Save your changes and try logging out! After you've logged out, stop your application's web server.
{% endlist %}

{% highlight ruby linenos %}
  class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.find_by(username: params[:session][:username])

      if user && user.authenticate(params[:session][:password])
        flash[:notice] = "Welcome back, #{user.username}!"
        session[:user_id] = user.id
        redirect_to root_path
      else
        flash[:alert] = "Sorry, your username or password is invalid."
        render :new
      end
    end

    def destroy
      session[:user_id] = nil
      flash[:notice] = "See ya next time!"
      redirect_to root_path
    end
  end
{% endhighlight %}
{% endsteps %}
