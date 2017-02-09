---
url: win7_sp1.html
title: Windows 7 SP1
layout: rails_installation
---
{:.sectionheader}
# Windows 7 Installation

{% protip %}
## Minimum Requirements
In order to successfully follow these installation instructions, you must have the following:

* Windows 7 Version 6.1 (Build 7601: Service Pack 1)
* Administrator user with the rights to change the computer properties

{% endprotip %}

{:.sectionheader}
# Verify Windows Meets the Minimum Requirements
{% steps %}
{% list %}
### Check Your Windows Version
Find out what version of Windows 7 is running.
1. Click on the Start Button

2. In "Search programs and files", type `winver`

Your version information should look something like the image to the right.

<p align="center">
  <i> -OR- </i>
</p>

Check Microsoft's website for an alternative to checking your OS's version [https://support.microsoft.com/en-us/help/13443/windows-which-operating-system](https://support.microsoft.com/en-us/help/13443/windows-which-operating-system){:target='blank'}

{% endlist %}
{% list %}
  ![Windows 7 About Version]({{site.baseurl}}/assets/images/win7-winver.png)
{% endlist %}
{% endsteps %}

{% steps %}
{% list %}
### Steps to update Windows if it doesn't meet the Minimum Requirements

The easiest way is to run Windows 7 updater using the following
#### Run Windows Updater
1. Click on the Start Button

2. Click on Control Panel

3. Click on System and Security

4. Click on Windows Update
{% endlist %}
{% protip %}
#### If the updater fails, try manually installing the update.
WARNING: By following these instructions to manually update, you will be redirected to Microsoft's website.  You can see more information at [https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-sheet](https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-sheet){:target='blank'}.

**Click on [Service Pack 1](https://support.microsoft.com/en-us/help/15090){:target='blank'} to go to Microsoft's directions on Installing Windows 7 Service Pack 1 (SP1) and follow the instructions on that page to update your computer.**

{% endprotip %}
{% endsteps %}


{:.sectionheader}
# Install Node.Js

{% steps %}
{% list %}
1. Download the Node.js installer [https://nodejs.org/dist/v4.4.7/node-v4.4.7-x86.msi](https://nodejs.org/dist/v4.4.7/node-v4.4.7-x86.msi){:target='blank'}

2. Once the download is finished, go to the Downloads folder, open Node.Js program.

3. Read the full license agreement, accept the terms and run through the rest of the wizard leaving everything to the defaults.  Click "Yes" when it asks if you want to make changes to your computer.

4. Restart your computer so ruby knows about Node.Js
{% endlist %}
{% highlight shell %}
{% endhighlight %}
{% endsteps %}

{:.sectionheader}
# Install Ruby

{% steps %}
{% list %}
1. Download Ruby Installer [http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.3.1.exe](http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.3.1.exe){:target='blank'}

2. When the download is finished, go to the Downloads folder, and open the "rubyinstaller" program.

3. An installation wizard starts, agree to the license agreement, click Next.

4. Check "Add Ruby executables to your PATH", and then click Install.

5. Once it is done, click Finish.

**Once the installer is finished:**

1. Click on Start

2. Click on All Programs

3. Scroll down to Ruby 2.3.1-p112

4. Click "Start Command Prompt with Ruby".

5. Confirm that ruby is installed, type `ruby -v` and you should get "ruby 2.3.1p112"

6. Type `exit` to close the Prompt with Ruby.

{% endlist %}
{% highlight shell %}
$ ruby -v

# => ruby 2.3.1p112

$ exit
{% endhighlight %}
{% endsteps %}

{% protip %}
Remember step 3! Anytime the tutorial asks you to open your command prompt or terminal, you'll need to **Start Command Prompt with Ruby**.
{% endprotip %}

{:.sectionheader}
# Install Ruby Development Kit

{% steps %}
{% list %}
1. Download Ruby Development Kit
 [http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe](http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe){:target='blank'}

2. Once the download is finished, go to the Downloads folder, open the DevKit-ming64 program. When it asks for where to install the DevKit, put it to "C:\RubyDevKit"

3. Open Start Command Prompt with Ruby, and change to the DevKit directory. Type `cd C:\RubyDevKit`

4. Initialize the DevKit setup. Type `ruby dk.rb init`

5. Add DevKit to our Ruby installation.  Type `ruby dk.rb install`

6. Type `exit` to close the Prompt with Ruby.

{% endlist %}
{% highlight shell %}
$ cd C:\RubyDevKit

$ ruby dk.rb init

$ ruby dk.rb install

$ exit
{% endhighlight %}
{% endsteps %}

{:.sectionheader}
# Install Rails

{% steps %}
{% list %}

1. Open Start Command Prompt with Ruby, type `gem install rails --version 5.0.1 --no-document --source=http://rubygems.org`

2. Windows Firewall prompt will ask if you'd like Ruby to allow access to RubyGems.org, click "Allow"

3. Once the Bash prompt finishes building and confirm everything is successful, type `rails -v`

{% endlist %}
{% highlight shell %}
$ gem install rails --version 5.0.1 --no-document
{% endhighlight %}
{% endsteps %}

{:.sectionheader}
# Install a Text Editor
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
