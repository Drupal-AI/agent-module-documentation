# Tabby — manual setup guide

**Tabby** (`tabby`) is a small building-block module that provides a Drupal *theme
function* for rendering tabbed content — a set of content panes with tab
navigation. Rather than every module or theme re-inventing the markup and
behaviour for tabs, they can render a `tabby_tabs` render element and get
consistent, accessible tabs for free.

Under the hood Tabby wraps the lightweight **Tabby JS library**, chosen because it
is small, accessible, written in vanilla JavaScript, and already bundled with the
Webform module — so many Drupal sites already have the library present. You build
tabs declaratively with a render array, giving a list of labels and a matching list
of content:

```php
$build['tabs'] = [
  '#theme' => 'tabby_tabs',
  '#labels' => ['Label One', 'Label Two'],
  '#content' => [
    ['#markup' => 'Content One'],
    ['#markup' => 'Content Two'],
  ],
];
```

Tabby is primarily a **developer/theming building block** — there is no admin
settings page. Other modules build on it; for example **Tabby Viewfield**
(`tabby_viewfield`) uses it to render each view in a Viewfield as a separate tab.
It supports Drupal 10 and 11 and requires no other Drupal modules, though it does
need the Tabby JS library (see Installation).

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the Tabby JS
   library, and enable the module.

## How to use it

Because Tabby is a rendering helper, you "use" it from code (or from a module that
builds on it) rather than from a settings screen. Return a render array with
`#theme => 'tabby_tabs'`, a `#labels` array of tab titles, and a `#content` array
of render arrays — one per tab — as shown above. Tabby attaches the JS library and
renders the accessible tab markup for you.
