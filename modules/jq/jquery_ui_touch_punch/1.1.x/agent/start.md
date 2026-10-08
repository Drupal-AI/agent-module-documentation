<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery UI Touch Punch (jquery_ui_touch_punch) — agent index

Library-provider module that exposes the **Touch Punch** shim as the Drupal asset library
**`jquery_ui_touch_punch/touch-punch`**, making jQuery UI mouse widgets (draggable, droppable,
sortable, slider, resizable, selectable) respond to **touch** events on mobile/tablet. Package
*jQuery UI*. Depends on the contrib **`jquery_ui`** base module (`jquery_ui:jquery_ui`) plus the
external Composer package **`politsin/jquery-ui-touch-punch`**. Core requirement
`^9.2 || ^10 || ^11 || ^12`. License GPL-2.0-or-later. Installed version 1.1.2. Maintained by
Morpht.

- **The library it provides, the external asset it needs, and how to attach or depend on it** →
  [library/touch-punch.md](library/touch-punch.md)

## What it actually is

- Source files: `jquery_ui_touch_punch.info.yml`, `composer.json`,
  `jquery_ui_touch_punch.libraries.yml`, and `jquery_ui_touch_punch.module` (plus README /
  LICENSE / CI). **No** `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `src/`, or
  `config/`.
- `jquery_ui_touch_punch.module` implements **only** `hook_help()` (route
  `help.page.jquery_ui_touch_punch`) — static prose linking the jQuery UI deprecation change
  record. No other hooks, no input handling.
- Zero runtime surface beyond the help page: **no** entities, plugins, routes, services,
  permissions, Drush, or config schema. `configure` is null.

## The provided library (`jquery_ui_touch_punch.libraries.yml`)

- **`touch-punch`** — title *"jQuery Touch Punch"*, version `0.0`,
  website `https://github.com/furf/jquery-ui-touch-punch`.
  - JS: `/libraries/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js` `{ minified: true }`
    — an **external** file (from Composer package `politsin/jquery-ui-touch-punch`), served
    from the site's `/libraries/` directory, **not** bundled in this module.
  - Dependency: `jquery_ui/core`.
- Full name to attach: **`jquery_ui_touch_punch/touch-punch`**.

## Use it

Install the external asset (`composer require drupal/jquery_ui_touch_punch` brings in
`politsin/jquery-ui-touch-punch`), enable the module, then attach the library after your jQuery
UI interaction library: `$build['#attached']['library'][] = 'jquery_ui_touch_punch/touch-punch';`
or list it as a `*.libraries.yml` dependency. jQuery UI is End-of-Life — use this as a bridge,
not a long-term dependency.
