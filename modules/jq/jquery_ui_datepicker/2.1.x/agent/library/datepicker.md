<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `jquery_ui_datepicker/datepicker` library

## Install / enable

```
composer require drupal/jquery_ui_datepicker
drush en jquery_ui_datepicker -y
```

Pulls in the `jquery_ui` base module (`drupal/jquery_ui:^1.7`), which ships the actual assets.
No configuration step — there is no settings form (`configure` is null) and no permissions.

## How the library is declared (not in this module)

The shim ships **no** `*.libraries.yml`. Its directory holds only `jquery_ui_datepicker.info.yml`
and `composer.json`. The library is registered by the base module's
`jquery_ui_library_info_alter(array &$libraries, string $module)` in `jquery_ui.module`:

1. On first call it loads `jquery_ui/jquery_ui.libraries.data.json` (cached via
   `drupal_static`) and the `jquery_ui` module path.
2. When `$module === 'jquery_ui_datepicker'` it takes the `jquery_ui_datepicker` entry from
   that JSON, rewrites every CSS/JS path to `"/<jquery_ui-path>/<path>"`, and merges it into
   `$libraries` — so the asset files physically live under the **`jquery_ui`** module
   (`assets/vendor/jquery.ui/...`), not under this module.

## Library definition (`datepicker`)

- **Full name to attach:** `jquery_ui_datepicker/datepicker`
- **jQuery UI version:** 1.13.2 — license *Public Domain*, `gpl-compatible: true`.
- **JS:** `assets/vendor/jquery.ui/ui/widgets/datepicker-min.js` — `{ minified: true, weight: -11 }`.
- **CSS:** `assets/vendor/jquery.ui/themes/base/datepicker.css` — `component` group.
- **Dependencies:** `core/jquery`, `jquery_ui/internal.version`, `jquery_ui/internal.keycode`,
  `jquery_ui/internal.widget-css`.

## Locale-aware behavior

Still in `jquery_ui_library_info_alter()`: when `$module === 'jquery_ui_datepicker'`, the
`datepicker` library exists, **and** core's `locale` module is enabled, the hook:

- appends dependency `jquery_ui/locale`, and
- sets `drupalSettings.jquery.ui.datepicker = ['isRTL' => NULL, 'firstDay' => NULL,
  'langCode' => 'drupal-locale']`.

This lets `jquery_ui`'s `js/locale.js` apply Drupal's regional settings (first day of week,
RTL, language) to the calendar. With `locale` disabled you get the plain widget.

## Attach / depend

Render array:

```php
$build['#attached']['library'][] = 'jquery_ui_datepicker/datepicker';
```

Your own `*.libraries.yml`:

```yaml
my_widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_datepicker/datepicker
```

Then initialize normally in JS (ideally inside a `Drupal.behaviors` callback):
`jQuery(context).find('input.js-datepicker').datepicker(options);`

## Migration from core

Replace deprecated references (per the project page / change record
https://www.drupal.org/node/3067969):

| Old (removed from core)        | New (this module)                     |
| ------------------------------ | ------------------------------------- |
| `core/jquery.ui.datepicker`    | `jquery_ui_datepicker/datepicker`     |

jQuery UI is End-of-Life upstream; use this as a compatibility bridge and plan a maintained
replacement (native `<input type="date">` or a supported date-picker) for new code.
