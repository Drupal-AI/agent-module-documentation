<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, bundled metadata and the async routes

## The service

`ckeditor5_icons.CKEditor5Icons` → `Drupal\ckeditor5_icons\CKEditor5Icons`
(implements `CKEditor5IconsInterface`; constructor args `@cache.data`, `@extension.path.resolver`).

| Method | Returns |
|---|---|
| `getPreciseLibraryVersions()` | `['fontawesome5' => '5.15.4', 'fontawesome6' => '6.7.2']` from `libraries/versions.yml` |
| `getFontAwesomeMetadataPath($v)` | `modules/contrib/ckeditor5_icons/metadata/fontawesome<$v>` (no leading slash) |
| `getFontAwesomeCategories($v)` | parsed `libraries/fontawesome<$v>/metadata/categories.yml` |
| `getFontAwesomeIcons($v)` | parsed `icons.yml`, reduced to `{styles, label, search.terms}` per icon |
| `getFontAwesomeStyles()` | the 7 style definitions (`label`, `pro`, `compatibility`) |
| `toValidFontAwesomeVersion($v)` | `'5'` if exactly `'5'`, otherwise `'6'` |

Everything except `getFontAwesomeStyles()` is memoised in the `cache.data` bin under
`ckeditor5_icons.library_versions`, `ckeditor5_icons.fontawesome{5,6}.categories` and
`ckeditor5_icons.fontawesome{5,6}.icons`. `drush cr` clears them.

Example:

```php
$svc = \Drupal::service('ckeditor5_icons.CKEditor5Icons');
$svc->getPreciseLibraryVersions()['fontawesome6'];      // '6.7.2'
count($svc->getFontAwesomeIcons('6'));                  // ~1895 icons
array_keys($svc->getFontAwesomeStyles());               // solid, regular, light, thin, duotone, brands, custom
$svc->getFontAwesomeIcons('6')['heart']['styles'];      // ['solid', 'regular']
```

## Bundled catalogues

Shipped in the module, **no external library download required for the picker**:

- `libraries/fontawesome6/metadata/{icons,categories}.yml` — Font Awesome **6.7.2** (~1895 icons)
- `libraries/fontawesome5/metadata/{icons,categories}.yml` — Font Awesome **5.15.4** (~1458 icons)

These are *metadata only*. The module never attaches the Font Awesome webfont/CSS to a page —
its own libraries (`ckeditor5_icons/icon.editor`, `ckeditor5_icons/icon.admin`) contain only the
picker JS and its styling. Getting glyphs to render is the site's job.

## Metadata routes (async loading)

`ckeditor5_icons.routing.yml` has no static routes; it delegates to
`Drupal\ckeditor5_icons\Routing\MetadataRouting::getRoutes()`, which builds three JSON routes,
all guarded by `_csrf_token: TRUE` and served by `MetadataController`:

| Route name | Path | Controller method |
|---|---|---|
| `ckeditor5_icons.fontawesome6_metadata` | `/modules/contrib/ckeditor5_icons/metadata/fontawesome6` | `getFontAwesome6MetadataResponse` |
| `ckeditor5_icons.fontawesome5_metadata` | `/modules/contrib/ckeditor5_icons/metadata/fontawesome5` | `getFontAwesome5MetadataResponse` |
| `ckeditor5_icons.fontawesome_metadata` | `/modules/contrib/ckeditor5_icons/metadata/fontawesome` | `getFontAwesomeCustomMetadataResponse` (requires `_module_dependencies: fontawesome`) |

The paths are derived from the module's real install path, so they move with the module. The
plugin builds the URL in `getDynamicPluginConfig()` and appends `?version=<precise>&token=<csrf>`
(the `version` query param is a cache-buster, omitted for custom metadata).

Look them up on a live site:

```bash
drush php:eval '$r = \Drupal::service("router.route_provider")->getRouteByName("ckeditor5_icons.fontawesome6_metadata"); print $r->getPath();'
```

## `fontawesome` contrib integration

If the contrib module `fontawesome` is installed, the plugin injects
`fontawesome.font_awesome_manager` and the text-format form's **Font Awesome metadata**
select offers *Custom*. With `custom_metadata: TRUE` the catalogue comes from
`FontAwesomeManager::getCategories()` / `::getIcons()` instead of the bundled YAML — this is
how you expose Font Awesome **Pro** or a Kit (`fa-kit` / `fak` classes) to editors.
Saving `custom_metadata: TRUE` through the form when `fontawesome` is *not* installed is a
validation error.
