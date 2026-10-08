# Same Height — manual setup guide

**Same Height** (`same_height`) provides a small, dependency-free JavaScript
library that makes a set of elements appear the same height — equalising them all to
the tallest one. It is the tidy-up you reach for when a row of teaser cards,
columns, or list items have different amounts of content and end with ragged,
uneven bottoms.

It is fully responsive and re-runs on resize to keep the heights in sync, works with
any CSS framework (or none), and lets you target as many selectors as you like. It
is packaged under the "Views" group because a very common use is aligning the cards
in a Views grid row, but there is nothing Views-specific about it — it works on any
markup a theme or module attaches it to.

This is a **front-end library only**. It has no admin UI, no settings form, no
permissions, no routes and no PHP logic — and therefore no server-side attack
surface at all. You use it by attaching the library in a template and pointing it at
the elements to equalise; there is nothing to configure in the browser.

It has no module dependencies and no submodules, and supports Drupal 8, 9 and 10.

This guide is written for a **human** (a themer or site builder). If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable.

## How to use it

Because it is a library wrapper, you use it from a Twig template. Attach the
`same_height/same_height` library and set a `data-same-height` attribute listing the
DOM selectors you want equalised. For example, to align every `.item-title` together
and every `.item-description` together within a list:

```twig
{{ attach_library('same_height/same_height') }}

{%
  set sameHeight = [
    '.item-title',
    '.item-description'
  ]
%}

<div data-same-height="{{ sameHeight|json_encode }}">
  {% for item in items %}
    <div class="item">
      <div class="item-title">{{ item.title }}</div>
      <div class="item-description">{{ item.description }}</div>
    </div>
  {% endfor %}
</div>
```

The library measures the targeted elements and sets each group to the height of its
tallest member, keeping them aligned and re-adjusting as the viewport changes. (The
exact markup is up to your theme — the key parts are attaching the library and
listing the selectors it should act on.)
