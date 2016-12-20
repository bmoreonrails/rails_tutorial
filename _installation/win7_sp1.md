---
url: win7_sp1.html
number: i
title: Installation on Windows 7 SP1
layout: rails_tutorial
---
{:.sectionheader}
# Minimum Requirements
- Windows 7 Version 6.1 (Build 7601: Service Pack 1)

{:.sectionheader}
# steps to check your version
Find out what version of Windows 7 is running.
1. Click on the Start Button
2. In "Search programs and files", type winver

# steps to update windows 7 if it doesn't match the minimum requirements

The easiest way is to run Windows 7 updater using the following
## steps to run windows updater
1. Click on the Start Button
2. Click on Control Panel
3. Click on System and Security
4. Click on Windows Update

### if the updater fails, try manually installing the update

WARNING: By following these instructions to manually update, you will be redirected to Microsoft's website.  You can see more information at [https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-sheet](https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-sheet){:target='blank'}.

Click on [Service Pack 1](https://support.microsoft.com/en-us/help/15090/windows-7-install-service-pack-1-sp1){:target='blank'} to go to Microsoft's directions on Installing Windows 7 Service Pack 1 (SP1) and follow the instructions on that page to update your computer.

{:.sectionheader}
# steps to install ruby

1. Download Ruby Installer (http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.3.1.exe)
2. Once the download is finished, go to the Downloads folder, and open the "rubyinstaller" program. An installation wizard starts, agree to the license agreement, click Next, Check "Add Ruby executables to your PATH", and then click Install.  Once it is done, click Finish.
3. Once it is finished, Click on Start, Click All Programs, scroll down to Ruby 2.3.1-p112, and click "Start Command Prompt with Ruby".
4. Confirm that ruby is installed, type ruby -v

Remember step 3, to open Prompt with Ruby because you'll use it again.

{:.sectionheader}
# steps to install ruby development kit

1. Download Ruby Development Kit (http://dl.bintray.com'/oneclick/rubyinstaller/DevKit-ming64-32-4.7.2-20130224-1151-sfx.exe)
2. Once the download is finished, go to the Downloads folder, open the DevKit-ming64 program. When it asks for where to install the DevKit, put it to "C:\RubyDevKit"
3. Open the Prompt with Ruby, and change to the DevKit directory (cd C:\RubyDevKit)
4. Initialize the DevKit setup. Type ruby dk.rb init
5. Add DevKit to our Ruby installation.  Type ruby dk.rb install

{:.sectionheader}
# steps to install rails

1. In the Prompt with Ruby, type gem install rails --no-ri --no-rdoc --version 5.0.0 --source=http://rubygems.org
2. Windows Firewall prompt will ask if you'd like Ruby to allow access to RubyGems.org, click Allow
3. Once the Bash prompt finishes building and confirm everything is successful, type rails -v

{:.sectionheader}
# steps to install nodejs

1. Download the Node.js installer (https://nodejs.org/dist/v4.4.7/node-v4.4.7-x86.msi)
2. Once the download is finished, go to the Downloads folder, open nodejs program.
3. Read the full license agreement, accept the terms and run through the rest of the wizard leaving everything to the defaults.  Click "Yes" when it asks if you want to make changes to your computer.
4. Restart your computer so ruby knows about nodejs-v

{:.sectionheader}
# steps to install a text editor

1. Goto http://atom.io
2. Click on Download Windows Installer
3. Once the download is finished, go to the Downloads folder, and open "AtomeSetup.exe" program.  It may try and install .NET 4.5, let it and complete the install.


You should now be able to continue with the Tutorial


{:.sectionheader}
# Errors?! Something happened along the way

1. Gem::RemoteFetcher::FetchError: SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (...)
  - Resolve this error by editing Gemfile, and changing 'source "https://rubygems.org"' to 'source "http://rubygems.org"'
