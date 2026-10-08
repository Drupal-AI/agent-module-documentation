# jQuery UI — manual setup guide

**jQuery UI** (`jquery_ui`) re-provides the jQuery UI asset library — the
JavaScript, CSS themes and icon images — that Drupal core used to bundle as
`core/jquery.ui`. Newer versions of Drupal deprecated and removed that library
because jQuery UI is no longer actively maintained upstream, which would break
any theme, module or custom code that still relied on it. This module hands that
library back to you, unchanged, as a contributed package so nothing breaks.

There is nothing to configure. Once you enable the module the libraries are
simply *available* — other modules and themes can declare them as dependencies,
or your code can attach them directly, and they work immediately. The module has
no settings form, no permissions and no admin page of its own.

It is the shared base that the split-out companion widget modules build on —
projects such as **jQuery UI Datepicker** (`jquery_ui_datepicker`) and
**jQuery UI Slider** (`jquery_ui_slider`) each depend on this module for the
underlying jQuery UI files. jQuery UI itself has no dependencies beyond Drupal
core.

A quick word of caution: jQuery UI is End‑of‑Life upstream, so the maintainers
recommend migrating off it to a maintained alternative for new work rather than
adding fresh dependencies on it. This module exists to keep legacy code running
during that transition.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page and nothing to configure — the whole point of the
module is to make the jQuery UI library available again. Once it is enabled, the
library "surfaces" in one of two ways:

- **As a dependency in another module or theme's `*.libraries.yml`.** List the
  library you need under the `dependencies` key so Drupal loads it automatically
  wherever your own library is attached:

  ```yaml
  # my_theme.libraries.yml
  my_theme/my_widget:
    js:
      js/my-widget.js: {}
    dependencies:
      - jquery_ui/core
      - jquery_ui/widget
  ```

- **Attached directly in a render array** via `#attached`, when you only need it
  on a specific page or element:

  ```php
  $build['#attached']['library'][] = 'jquery_ui/core';
  ```

The base library machine names this module provides are:

- `jquery_ui/core` — the base library (the old `core/jquery.ui`).
- `jquery_ui/widget` — the widget factory (the old `core/jquery.ui.widget`).
- `jquery_ui/mouse` — the mouse interaction base needed by draggable/sortable
  widgets.
- `jquery_ui/position` — the position utility.
- `jquery_ui/locale` — datepicker localization, wiring the datepicker into
  Drupal's translated date regions.

Individual widgets (accordion, autocomplete, datepicker, dialog, draggable,
slider, tabs, tooltip and so on) live in separate companion projects that build
on this base. If you are moving legacy code off core, replace old
`core/jquery.ui*` references with the matching `jquery_ui/*` library names above.
