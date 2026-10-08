# Simplify Menu — manual setup guide

**Simplify Menu** (`simplify_menu`) exposes any Drupal menu as a plain, normalized
PHP array — title, URL, active/active-trail flags, and nested submenus — through a
Twig function and a callable service. Instead of wrestling with core's opaque menu
render element, you get a clean data structure you can loop over to emit exactly
the markup you want. It is a developer and theming helper: there is no admin UI,
no settings, no permissions, and no routes.

Under the hood it ships one small service, `simplify_menu.menu_items`, whose
`getMenuTree($menuId)` method loads a menu with core's menu link tree, runs the
standard access-check and sort manipulators, drops disabled and inaccessible
links, and flattens the result into a nested array under a top-level `menu_tree`
key. Each item is `{text, url, active, active_trail}`, plus a `submenu` array when
it has children. A bundled Twig extension wraps that service as the
`simplify_menu('menu_id')` function so theme templates can loop the array
directly with no preprocessing.

Because the output is already a plain data structure, the same service is handy in
a controller or normalizer and can be `json_encode`d to feed a decoupled/headless
front end. Note that version 3.x is Twig/service only — unlike the older 1.x/2.x
releases it does **not** register a built-in JSON REST route, so for headless
output you call the service and encode it yourself.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — Simplify Menu has no admin pages, settings form, or configuration. Once
enabled, the `simplify_menu()` Twig function and the `simplify_menu.menu_items`
service are simply available to your theme and custom code.

## How to use it

### In a Twig template

Call the `simplify_menu()` function with a menu's machine name (for example
`main`, `footer`, `account`, `admin`, or a custom menu id). Always pass an
explicit name — calling it with no argument sends a null menu id. Each item has
`text`, `url`, `active`, `active_trail`, and (only when it has children) a
`submenu` list of the same shape. Disabled and access-denied links are already
removed, so no filtering is needed.

A simple single-level nav:

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

For multi-level dropdowns, recurse into each item's `submenu` with a Twig macro:

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

This works in `page.html.twig`, a region template, a Single Directory Component,
or any `#theme` template — no preprocess hook required.

### In PHP

Call the service from a controller or your own service to get the same array:

```php
$menu = \Drupal::service('simplify_menu.menu_items')->getMenuTree('main');
```

Where possible, inject it (`arguments: ['@simplify_menu.menu_items']`) rather than
using `\Drupal::service()`. To serve a menu as JSON, `json_encode` the returned
array in your own route/controller — the data is already plain scalars and arrays.

### Enriching each link

Other modules can add or change keys on every link by implementing
`hook_simplify_menu_simplified_link_alter()` — for example to attach an icon,
description, or custom attributes. The added keys then appear on every item in
both the service output and the Twig function. See the
[agent API doc](../agent/api/simplify_menu.md) for the hook signature.

> **Note:** menu output is cached. If you create or alter menu links
> programmatically, rebuild the menu links and clear the menu cache (or run
> `drush cr`) before reading the tree.
