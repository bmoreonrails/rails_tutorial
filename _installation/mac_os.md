---
url: mac_os.html
number: i
title: Installation on Mac OS X
layout: rails_tutorial
---

{:.sectionheader}
# Mac OS X install

To get a mac ready for Ruby on Rails development, we need to do the following:

1. install command-line tools (XCode)
2. install ruby
3. install rails

We're going to do these tasks via the Terminal console, so if you aren't familiar with that, please read **this non-existent page** over first.

## Command-line tools

When you are installing ruby and ruby gems (libraries), your system will often need to compile code for you.  The compilers for this can be installed with XCode, the development tool suite for native mac os development.  If you think you might want to do some mac os x or iOS development, go ahead and install XCode (it's a LARGE download...), but if you just want to ignore this part and get on with Ruby on Rails, you can install just the Command-line tools.

If you aren't sure if you need this, try typing `gcc` in a terminal window. (`gcc` is the name of the compiler and stands for GNU Compiler Collection):

{% highlight bash %}
   > gcc --version
{% endhighlight %}

If you get the message, `-bash: gcc: command not found`, install the command-line tools with the command:

{% highlight bash %}
  > xcode-select --install
{% endhighlight %}

Note that this will download the command-line tools and install them.  Once installed, `gcc -version` should print out some information about the compiler, e.g.:

{% highlight bash %}
  > gcc --version
{% endhighlight %}

This should result in something similar to the following:

{% highlight bash %}
  Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
  Apple LLVM version 8.0.0 (clang-800.0.38)
  Target: x86_64-apple-darwin15.6.0
  Thread model: posix
  InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
{% endhighlight %}


## "Easy" ruby installs with rvm

The [Ruby Version Manager (rvm)](http://rvm.io/) will allow you to install different versions of ruby on your machine and switch between them as you switch from one job to another.  This can save you from the pain of upgrading an old project to the newest ruby version when it's running along just fine.

To install rvm, open a terminal window and run the following commands (copied directly off of the rvm website):

{% highlight bash %}
  > gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
{% endhighlight %}

Now that you have rvm installed, you can use it to install ruby.  By default, it installs the latest version, but if you want/need an older version, that's easy too.  For now, let's install the latest version (as of 12/3/2016), v2.3.1:

{% highlight bash %}
  > rvm install 2.3.1
  > rvm default use 2.3.1
{% endhighlight %}

At this point, you should have ruby installed and available to you.

{% highlight bash %}
  > ruby -v
  # => ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]
{% endhighlight %}

## Install Rails

Now that ruby is installed, installing rails is simple.  Just run the following command:

{% highlight bash %}
  > gem install rails 5.0.0
{% endhighlight %}

If that succeeds, you should be able to run rails on the command-line:

{% highlight bash %}
  > rails --version
{% endhighlight %}

## Test it out

Now that we have everything we need installed, let's try it out.

{% highlight bash %}
  > rails new test_rails
  > cd test_rails
  > rails server
{% endhighlight %}

You should see output similar to this:

{% highlight bash %}
  => Booting Puma
  => Rails 5.0.0.1 application starting in development on http://localhost:3000
  => Run `rails server -h` for more startup options
  Puma starting in single mode...
  * Version 3.6.2 (ruby 2.3.1-p112), codename: Sleepy Sunday Serenity
  * Min threads: 5, max threads: 5
  * Environment: development
  * Listening on tcp://localhost:3000
  Use Ctrl-C to stop
{% endhighlight %}

If you see the output above, rails is running and you can point your browser at http://localhost:3000 and you should see this:

{% include figure.html url="/assets/images/youre_on_rails.png" description="Yay! You're on Rails!" %}

