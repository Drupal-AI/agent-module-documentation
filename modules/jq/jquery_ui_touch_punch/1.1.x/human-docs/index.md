# jQuery UI Touch Punch — manual setup guide

**jQuery UI Touch Punch** (`jquery_ui_touch_punch`) provides the small Touch
Punch shim as a Drupal asset library so that jQuery UI's mouse‑based widgets —
draggable, sortable, sliders, resizable and the like — also respond to touch on
phones and tablets. jQuery UI's interactions were written for mouse events and do
nothing on a touch screen; Touch Punch patches them so `touchstart` /
`touchmove` / `touchend` are translated into the simulated mouse events the
widgets expect.

There is nothing to configure. Once you enable the module the
`jquery_ui_touch_punch/touch-punch` library is available for other modules and
themes to depend on or attach, and touch support kicks in wherever it is loaded
alongside a jQuery UI widget. The module has no settings form, no permissions and
no admin page.

It builds on the base **jQuery UI** module (`jquery_ui`) — required and pulled in
automatically — and its library depends on `jquery_ui/core`. Unlike the pure
shims, it also ships an external JavaScript dependency,
`politsin/jquery-ui-touch-punch`, which Composer installs into your site's
`/libraries` directory; see the installation page for the detail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its external
   JavaScript library with Composer, then enable it.

## How to use it

There is no settings page and nothing to configure — enabling the module makes
the Touch Punch library available. It surfaces in one of two ways:

- **As a dependency in another module or theme's `*.libraries.yml`**, listed
  under the `dependencies` key so Drupal loads it wherever your own library is
  attached:

  ```yaml
  # my_theme.libraries.yml
  my_theme/sortable_admin:
    js:
      js/sortable-admin.js: {}
    dependencies:
      - jquery_ui_touch_punch/touch-punch
  ```

- **Attached directly in a render array** via `#attached`, wherever you need
  touch support for a jQuery UI widget:

  ```php
  $build['#attached']['library'][] = 'jquery_ui_touch_punch/touch-punch';
  ```

The library machine name this module provides is
**`jquery_ui_touch_punch/touch-punch`**. Attach it anywhere a jQuery UI
draggable, sortable, slider or resizable interaction needs to work under touch —
there is nothing further to configure.
