---
url: mac_os.html
title: Installation on Mac OS X
layout: rails_installation
---

{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}

To get a mac ready for Ruby on Rails development, we need to do the following:

1. install command-line tools (XCode)
1. install ruby
1. install rails
1. test it out

We're going to do these tasks via the Terminal console, so if you aren't familiar with that, please read **this non-existent page** over first.


{% steps %}
{% list %}
## Install Command-line tools

When you are installing ruby and ruby gems (libraries), your system will often need to compile code for you.  The compilers for this can be installed with XCode, the development tool suite for native macOs development.  You can install the full version of XCode if you plan on doing any macOS or iOS development, but for this tutorial, you only need to install the development tool suite.

*NB: While at the workshop, please only install the development tool suite, since the full version of XCode will take a lot of time to download.*

If you aren't sure if you need this, try typing `gcc` in a terminal window. (`gcc` is the name of the compiler and stands for GNU Compiler Collection). If you receive the below dialog saying the "gcc" tool needs to be installed, click "Install".

![Install command line tools now?]({{ site.baseurl}}/assets/images/install_tools_now_dialog.png)

*Alternatively*, if you get the message, `-bash: gcc: command not found`, or if you cancel out of the dialog, install the command-line tools with this command: `xcode-select --install`

*Note that this will download the command-line tools and install them.  Once installed, `gcc -version` should print out some information about the compiler.*
{% endlist %}
{% highlight bash %}
$ gcc --version

# After installing, check the gcc --version again.
# You should get the below message:

Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Apple LLVM version 8.0.0 (clang-800.0.38)
Target: x86_64-apple-darwin15.6.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
{% endhighlight %}
{% endsteps %}


{% steps %}
{% list %}
## Install RVM
The [Ruby Version Manager (rvm)](http://rvm.io/) will allow you to install different versions of ruby on your machine and switch between them as you switch from one job to another. [Learn why RVM is useful here](https://code.tutsplus.com/articles/why-you-should-use-rvm--net-19529).

To install RVM, open a terminal window and run the following commands (copied directly off of the RVM website).

{% endlist %}
{% highlight bash %}
$ brew install gpg  # only necessary if gpg is not already installed

$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

$ \curl -sSL https://get.rvm.io | bash -s stable

{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
# Install Ruby 2.3.1
Now that you have RVM installed, you can use it to install Ruby.  You simply call `rvm install <version>`.  Let's install the latest version (as of 12/3/2016), v2.3.1.

To verify you're using the correct Ruby version, type `ruby -v`. You should have 2.3.1 as the version.

Finally, we'll install bundler, which will manage all your Ruby gems.
{% endlist %}
{% highlight bash %}
$ rvm install 2.3.1

$ rvm default use 2.3.1

$ ruby -v
# => ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]

$ gem install bundler
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
## Install Rails 5.0.1

Now that ruby is installed, installing rails is simple.  Just install Rails with the gem command!

If that succeeds, you should be able to run rails on the command-line:
{% endlist %}
{% highlight bash %}
$ gem install rails 5.0.1 --no-document

$ rails --version
# Rails 5.0.1
{% endhighlight %}
{% endsteps %}

{% protip %}
Note, adding `--no-document` prevents the generation of local (offline) documentation.  If you later decide you want local docs, you can easily recreate them (although it can be a slow process).  Look [here](http://blog.honeybadger.io/how-to-globally-disable-rdoc-and-ri-during-gem-installs/) for more details.
{% endprotip %}


{% steps %}
{% list %}
## Test it out

Now that we have everything we need installed, let's try it out.

After you type all the commands, you should see Rails starting up at the start of the line `Booting Puma`. Once you see `Listening on tcp://localhost:3000`, Rails is now running!
{% endlist %}
{% highlight bash %}
  $ rails new test_rails

  $ cd test_rails

  $ rails server
  => Booting Puma
  => Rails 5.0.1 application starting in development on http://localhost:3000
  => Run `rails server -h` for more startup options
  Puma starting in single mode...
  * Version 3.6.2 (ruby 2.3.1-p112), codename: Sleepy Sunday Serenity
  * Min threads: 5, max threads: 5
  * Environment: development
  * Listening on tcp://localhost:3000
  Use Ctrl-C to stop
{% endhighlight %}
{% endsteps %}

{% aside %}
If you see the output above, rails is running and you can point your browser at http://localhost:3000 and you should see this:

![Yay! You're on Rails!]({{ site.baseurl}}/assets/images/youre_on_rails.png)

This is not the directory you'll be using in the tutorial. To remove this simply type `rm -rf test_rails`.
{% endaside %}

{% protip %}
Don't forget to check out some cool [development tools]({{site.baseurl}}/installation/dev_tools/)!

{% endprotip %}
