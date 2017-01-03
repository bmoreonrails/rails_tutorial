---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: rails_tutorial
---

To get started, check out the installation guides <a href="{{ site.baseurl}}/installation.html">here</a>

Once you're ready, let's start the tutorial!

{% for chapter in site.chapters %}
  <div class="chapter">
    <a href="{{ site.baseurl }}{{chapter.url}}" target="_self">
      {{ chapter.number }} {{ chapter.title }}
    </a>
  </div>
{% endfor %}
