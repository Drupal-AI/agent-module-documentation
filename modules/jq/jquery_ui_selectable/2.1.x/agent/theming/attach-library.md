<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attach & use the jQuery UI Selectable library

This module has no code, no config and no UI. Its entire purpose is to make one asset library
available: **`jquery_ui_selectable/selectable`** (jQuery UI Selectable widget, jQuery UI 1.13.2).
You use the module by attaching that library and then initializing `.selectable()` in your own
JavaScript.

## Where the library is actually defined

The definition is **not** in this module (it ships only `info.yml` + `composer.json`). It lives in
the `jquery_ui` module's `jquery_ui.libraries.data.json` under the key `jquery_ui_selectable` →
`selectable`, and is injected into this module's namespace at runtime by
`jquery_ui_library_info_alter()` (in `jquery_ui.module`), which prefixes the asset paths with the
`jquery_ui` module path. Asset files therefore live under `jquery_ui/assets/vendor/jquery.ui/`, not
in this module.

- **JS:** `assets/vendor/jquery.ui/ui/widgets/selectable-min.js` (minified, weight `-11`).
- **CSS:** `assets/vendor/jquery.ui/themes/base/selectable.css` (component layer).
- **Dependencies pulled in automatically:** `core/jquery`, `jquery_ui/mouse`, `jquery_ui/widget`,
  `jquery_ui/internal.version`, `jquery_ui/internal.widget-css`.

## Attach it

From PHP (render array / `#attached`):

```php
$build['#attached']['library'][] = 'jquery_ui_selectable/selectable';
```

Or as a dependency of your own library in `mymodule.libraries.yml`:

```yaml
my-widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_selectable/selectable
```

Then initialize in your JavaScript:

```js
$('#my-list').selectable({
  stop: function (event, ui) {
    // Read the currently selected items.
    $('.ui-selected', this).each(function () { /* … */ });
  }
});
```

## Migrating legacy references

If you have Drupal 8/9-era code that attached the core-provided library, change every reference
from `core/jquery.ui.selectable` to `jquery_ui_selectable/selectable` and add this module (and
`jquery_ui`) as dependencies.

## Caveat

Upstream jQuery UI is End-of-Life (OpenJS Foundation) and was deprecated out of core for that
reason. Treat this library as a compatibility bridge for legacy code — prefer a maintained
selection/interaction solution for new work.
