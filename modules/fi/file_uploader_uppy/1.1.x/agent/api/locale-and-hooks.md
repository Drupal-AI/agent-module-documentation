<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — locales, the theme hook, and the alter hook

This module's only PHP "API" surface is localisation glue plus a theme hook. There are **no
services and no routes** to call.

## `UppyLocaleMapper` (`src/UppyLocaleMapper.php`)

`final class Drupal\file_uploader_uppy\UppyLocaleMapper` maps Drupal langcodes to Uppy locale file
names and builds the CDN URL for each.

- `const URL = "https://releases.transloadit.com/uppy/locales/v3.2.1"` — the external base for locale
  JS (Transloadit CDN; the same host that publishes Uppy).
- `const MAP` — Drupal langcode → Uppy locale, e.g. `fi => fi_FI`, `de => de_DE`, `pt-br => pt_BR`,
  `zh-hans => zh_CN`.
- `public static getMap(): array` — returns `MAP` after invoking the alter hook
  `hook_file_uploader_uppy_locale`.
- `public static getLocale(?string $language = NULL): ?string` — resolves a langcode to its Uppy
  locale name; returns `NULL` for English (`/^en_?/`) or any langcode not in the map.
- `public static getUrl(?string $language = NULL): ?string` — `URL . "/{locale}.min.js"` or `NULL`.

## `hook_library_info_build()` — generated locale libraries

`file_uploader_uppy_library_info_build()` (in `.module`) iterates `UppyLocaleMapper::getMap()` and
declares one library per language named **`locale.<langcode>`**, each an `external` minified JS at
`UppyLocaleMapper::getUrl($language)`, depending on `file_uploader_uppy/global`. So the full library
id an agent would attach is `file_uploader_uppy/locale.<langcode>` (e.g.
`file_uploader_uppy/locale.fi`).

`FileUploaderUppyWidget::formSingleElement()` attaches `file_uploader_uppy/locale.<current-lang>` to
the element, adds the `languages:language_interface` cache context, and sets
`#upload_options.instance.locale` to `UppyLocaleMapper::getLocale()`. The client `global.js`
bootstraps `window.Uppy = { locales: {} }`; the external locale script registers itself there and
`widget.js` picks it up via `Uppy.locales[locale]`. English (and unmapped languages) simply get no
locale file and Uppy uses its built-in English strings.

## `hook_file_uploader_uppy_locale(array &$map)` — add/override a language

Documented in `file_uploader_uppy.api.php`. Implement it in a custom module to add a langcode → Uppy
locale mapping (or override an existing one). Example:

```php
/**
 * Implements hook_file_uploader_uppy_locale().
 */
function mymodule_file_uploader_uppy_locale(array &$map): void {
  // Map Drupal's zh-tw to an available Uppy locale.
  $map['zh-tw'] = 'zh_CN';
}
```

The altered map feeds both the generated `locale.*` libraries and per-element locale resolution, so a
new entry must correspond to a real `<name>.min.js` under the `URL` base to actually load.

## `hook_theme()` — the wrapper

`file_uploader_uppy_theme()` registers theme **`file_uploader_uppy`** with `render element = element`,
rendered by `templates/file-uploader-uppy.html.twig` — a `<div class="file-uploader">` wrapper around
`{{ element }}`. Override it in a theme for markup changes.

## Notes for callers

- The `imageEditor` behaviour (crop/rotate/zoom) is entirely client-side (`@uppy/image-editor`) and
  applies only to newly added files (`widget.js` guards `canEditFile` on `file.source`).
- There is no PHP-side upload handler here; to change how saved files are validated or where they
  land, work in the field's `#upload_validators` / `#upload_location` (standard File field config,
  consumed by `drupal/file_uploader`'s controller), not in this module.
