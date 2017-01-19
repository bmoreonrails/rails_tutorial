---
url: troubleshooting.html
title: Troubleshooting the Installation
layout: rails_installation
---

{% sectionheader %}
  {{ page.title }}
{% endsectionheader %}

#### On my mac, I tried to install Ruby 2.3.1 through rvm. The install kept failing because rvm was looking for openssl. It kept complaining that the executable openssl couldn't be found!

You may have already had openssl installed under homebrew. Try uninstalling it and then rvm should be able to install ruby!
