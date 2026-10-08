<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `jquery_ui_touch_punch/touch-punch` library

## What it does

jQuery UI interactions (draggable, droppable, sortable, slider, resizable, selectable) are built
on the mouse widget and listen for `mousedown`/`mousemove`/`mouseup`. Touch devices don't drive
those the same way, so the widgets feel dead under a finger. The **Touch Punch** shim
monkey-patches jQuery UI to translate `touchstart`/`touchmove`/`touchend` into simulated mouse
events, restoring drag/resize/sort behavior on touch screens. This module exposes that shim as a
Drupal asset library.

## Install / enable

```
composer require drupal/jquery_ui_touch_punch
drush en jquery_ui_touch_punch -y
```

`composer.json` requires `drupal/jquery_ui:^1.0` **and** the external asset package
`politsin/jquery-ui-touch-punch:^1.0`. Unlike the pure widget shims, the JS is **not** bundled
in this module — it must be present at `/libraries/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js`
(the Composer package installs it there when the project's `installer-paths` map `type:drupal-library`
to `libraries/{$name}`). No settings form (`configure` is null), no permissions.

## Library definition (`jquery_ui_touch_punch.libraries.yml`)

Unlike datepicker/slider/resizable, this module ships its **own** `*.libraries.yml`:

```yaml
touch-punch:
  title: 'jQuery Touch Punch'
  website: https://github.com/furf/jquery-ui-touch-punch
  version: 0.0
  js:
    /libraries/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js: { minified: true }
  dependencies:
    - jquery_ui/core
```

- **Full name to attach:** `jquery_ui_touch_punch/touch-punch`
- **JS:** external, `/libraries/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js` (minified).
- **Dependency:** `jquery_ui/core` (from the base `jquery_ui` module).

Note the library only declares `jquery_ui/core`. Load it **together with** the specific jQuery
UI interaction you want touch-enabled (e.g. `jquery_ui_slider/slider`,
`jquery_ui_resizable/resizable`, or a draggable/sortable library) so the shim patches a widget
that is actually present.

## Module code

`jquery_ui_touch_punch.module` implements **only** `hook_help()` for route
`help.page.jquery_ui_touch_punch` — static translated prose about the jQuery UI deprecation
(links the change record `https://www.drupal.org/node/3067969` and the project page). No other
hooks, no request input, no state changes.

## Attach / depend

Render array (attach after the interaction library):

```php
$build['#attached']['library'][] = 'jquery_ui_slider/slider';
$build['#attached']['library'][] = 'jquery_ui_touch_punch/touch-punch';
```

Your own `*.libraries.yml`:

```yaml
my_touch_ui:
  js:
    js/my-touch-ui.js: {}
  dependencies:
    - jquery_ui_resizable/resizable
    - jquery_ui_touch_punch/touch-punch
```

No JS call is needed to activate it — loading the shim patches jQuery UI automatically; you keep
using the normal `.draggable()` / `.sortable()` / `.slider()` / `.resizable()` APIs.

## Caveat

jQuery UI (and the upstream Touch Punch project) are unmaintained / End-of-Life. Use this as a
compatibility bridge for existing interactions and plan a maintained, touch-native replacement
for new work.
