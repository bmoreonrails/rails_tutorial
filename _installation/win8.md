---
url: win8.html
title: Windows 8.1
layout: rails_installation
---
{:.sectionheader}
# Windows 8 Installation

{% protip %}
## Minimum Requirements
In order to successfully follow these installation instructions, you must have the following:

* Windows 8.1﻿ Version 6.3 (Build 9600)
* Admistrator user with the rights to change the computer Properties

{% endprotip %}

{% steps %}
{% list %}
## steps to check your version

Check for operating system info in Windows 8.1 or Windows RT 8.1:

1. Swipe in from the right edge of the screen, tap Settings, and then tap Change PC settings. (If you're using a mouse, point to the lower-right corner of the screen, move the mouse pointer up, click Settings, and then click Change PC settings.)


2. Tap or click PC and devices, and then tap or click PC info.


3. Look under Windows for the version and edition of Windows that your PC is running.


Check for operating system info in Windows 8 or Windows RT

1. On the Start screen, type Computer, press and hold or right-click Computer, and then tap or click Properties.


2. Look under Windows edition for the version and edition of Windows that your PC is running.
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
## steps to update windows 8 if it doesn't match the minimum requirements

The easiest way is to run Windows 8 updater using the following
### steps to run windows updater
1. Swipe in from the right edge of the screen, tap Settings, and then tap Change PC settings. (If you're using a mouse, point to the lower-right corner of the screen, move the mouse pointer up, click Settings, and then click Change PC settings.)


2. Tap or click on Update and recovery


3. Tap or click on Windows Update


4. Tap or click on Check now.


5. If updates are found, tap or click View details.


6. In the list of updates, select the update containing KB 2919355, and then tap or click Install. If you're prompted for an administrator password or confirmation, enter the password or provide confirmation.


7. After the installation is complete, restart your PC and sign in.
{% endlist %}
{% endsteps %}

{% protip %}
#### if the updater fails, try manually installing the update

WARNING: By following these instructions to manually update, you will be redirected to Microsoft's website.  You can see more information at [https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-sheet](https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-sheet){:target='blank'}.

Click on [Windows 8.1](https://support.microsoft.com/en-us/help/15356){:target='blank'} to go to Microsoft's directions on Install the Windows 8.1 Update (KB 2919355) and follow the instructions on that page to update your computer.
{% endprotip %}

{:.sectionheader}
# steps to install nodejs

{% steps %}
{% list %}

1. Download the Node.js installer [https://nodejs.org/dist/v4.4.7/node-v4.4.7-x86.msi](https://nodejs.org/dist/v4.4.7/node-v4.4.7-x86.msi){:target='blank'}


2. Once the download is finished, go to the Downloads folder, open nodejs program.


3. Read the full license agreement, accept the terms and run through the rest of the wizard leaving everything to the defaults.  Click "Yes" when it asks if you want to make changes to your computer.


4. Restart your computer so ruby knows about nodejs

{% endlist %}

{% highlight shell %}
{% endhighlight %}
{% endsteps %}

{:.sectionheader}
# steps to install ruby

{% steps %}
{% list %}

1. Download Ruby Installer [http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.3.1.exe](http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.3.1.exe){:target='blank'}


2. When the download is finished, go to the Downloads folder, and open the "rubyinstaller" program.


3. An installation wizard starts, agree to the license agreement, click Next.


4. Check "Add Ruby executables to your PATH", and then click Install.


5. Once it is done, click Finish.

Once the installer is finished:

1. Click on Start


2. Click All Programs


3. Scroll down to Ruby 2.3.1-p112


4. Click "Start Command Prompt with Ruby".


5. Confirm that ruby is installed, type `ruby -v` and you should get "ruby 2.3.1p112"


6. Type `exit` to close the Prompt with Ruby.

{% endlist %}

{% highlight shell %}
{% endhighlight %}
{% endsteps %}

{% protip %}
Remember step 3, to open **Start Command Prompt with Ruby** because you'll use it again.
{% endprotip %}

{:.sectionheader}
# steps to install ruby development kit

{% steps %}
{% list %}

1. Download Ruby Development Kit [http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe](http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe){:target='blank'}


2. Once the download is finished, go to the Downloads folder, open the DevKit-ming64 program. When it asks for where to install the DevKit, put it to "C:\RubyDevKit"


3. Open the Prompt with Ruby, and change to the DevKit directory. Type `cd C:\RubyDevKit`


4. Initialize the DevKit setup. Type `ruby dk.rb init`


5. Add DevKit to our Ruby installation.  Type `ruby dk.rb install`

6. Type `exit` to close the Prompt with Ruby.

{% endlist %}

{% highlight shell %}
{% endhighlight %}
{% endsteps %}

{:.sectionheader}
# steps to install rails

{% steps %}
{% list %}

1. Open Prompt with Ruby, type `gem install rails --version 5.0.1 --no-document`


2. Windows Firewall prompt will ask if you'd like Ruby to allow access to RubyGems.org, click Allow


3. Once the Bash prompt finishes building and confirm everything is successful, type rails -v

{% endlist %}

{% highlight shell %}
{% endhighlight %}
{% endsteps %}

{:.sectionheader}
# steps to install a text editor
{% steps %}
{% list %}

1. Goto [http://atom.io](http://atom.io){:target='blank'}


2. Click on Download Windows Installer


3. Once the download is finished, go to the Downloads folder, and open "AtomeSetup.exe" program.  It may try and install .NET 4.5, let it and complete the install.

{% endlist %}

{% highlight shell %}
{% endhighlight %}
{% endsteps %}


{% protip %}
# Success!
You should now be able to continue with the Tutorial. Remember, any mention of "Terminal" in the tutorial means the "Start Command Prompt with Ruby" in your Start Menu.
{% endprotip %}


{:.sectionheader}
# Errors?! Something happened along the way

{% steps %}
{% list %}
## Things to do if any of these errors had occurred...

**Gem::RemoteFetcher::FetchError: SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (...)**

Resolve this error by editing Gemfile, and changing 'source "https://rubygems.org"' to 'source "http://rubygems.org"'

**Unable to install .NET 4.5**

Try to disable or quit your virus scanner, and then try to run the installer again.
{% endlist %}
{% endsteps %}
