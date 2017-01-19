---
layout: rails_installation
---

## Installation

Pick your poison! We'll help you get Rails running on your machine.  If you _can_ meet the following requirements, that would be easier, but we'll do what we can if your computer is older.

### Minimum Requirements
<table>
  <tr>
    <th>OS</th><th>Version</th>
  </tr>
  <tr>
    <td>Mac OS X</td><td>Lion (10.7)</td>
  </tr>
  <tr>
    <td>Ubuntu Linux</td><td>13.04</td>
  </tr>
  <tr>
    <td>Windows</td><td> Windows 7 Version 6.1 (Build 7601: Service Pack 1)</td>
  </tr>
</table>

Please refer to the appropriate instructions for your system for a more complete description of the minimum requirements.

### Guides
{% for guide in site.installation %}
  <div class="guide">
    <a href="{{ site.baseurl }}{{guide.url}}" target="_self">
      {{ guide.title }}
    </a>
  </div>
{% endfor %}
