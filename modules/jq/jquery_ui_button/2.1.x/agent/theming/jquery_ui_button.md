# jquery_ui_button — attaching the Button library

This module exists only to re-provide one jQuery UI widget — **Button** — as an asset
library, after jQuery UI was deprecated and removed from Drupal core. It has no config UI, no
permissions, no services, no PHP. Install it and attach the library. The button widget also
provides the legacy `buttonset()` behavior, so there is **no** separate `buttonset` library.

## The library id

```
jquery_ui_button/button
```

There is **no** `jquery_ui_button.libraries.yml` in this module. The library is registered on
its behalf by the base `jquery_ui` module: its `hook_library_info_alter()` reads
`jquery_ui.libraries.data.json` and declares `jquery_ui_button/button` (the vendored jQuery UI
**1.13.2** `button-min.js` and the base-theme `button.css`). That is why this module **depends
on `jquery_ui`** (`jquery_ui:jquery_ui (>=8.x-1.7)` in `info.yml`; `drupal/jquery_ui: ^1.7` in
`composer.json`) — the base module supplies both the vendored assets and the registration
machinery. Unlike the other split-out widgets, Button also **depends on
`jquery_ui_controlgroup` and `jquery_ui_checkboxradio`** (both `>=2.1`), because the button
library declares those two widgets among its dependencies.

## Attach it

In a render array / `#attached`:

```php
$build['#attached']['library'][] = 'jquery_ui_button/button';
```

From your own module or theme `*.libraries.yml`:

```yaml
my_module/my_lib:
  dependencies:
    - jquery_ui_button/button
```

Depend on the module itself from a custom module `*.info.yml`:

```yaml
dependencies:
  - jquery_ui:jquery_ui_button
```

## Transitive dependencies (pulled in automatically)

The `button` library declares these dependencies, so you do **not** attach them yourself:
`core/jquery`, `jquery_ui_controlgroup/controlgroup`, `jquery_ui_checkboxradio/checkboxradio`,
`jquery_ui/internal.keycode`, `jquery_ui/widget`, `jquery_ui/internal.widget-css`.

## Migration note

jQuery UI is End-of-Life upstream. Replace old `core/jquery.ui.button`-style references with
`jquery_ui_button/button`, but prefer migrating off jQuery UI entirely for new code.
