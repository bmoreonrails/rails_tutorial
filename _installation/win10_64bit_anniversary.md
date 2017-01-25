---
url: win10_64bit_anniversary.html
title: Windows 10 64-bit Anniversary Edition Installation
layout: rails_installation
---
{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}

{% aside %}
# Table of Contents
{% endaside %}

{% protip %}
## Minimum Requirements

In order to successfully follow these installation instructions, you must have the following:

* 64-bit Windows 10 Anniversary Edition with version 1607 or higher
* Administrator account on your Win10 device/computer

{% endprotip %}

{% sectionheader %}
### Notes Before Installation
{% endsectionheader %}

{% steps %}
{% list %}
## Cortana
In the following instructions, you will see **Ask Cortana** used often. We are referring to the 'Ask me anything' input box in your taskbar, which will search your computer for what you'll need.

![Cortana ask me anything in taskbar]({{site.baseurl}}/assets/images/win10-taskbar-ask-me-anything.png)

<p align="center">
  <i> -OR- </i>
</p>

If you don't see **Ask me anything** in your taskbar, enable it through from your taskbar.

{% endlist %}
{% list %}
### To enable Cortana:
1. Right-click directly anywhere on the taskbar

1. A list of options show up, select 'Cortana'

1. Select 'Show search box'
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}

## Steps to Check Your Version:

**Ask Cortana** for `winver`, and click on 'winver run command'

You should get a About Windows prompt with information about your Windows version.  Click 'Ok' when you confirm the right version.

<p align="center">
  <i> -OR- </i>
</p>

Check  microsoft's website for an alternative to checking your OS's version [https://support.microsoft.com/en-us/help/13443/windows-which-operating-system](https://support.microsoft.com/en-us/help/13443/windows-which-operating-system){:target='blank'}

**If you are not using at least 64-bit Windows 10 Pro Anniversary Edition, you will not be able to use these instructions.**

If you the windows build number is lower than 1607, you must do the 'steps for windows updates', which could take a LONG time depending on the number of updates needed.
{% endlist %}

{% list %}
![Windows 10 About Version]({{site.baseurl}}/assets/images/win10-winver-results.png)
{% endlist %}
{% endsteps %}


{% steps %}
{% list %}
## Steps for Windows Update:
1. *Ask Cortana* for `Settings`, and click on 'Settings Trusted Windows Store app'.

1. Click on “Update & security"

1. Click on "Windows Update”

1. Click on "Check for updates", if any updates are available, it will start to download and prepare to install.
{% endlist %}
{% protip %}
**Keep updating**

If the update asks you to restart, restart your device/computer.  Repeat the steps for windows update until windows does not find any more updates and tells you "Your device is up to date".  Close all the Settings windows, and move onto Installing bash on windows section.
{% endprotip %}
{% endsteps %}


{:.sectionheader}
# Installing bash on Windows

{% steps %}
{% list %}
## Enable Bash:

### Steps for enabling developer mode:
1. *Ask Cortana* for `Settings`, and click on 'Settings Trusted Windows Store app'.

1. Click on "Updates and security"

1. Click on "For developers"

1. Select "Developer mode" under Use developer features,

1. Select "Yes" in the prompt asking if you understand that by turning on developer mode, it will expose your device and personal data to security risks or harm your device.

### Steps for enabling windows subsystem for linux feature:
1. *Ask Cortana* for `Turn Windows features on or off`, and click on 'Turn Windows features on and off Control Panel'.

1. Checkbox click on "Windows Subsystem for Linux (Beta)"

1. Click "Ok", if it asks you to restart your computer, click on "Restart now".
{% endlist %}
{% protip %}
Restart your device/computer, once win10 starts again, move onto 'steps for installing and running bash' section.
{% endprotip %}
{% endsteps %}

{% steps %}
{% list %}
## steps for installing and running bash:
1. *Ask Cortana* for `Command Prompt`.

1. Right click on 'Desktop app', and click on "Run as administrator". If asked, enter your password.  If it asks, do you want to allow this app to make changes to your device/computer, click "Yes". The Command Prompt window will appear with a blinking underline: ![Windows 10 Command Prompt]({{site.baseurl}}/assets/images/win10-command-prompt.png)

1. Type `bash --login`, which will start the bash installation.

1. When it ask you `"Beta Feature, this will install ubuntu on windows distributed by Canonical and licensed under its terms available here: https://aka.ms/uowterms",` type `y` and then enter.  It'll start to download from the Windows Store, and start installing to the file system.

1. Next, it will ask you to create a default UNIX user account and password.  *Note, this unix username and password have nothing to do with your win10 username and password.*

1. At the prompt: `"Enter new UNIX username:"`, type in `railsworkshop`

1. At this step, whatever you type won't be displayed!  But don't worry, if you misspell anything.  
So at the prompt: `"Enter new UNIX password:"`, type in `railsworkshop`

1. At this step, you will be asked for the password from the previous step. If you had misspelled anything, it will repeat the previous step! So in this step, at the prompt: "Retype new UNIX password:", type in *railsworkshop* used in previous step.

1. Final step, should tell you "Installation successful! The environment will start momentarily.... Documentation is available at: https://aka.ms/wslusers".  It will give you a Bash Prompt (Image of Bash Prompt) ![Windows 10 Bash Prompt]({{site.baseurl}}/assets/images/win10-bash.jpg)

1. Type *exit* at the Bash Prompt to leave and return to the Windows Prompt.

1. Type *exit* at the Windows Prompt to leave the Command Prompt.

{% endlist %}
{% endsteps %}

{:.sectionheader}
# Create Rails Workshop Folder

{% protip %}
We are going to create folder on your computer, where you will create your rails project.
{% endprotip %}

{% steps %}
{% list %}
1. On your desktop, right click and mouse over "New", and click on "Folder"

1. Name the folder "Projects"

1. Right click on "Projects" folder, and click on "Pin to Quick access" so it's easier for you to access throughout the tutorial.

1. *Ask Cortana* for `File Explorer`, and click on "File Explorer Desktop app".  You should see the Workshop folder in the Navigation tab. (Show File Explorer with Workshop in Navigation)
{% endlist %}
{% endsteps %}

{:.sectionheader}
# Installing rails

{% steps %}
{% list %}
## Steps to get bash prompt window at your Rails workshop folder:

1. *Ask Cortana* for `File Explorer`, and click on the "File Explorer Desktop app".

1. In the menu bar, click on "File"

1. Click on "Open command prompt"

1. Type `bash --login`, which should open the Bash Prompt in the Workshop folder.
{% endlist %}
{% protip %}
**REMEMBER THESE STEPS!**

*Most* of your Rails tutorial work should be in the Bash Prompt in the Workshop folder, and you will need to do create multiple bash prompt windows!

*Caveat:* To switch folders within the command prompt, you will need to exit out of the Bash Prompt. Anytime you need to do something in Rails, remember to go back into the Bash Prompt!

*Another Caveat:* If you just type `bash` to enter in the Bash Prompt, all the items you've downloaded  _will **not** work_. You must use `bash --login` to initalize the Bash Prompt.
{% endprotip %}
{% endsteps %}

{% steps %}
{% list %}
## Install Dependencies for Ruby:

{% protip %}
Copy the text after the `$`, one at a time and paste into a bash prompt window.
**To paste in the bash prompt window, just right click.**

When you paste each line, make sure it runs the command and wait for the bash prompt to return.

Enter your UNIX password any time it ask for it, which should be `railsworkshop`.
{% endprotip %}

First, we'll need to update our system and install dependencies for Ruby.

{% endlist %}
{% highlight bash %}
 $ sudo apt-get update

 $ sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev \
   libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev \ libxslt1-dev
   libcurl4-openssl-dev python-software-properties libffi-dev \

 $ sudo apt-get install libgdbm-dev libncurses5-dev automake libtool \
   bison libffi-dev
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
## Install Ruby 2.3.1 via RVM:

The [Ruby Version Manager (RVM)](http://rvm.io/) will allow you to install different versions of ruby on your machine and switch between them as you switch from one job to another. [Learn why RVM is useful here](https://code.tutsplus.com/articles/why-you-should-use-rvm--net-19529).

Once you have YVM installed, you can use it to install ruby.  You simply call `rvm install <version>`.  We'll install and use the latest version (as of 12/3/2016), v2.3.1.

To verify you have Ruby installed, type `ruby -v`, and you should see `ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-linux]`.

Finally, you'll need to install Bundler, which will handle all your Ruby dependencies.

{% endlist %}
{% highlight bash %}
 $ gpg --keyserver hkp://keys.gnupg.net --recv-keys \
  409B6B1796C275462A1703113804BB82D39DC0E3

 $ curl -sSL https://get.rvm.io | bash -s stable

 $ source ~/.rvm/scripts/rvm

 $ rvm install 2.3.1

 $ rvm use 2.3.1 --default

 $ gem install bundler
{% endhighlight %}
{% endsteps %}

{% steps %}
{% list %}
## Install Rails 5.0.1:

Since Rails ships with so many dependencies these days, we're going to need to install a Javascript runtime like NodeJS. This lets you use Coffeescript and the [Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html) in Rails which combines and minifies your javascript to provide a faster production environment.

Lastly, we'll finally install Rails! To verify your installation, type `rails -v`, which will output `Rails 5.0.1`.

{% endlist %}
{% highlight bash %}
 $ curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

 $ sudo apt-get install -y nodejs

 $ gem install rails --version 5.0.1 --no-document

 $ rails -v
{% endhighlight %}
{% endsteps %}


{% protip %}
  Yeah! You did it! You can now start the Rails Tutorial!

  ![Congratulations!]({{site.baseurl}}/assets/images/excited.gif)

  Don't forget to check out some cool [development tools]({{site.baseurl}}/installation/dev_tools/)!
{% endprotip %}
