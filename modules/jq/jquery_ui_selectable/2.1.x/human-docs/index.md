# jQuery UI Selectable — manual setup guide

**jQuery UI Selectable** (`jquery_ui_selectable`) makes the jQuery UI **Selectable**
widget available again as a Drupal asset library. jQuery UI was removed from Drupal
core's actively‑maintained libraries, so each interaction is now re‑provided by the
[jQuery UI](https://www.drupal.org/project/jquery_ui) contrib module plus a small
companion module per widget — this is that companion for Selectable.

Selectable is the "lasso" / rubber‑band selection behavior: users drag a box to select
a group of DOM elements, or Ctrl/Shift‑click to pick several — useful for multi‑select
grids, galleries, card dashboards, or bulk‑action UIs. This module exists purely to
expose the `jquery_ui_selectable/selectable` library so your theme or module can
attach it and call `.selectable()`.

There is nothing to configure — no admin UI, no settings, no permissions, no PHP or
JavaScript of its own. It ships only an `.info.yml` and depends on the base
`jquery_ui` module, which declares the actual library (jQuery UI 1.13.2) on its
behalf.

This guide is written for a **human** developer/themer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the jQuery UI module.

## How to use it

Once the module is enabled, attach the library wherever you need the widget.

From a render array:

```php
$build['#attached']['library'][] = 'jquery_ui_selectable/selectable';
```

Or as a dependency in your theme/module's `*.libraries.yml`:

```yaml
your-widget:
  js:
    js/your-widget.js: {}
  dependencies:
    - jquery_ui_selectable/selectable
```

Then, in your JavaScript, initialize it:

```js
$('#my-list').selectable({ stop: function (e, ui) { /* … */ } });
```

The library bundles jQuery UI **1.13.2**'s `selectable` JS and CSS (served from the
`jquery_ui` module) and pulls in its dependencies (`core/jquery`, `jquery_ui/mouse`,
`jquery_ui/widget`) automatically.
