# jQuery UI Datepicker — manual setup guide

**jQuery UI Datepicker** (`jquery_ui_datepicker`) re-provides the jQuery UI
Datepicker asset library — the calendar‑popup widget — that Drupal core used to
bundle before jQuery UI was deprecated and removed. Any theme, module or custom
code that still calls `$.fn.datepicker()` or attaches the old `jquery.ui.datepicker`
library needs that asset from somewhere; this module supplies exactly that as a
contributed Drupal library.

There is nothing to configure. It is a thin compatibility shim: it defines a
single Drupal asset library for the datepicker component and leans on the base
**jQuery UI** module (`jquery_ui`) for the underlying jQuery UI files. Once you
enable it, the library is available for other modules and themes to depend on or
attach, and it simply works. The module has no settings form, no permissions and
no admin page.

Because it builds on the base module, `jquery_ui` is a required dependency —
Composer and Drupal pull it in automatically when you install this one. It is
most often enabled indirectly, as a dependency of another contrib module that
needs a datepicker, rather than installed on its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page and nothing to configure — enabling the module makes
the datepicker library available. It surfaces in one of two ways:

- **As a dependency in another module or theme's `*.libraries.yml`**, listed
  under the `dependencies` key so Drupal loads it wherever your own library is
  attached:

  ```yaml
  # my_module.libraries.yml
  my_module/date_form:
    js:
      js/date-form.js: {}
    dependencies:
      - jquery_ui_datepicker/datepicker
  ```

- **Attached directly in a render array** via `#attached`, when you only need it
  on a specific page or form:

  ```php
  $build['#attached']['library'][] = 'jquery_ui_datepicker/datepicker';
  ```

The library machine name this module provides is **`jquery_ui_datepicker/datepicker`**.
That is the entire surface area — there is nothing further to configure or
extend.
