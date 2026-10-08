<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: the `simplify_menu()` Twig function

A Twig extension (`Drupal\simplify_menu\TwigExtension\MenuItemsTwigExtension`, tagged
`twig.extension`) registers one function you can call from any theme template.

## Signature

```twig
{{ simplify_menu(menuId) }}
```

- `menuId` — the menu machine name (e.g. `main`, `footer`, `account`, `admin`, or a custom
  menu id). It is passed straight to the service's `getMenuTree()`.
- Returns the same array the service returns: a map with a single key `menu_tree` holding a
  list of link items. It is marked `is_safe: html`.
- Passing **no argument** sends `NULL` to the service (loads with a null menu id) — always
  pass an explicit machine name.

## Item shape (per link)

| key | meaning |
|---|---|
| `text` | link title |
| `url` | resolved URL string (e.g. `/node/1`, `/`) |
| `active` | `true` when the link's URL equals the current request URI |
| `active_trail` | `true` when the link is in the active trail (this page or an ancestor) |
| `submenu` | present only when the link has children; a nested list of the same shape |

Disabled and access-denied links are already removed — no filtering needed in the template.

## Basic render

```twig
{% set items = simplify_menu('main') %}
<nav class="nav">
  <ul>
    {% for item in items.menu_tree %}
      <li class="nav__item{{ item.active ? ' is-active' }}{{ item.active_trail ? ' is-active-trail' }}">
        <a href="{{ item.url }}">{{ item.text }}</a>
      </li>
    {% endfor %}
  </ul>
</nav>
```

## Nested / dropdown menus

Recurse into `submenu`. A Twig `macro` is the clean way to render arbitrary depth:

```twig
{% macro menu_items(items) %}
  {% import _self as m %}
  <ul>
    {% for item in items %}
      <li>
        <a href="{{ item.url }}">{{ item.text }}</a>
        {% if item.submenu is defined %}{{ m.menu_items(item.submenu) }}{% endif %}
      </li>
    {% endfor %}
  </ul>
{% endmacro %}

{% import _self as m %}
{{ m.menu_items(simplify_menu('main').menu_tree) }}
```

Use it in `page.html.twig`, a region template, an SDC, or any `#theme` template. No
preprocess hook is required — the function is available everywhere Twig runs.
