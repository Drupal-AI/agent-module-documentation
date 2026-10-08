<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `jquery_ui_resizable/resizable` library

## Install / enable

```
composer require drupal/jquery_ui_resizable
drush en jquery_ui_resizable -y
```

Pulls in the `jquery_ui` base module (`drupal/jquery_ui:^1.7`), which ships the actual assets.
No configuration step — there is no settings form (`configure` is null) and no permissions.

## How the library is declared (not in this module)

The shim ships **no** `*.libraries.yml`. Its directory holds only `jquery_ui_resizable.info.yml`
and `composer.json`. The library is registered by the base module's
`jquery_ui_library_info_alter(array &$libraries, string $module)` in `jquery_ui.module`:

1. On first call it loads `jquery_ui/jquery_ui.libraries.data.json` (cached via
   `drupal_static`) and the `jquery_ui` module path.
2. When `$module === 'jquery_ui_resizable'` it takes the `jquery_ui_resizable` entry from that
   JSON, rewrites every CSS/JS path to `"/<jquery_ui-path>/<path>"`, and merges it into
   `$libraries` — so the asset files physically live under the **`jquery_ui`** module
   (`assets/vendor/jquery.ui/...`), not under this module.

## Library definition (`resizable`)

- **Full name to attach:** `jquery_ui_resizable/resizable`
- **jQuery UI version:** 1.13.2 — license *Public Domain*, `gpl-compatible: true`.
- **JS:** `assets/vendor/jquery.ui/ui/widgets/resizable-min.js` — `{ minified: true, weight: -11 }`.
- **CSS:** `assets/vendor/jquery.ui/themes/base/resizable.css` — `component` group.
- **Dependencies:** `core/jquery`, `jquery_ui/mouse`, `jquery_ui/internal.disable-selection`,
  `jquery_ui/internal.plugin`, `jquery_ui/internal.version`, `jquery_ui/widget`,
  `jquery_ui/internal.widget-css`.

The `jquery_ui/mouse` dependency provides the drag interaction on the resize handles.

## Attach / depend

Render array:

```php
$build['#attached']['library'][] = 'jquery_ui_resizable/resizable';
```

Your own `*.libraries.yml`:

```yaml
my_panel:
  js:
    js/my-panel.js: {}
  dependencies:
    - jquery_ui_resizable/resizable
```

Then initialize normally in JS (ideally inside a `Drupal.behaviors` callback), e.g.
`jQuery(context).find('.js-resizable').resizable({ minWidth: 200, containment: 'parent' });`

## Touch devices

Resizing drags via jQuery UI's mouse widget, which does not natively handle touch events. To
make handles work on touch screens, also enable **`jquery_ui_touch_punch`** and attach its
`jquery_ui_touch_punch/touch-punch` library.

## Migration from core

| Old (removed from core)         | New (this module)                   |
| ------------------------------- | ----------------------------------- |
| `core/jquery.ui.resizable`      | `jquery_ui_resizable/resizable`     |

See the change record https://www.drupal.org/node/3067969. jQuery UI is End-of-Life upstream;
use this as a compatibility bridge and plan a maintained replacement (the CSS `resize` property
or a supported library) for new code.
