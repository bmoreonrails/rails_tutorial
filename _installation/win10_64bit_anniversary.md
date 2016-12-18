---
url: win10_64bit_anniversary.html
number: i
title: Installation on Windows 10 64-bit Anniversary Edition
layout: rails_tutorial
---

{:.sectionheader}
# Notes before installation

In the following instructions, you will see *Ask Cortana* used often. We are referring to the 'Ask me anything' input box in your taskbar.
  {% include figure.html url="/assets/images/win10-taskbar-ask-me-anything.png" description="Cortana ask me anything in taskbar" %}

OR

If you don't see *Ask me anything* in your taskbar, enable it through your taskbar.

1. Right-click on the taskbar
2. Select 'Cortana'
3. Select 'Show search box'

{:.sectionheader}
# Minimum Requirements

* 64-bit Windows 10 Anniversary Edition with version 1607 or higher
* Administrator account on your Win10 device/computer

## steps to check your version:
1. Ask Cortana for *winver*, and click on 'winver run command'.

You should get a About Windows prompt with information about your Windows version.  Click 'Ok' when you confirm the right version.

  {% include figure.html url="/assets/images/win10-winver-results.png" description="Windows 10 About Version" %}

**If you are not using at least 64-bit Windows 10 Pro Anniversary Edition, you will not be able to use these instructions.**

If you the windows build number is lower than 1607, you must do the 'steps for windows updates', which could take a LONG time depending on the number of updates needed.

## steps for windows update :
1. Ask Cortana for *Settings*, and click on 'Settings Trusted Windows Store app'.
2. Click on “Update & security"
3. Click on "Windows Update”
4. Click on "Check for updates", if any updates are available, it will start to download and prepare to install.

If it asks you to restart, restart your device/computer.  Repeat the steps for windows update until windows does not find any more updates and tells you "Your device is up to date".  Close all the Settings windows, and move onto Installing bash on windows section.

{:.sectionheader}
# Installing bash on windows

## steps for enabling developer mode:
1. Ask Cortana for *Settings*, and click on 'Settings Trusted Windows Store app'.
2. Click on "Updates and security"
3. Click on "For developers"
4. Select "Developer mode" under Use developer features,
5. Select "Yes" in the prompt asking if you understand that by turning on developer mode, it will expose your device and personal data to security risks or harm your device.

Restart your device/computer, once win10 starts again, move onto 'steps for enabling windows subsystem for linux feature' section.

## steps for enabling windows subsystem for linux feature:
1. Ask Cortana for *Turn Windows features on or off*, and click on 'Turn Windows features on and off Control Panel'.
2. Checkbox click on "Windows Subsystem for Linux (Beta)"
3. Click "Ok", if it asks you to restart your computer, click on "Restart now".

When Win10 starts back up, move onto the 'steps for installing and running bash' section

## steps for installing and running bash:
1. Ask Cortana for *Command Prompt*.
2. Right click on 'Desktop app', and click on "Run as administrator". If asked, enter your password.  If it asks, do you want to allow this app to make changes to your device/computer, click "Yes". The Command Prompt window will appear with a blinking underline:
  - {% include figure.html url="/assets/images/win10-command-prompt.png" description="Windows 10 Command Prompt" %}
3. Type *bash*, which will start the bash installation.
4. When it ask you "Beta Feature, this will install ubuntu on windows distributed by Canonical and licensed under its terms available here: https://aka.ms/uowterms", type *y* and then enter.  It'll start to download from the Windows Store, and start installing to the file system.
5. Next, it will ask you to create a default UNIX user account and password.  Note, this unix username and password have nothing to do with your win10 username and password.
6. At the prompt: "Enter new UNIX username:", type in *railsworkshop*
7. At this step, whatever you type won't be displayed!  But don't worry, if you misspell anything.  So at the prompt: "Enter new UNIX password:", type in *railsworkshop*
8. At this step, you will be asked for the password from the previous step. If you had misspelled anything, it will repeat the previous step! So in this step, at the prompt: "Retype new UNIX password:", type in *railsworkshop* used in previous step.
9. Final step, should tell you "Installation successful! The environment will start momentarily.... Documentation is available at: https://aka.ms/wslusers".  It will give you a Bash Prompt (Image of Bash Prompt)
  - {% include figure.html url="/assets/images/win10-bash.jpg" description="Windows 10 Bash Prompt" %}
10. Type *exit* at the Bash Prompt to leave and return to the Windows Prompt.
11. Type *exit* at the Windows Prompt to leave the PowerShell.


{:.sectionheader}
# Creating rails workshop folder

We are going to create folder on your computer, where you will create your rails project.

1.  your desktop, right click and mouse over "New", and click on "Folder"
2. Name the folder "Workshop"
3. Right click on "Workshop" folder, and click on "Pin to Quick access"
4. Ask Cortana for *File Explorer*, and click on "File Explorer Desktop app".  You should see the Workshop folder in the Navigation tab. (Show File Explorer with Workshop in Navigation)

Next, continue to 'Installing rails'


{:.sectionheader}
# Installing rails

## steps to get bash prompt window at your rails workshop folder:
1. Ask Cortana for *File Explorer*, and click on the "File Explorer Desktop app".
2. In the menu bar, click on "File"
3. Click on "Open command prompt"
4. Type *bash*, which should open the Bash Prompt in the Workshop folder.

Remember the above steps! All your rails tutorial work should be in the Bash Prompt in the Workshop folder, and you will need to do create multiple bash prompt windows!

## steps to install ruby 2.3.1 and rails 5.0.0:

Copy the text after the '$', one at a time and paste into a bash prompt window. When you paste each line, make sure it runs the command and wait for the bash prompt to return.  Enter your UNIX password any time it ask for it.

{% highlight bash %}
$ sudo apt-get update
$ sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
$ sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ curl -sSL https://get.rvm.io | bash -s stable
$ source ~/.rvm/scripts/rvm
$ rvm install 2.3.1
$ rvm use 2.3.1 --default
$ gem install bundler
$ curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
$ sudo apt-get install -y nodejs
$ gem install rails -v 5.0.0
$ rails -v
{% endhighlight %}

If you get "Rails v5.0.0", then you've successfully installed rails on your computer and can start the Rails Tutorial!

{:.sectionheader}
# Other software

## steps to install a text editor
1. Open Internet Explorer, and go to url: https://atom.io
2. Click on "Download Windows Installer", and run the AtomSetup.exe
