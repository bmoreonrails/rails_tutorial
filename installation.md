---
layout: rails_tutorial
---

## Installation

Pick your poison! We'll help you get Rails running on your machine.  If you _can_ meet the following requirements, that would be easier, but we'll do what we can if your computer is older.

### Minimum Requirements
<table>
  <tr>
    <th>OS</th><th>Version</th>
  </tr>
  <tr>
    <td>Mac OS X</td><td>???</td>
  </tr>
  <tr>
    <td>Ubuntu Linux</td><td>???</td>
  </tr>
  <tr>
    <td>Windows</td><td>???</td>
  </tr>
</table>

### Guides
{% for guide in site.installation %}
  <div class="guide">
    <a href="{{guide.url}}">
      {{ guide.number }} {{ guide.title }}
    </a>
  </div>
{% endfor %}
