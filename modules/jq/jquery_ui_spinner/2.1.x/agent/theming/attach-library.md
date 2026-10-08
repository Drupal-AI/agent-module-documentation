<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attach & use the jQuery UI Spinner library

This module has no code, no config and no UI. Its entire purpose is to make one asset library
available: **`jquery_ui_spinner/spinner`** (jQuery UI Spinner widget, jQuery UI 1.13.2). You use
the module by attaching that library and then initializing `.spinner()` in your own JavaScript.

## Where the library is actually defined

The definition is **not** in this module (it ships only `info.yml` + `composer.json`). It lives in
the `jquery_ui` module's `jquery_ui.libraries.data.json` under the key `jquery_ui_spinner` →
`spinner`, and is injected into this module's namespace at runtime by
`jquery_ui_library_info_alter()` (in `jquery_ui.module`), which prefixes the asset paths with the
`jquery_ui` module path. Asset files therefore live under `jquery_ui/assets/vendor/jquery.ui/`, not
in this module.

- **JS:** `assets/vendor/jquery.ui/ui/widgets/spinner-min.js` (minified, weight `-11`).
- **CSS:** `assets/vendor/jquery.ui/themes/base/spinner.css` (component layer).
- **Dependencies pulled in automatically:** `core/jquery`, `jquery_ui_button/button`,
  `jquery_ui/widget`, `jquery_ui/internal.version`, `jquery_ui/internal.keycode`,
  `jquery_ui/internal.safe-active-element`, `jquery_ui/internal.widget-css`.

## Attach it

From PHP (render array / `#attached`):

```php
$build['#attached']['library'][] = 'jquery_ui_spinner/spinner';
```

Or as a dependency of your own library in `mymodule.libraries.yml`:

```yaml
my-widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_spinner/spinner
```

Then initialize in your JavaScript:

```js
$('#my-number-input').spinner({ min: 0, max: 100, step: 1 });
```

## Migrating legacy references

If you have Drupal 8/9-era code that attached the core-provided library, change every reference
from `core/jquery.ui.spinner` to `jquery_ui_spinner/spinner` and add this module (and `jquery_ui`,
`jquery_ui_button`) as dependencies.

## Caveat

Upstream jQuery UI is End-of-Life (OpenJS Foundation) and was deprecated out of core for that
reason. Treat this library as a compatibility bridge for legacy code — prefer a native `<input
type="number">` or a maintained widget for new work.
