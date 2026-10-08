# jQuery UI Selectmenu — manual setup guide

**jQuery UI Selectmenu** (`jquery_ui_selectmenu`) re‑provides the jQuery UI
**Selectmenu** widget as an asset library, so themes and modules can keep using
styleable custom `<select>` dropdowns after jQuery UI was deprecated and removed
from Drupal core.

This is a **developer / library module**, not a click‑and‑go feature. Drupal core
used to bundle the Selectmenu widget inside `core/jquery.ui`, but jQuery UI is no
longer maintained (End‑of‑Life at the OpenJS Foundation) and was removed from
core — which would break any code that relied on the widget. This small companion
module restores exactly that one widget outside of core. It ships no PHP, no
settings page, no permissions, and no services; it simply carries the assets and
depends on the base `jquery_ui` and `jquery_ui_menu` modules.

Once installed, the one thing it gives you is an asset library with the id
**`jquery_ui_selectmenu/selectmenu`**. You attach that library, then initialize
`.selectmenu()` on a `<select>` element in your own JavaScript — the library
loads the widget's assets but does not auto‑initialize anything.

> **Heads up:** jQuery UI is unmaintained upstream. This module exists to keep
> *legacy* code working during a transition. For new work, the maintainers
> recommend migrating styled selects off jQuery UI to a maintained alternative
> rather than taking a fresh dependency on this library.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## Where it lives in the admin menu

Nowhere — the module has no admin page, no settings, and no permissions. It only
provides an asset library for developers to attach.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Attach the library from a render array:

   ```php
   $build['#attached']['library'][] = 'jquery_ui_selectmenu/selectmenu';
   ```

   …or declare it as a dependency in your own module or theme's
   `*.libraries.yml`:

   ```yaml
   my_module/fancy_select:
     js:
       js/my-select-init.js: {}
     dependencies:
       - jquery_ui_selectmenu/selectmenu
   ```
3. Initialize the widget yourself in JavaScript, typically inside a
   `Drupal.behaviors`:

   ```js
   Drupal.behaviors.mySelect = {
     attach(context) {
       once('my-select', 'select.fancy', context)
         .forEach((el) => jQuery(el).selectmenu());
     }
   };
   ```

The library id `jquery_ui_selectmenu/selectmenu` is the only public surface — it
pulls in the jQuery UI Menu widget and the other jQuery UI helpers it needs
automatically.
