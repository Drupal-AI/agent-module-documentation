<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `jquery_ui_slider/slider` library

## Install / enable

```
composer require drupal/jquery_ui_slider
drush en jquery_ui_slider -y
```

Pulls in the `jquery_ui` base module (`drupal/jquery_ui:^1.7`), which ships the actual assets.
No configuration step — there is no settings form (`configure` is null) and no permissions.

## How the library is declared (not in this module)

The shim ships **no** `*.libraries.yml`. Its directory holds only `jquery_ui_slider.info.yml`
and `composer.json`. The library is registered by the base module's
`jquery_ui_library_info_alter(array &$libraries, string $module)` in `jquery_ui.module`:

1. On first call it loads `jquery_ui/jquery_ui.libraries.data.json` (cached via
   `drupal_static`) and the `jquery_ui` module path.
2. When `$module === 'jquery_ui_slider'` it takes the `jquery_ui_slider` entry from that JSON,
   rewrites every CSS/JS path to `"/<jquery_ui-path>/<path>"`, and merges it into `$libraries`
   — so the asset files physically live under the **`jquery_ui`** module
   (`assets/vendor/jquery.ui/...`), not under this module.

## Library definition (`slider`)

- **Full name to attach:** `jquery_ui_slider/slider`
- **jQuery UI version:** 1.13.2 — license *Public Domain*, `gpl-compatible: true`.
- **JS:** `assets/vendor/jquery.ui/ui/widgets/slider-min.js` — `{ minified: true, weight: -11 }`.
- **CSS:** `assets/vendor/jquery.ui/themes/base/slider.css` — `component` group.
- **Dependencies:** `core/jquery`, `jquery_ui/mouse`, `jquery_ui/internal.keycode`,
  `jquery_ui/internal.version`, `jquery_ui/widget`, `jquery_ui/internal.widget-css`.

The `jquery_ui/mouse` dependency is what enables drag interaction on the slider handles.

## Attach / depend

Render array:

```php
$build['#attached']['library'][] = 'jquery_ui_slider/slider';
```

Your own `*.libraries.yml`:

```yaml
my_widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_slider/slider
```

Then initialize normally in JS (ideally inside a `Drupal.behaviors` callback), e.g.
`jQuery(context).find('.js-slider').slider({ range: true, min: 0, max: 100 });`

## Touch devices

The slider drags via jQuery UI's mouse widget, which does not natively handle touch events. To
make handles draggable on touch screens, also enable **`jquery_ui_touch_punch`** and attach its
`jquery_ui_touch_punch/touch-punch` library.

## Migration from core

| Old (removed from core)     | New (this module)             |
| --------------------------- | ----------------------------- |
| `core/jquery.ui.slider`     | `jquery_ui_slider/slider`     |

See the change record https://www.drupal.org/node/3067969. jQuery UI is End-of-Life upstream;
use this as a compatibility bridge and plan a maintained replacement (native
`<input type="range">` or a supported slider) for new code.
