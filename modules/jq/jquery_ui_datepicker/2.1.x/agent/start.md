<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery UI Datepicker (jquery_ui_datepicker) — agent index

Compatibility shim that re-provides the **jQuery UI Datepicker** widget (removed from Drupal
core) as the Drupal asset library **`jquery_ui_datepicker/datepicker`**. Package *jQuery UI*.
Depends on the contrib **`jquery_ui`** base module (`jquery_ui:jquery_ui (>=8.x-1.7)`;
composer `drupal/jquery_ui:^1.7`). Core requirement `^9.2 || ^10 || ^11`. License
GPL-2.0-or-later. Installed version 2.1.1.

- **The library it provides, its assets/dependencies, how to attach or depend on it, and the
  core→contrib migration** → [library/datepicker.md](library/datepicker.md)

## What it actually is

- The module directory contains **only** `jquery_ui_datepicker.info.yml` and `composer.json`
  (plus LICENSE / CI). **No** `*.module`, `*.libraries.yml`, `*.routing.yml`,
  `*.permissions.yml`, `*.services.yml`, `src/`, `config/`, or assets of its own.
- The library `jquery_ui_datepicker/datepicker` is declared **on the shim's behalf** by the
  base module's `jquery_ui_library_info_alter()` (in `jquery_ui.module`), which reads the
  definition from `jquery_ui/jquery_ui.libraries.data.json` and rewrites asset paths to point
  at the assets shipped inside the **`jquery_ui`** module (`assets/vendor/jquery.ui/...`).
- Zero runtime surface: **no** entities, plugins, routes, services, hooks, permissions, Drush,
  or config schema. `configure` is null.

## The provided library

- **`jquery_ui_datepicker/datepicker`** — jQuery UI 1.13.2, license *Public Domain*
  (GPL-compatible). JS `ui/widgets/datepicker-min.js` (weight −11), CSS
  `themes/base/datepicker.css` (component). Dependencies: `core/jquery`,
  `jquery_ui/internal.version`, `jquery_ui/internal.keycode`, `jquery_ui/internal.widget-css`.
- **Locale integration:** when core's `locale` module is enabled, the alter hook appends the
  `jquery_ui/locale` dependency and adds `drupalSettings.jquery.ui.datepicker`
  (`isRTL`, `firstDay`, `langCode: 'drupal-locale'`). See [library/datepicker.md](library/datepicker.md).

## Use it

Attach in a render array — `$build['#attached']['library'][] = 'jquery_ui_datepicker/datepicker';`
— or declare it as a dependency in your own `*.libraries.yml`. Migration: replace any
`core/jquery.ui.datepicker` reference with `jquery_ui_datepicker/datepicker`. jQuery UI is
End-of-Life — use this as a bridge, not a long-term dependency.
