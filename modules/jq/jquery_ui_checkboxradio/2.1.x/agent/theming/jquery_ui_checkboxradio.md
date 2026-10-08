# jquery_ui_checkboxradio — attaching the Checkboxradio library

This module exists only to re-provide one jQuery UI widget — **Checkboxradio** — as an asset
library, after jQuery UI was deprecated and removed from Drupal core. It has no config UI, no
permissions, no services, no PHP. Install it and attach the library.

## The library id

```
jquery_ui_checkboxradio/checkboxradio
```

There is **no** `jquery_ui_checkboxradio.libraries.yml` in this module. The library is
registered on its behalf by the base `jquery_ui` module: its `hook_library_info_alter()` reads
`jquery_ui.libraries.data.json` and declares `jquery_ui_checkboxradio/checkboxradio` (the
vendored jQuery UI **1.13.2** `checkboxradio-min.js` and the base-theme `checkboxradio.css`).
That is why this module **depends on `jquery_ui`** (`jquery_ui:jquery_ui (>=8.x-1.7)` in
`info.yml`; `drupal/jquery_ui: ^1.7` in `composer.json`) — the base module supplies both the
vendored assets and the registration machinery.

## Attach it

In a render array / `#attached`:

```php
$build['#attached']['library'][] = 'jquery_ui_checkboxradio/checkboxradio';
```

From your own module or theme `*.libraries.yml`:

```yaml
my_module/my_lib:
  dependencies:
    - jquery_ui_checkboxradio/checkboxradio
```

Depend on the module itself from a custom module `*.info.yml`:

```yaml
dependencies:
  - jquery_ui:jquery_ui_checkboxradio
```

## Transitive dependencies (pulled in automatically)

The `checkboxradio` library declares these dependencies, so you do **not** attach them
yourself: `core/jquery`, `jquery_ui/widget`, `jquery_ui/internal.form-reset-mixin`,
`jquery_ui/internal.labels`, `jquery_ui/internal.widget-css`.

## Migration note

jQuery UI is End-of-Life upstream. Replace old `core/jquery.ui.checkboxradio`-style references
with `jquery_ui_checkboxradio/checkboxradio`, but prefer migrating off jQuery UI entirely for
new code.
