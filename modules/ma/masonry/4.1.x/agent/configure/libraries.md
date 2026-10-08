<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installing the JavaScript libraries

The module has **no configuration**; the only setup step is putting the two third-party libraries
on disk. Until you do, `applyMasonryDisplay()` still attaches `masonry/masonry.layout` but the
browser gets 404s for the library files and no grid appears.

## Required paths

| Library | Expected path (relative to the docroot) | Declared version |
|---|---|---|
| Masonry | `/libraries/masonry/dist/masonry.pkgd.min.js` | 4.2.2 |
| imagesLoaded | `/libraries/imagesloaded/imagesloaded.pkgd.min.js` | 5.0.0 |

Both are DeSandro packages: <http://masonry.desandro.com/> and
<http://imagesloaded.desandro.com/>.

## Check the current state

```bash
drush php:eval '$s = \Drupal::service("masonry.service");
print "masonry: " . var_export($s->isMasonryInstalled(), TRUE) . "\n";
print "imagesloaded: " . var_export($s->isImagesloadedInstalled(), TRUE) . "\n";'
```

`NULL` means missing. The same check drives two `/admin/reports/status` entries — **Masonry
library** and **ImagesLoaded library** — which show `REQUIREMENT_ERROR` with the expected path when
the file is absent.

## Install with Composer (merge plugin)

The module ships `composer.libraries.json` declaring `masonry/masonry` (v4.2.2) and
`imagesloaded/imagesloaded` (v4.1.4) as `drupal-library` packages from GitHub zips.

```bash
composer require wikimedia/composer-merge-plugin
```

then in the **root** `composer.json`:

```json
"extra": {
  "merge-plugin": {
    "include": ["web/modules/contrib/masonry/composer.libraries.json"]
  }
}
```

(adjust the path for your docroot), then `composer update` — the packages install into
`/libraries/masonry` and `/libraries/imagesloaded` via `composer/installers`.

`oomphinc/composer-installers-extender`, npm/bower, or a manual download all work equally well;
only the resulting paths matter.

## Non-default locations

`isMasonryInstalled()` / `isImagesloadedInstalled()` resolve in this order:

1. core's `library.libraries_directory_file_finder` service (which also looks in
   `libraries/`, `web/libraries/`, and profile/site-specific library directories),
2. the contrib **libraries** module's `libraries.manager`,
3. the literal relative path `libraries/…`.

When the resolved path differs from the default, `masonry_library_info_alter()` rewrites the
library's `js` key to that path, so a non-standard location works without further configuration.

## Library definitions (`masonry.libraries.yml`)

- `masonry/masonry` — the vendor script.
- `masonry/imagesloaded` — the vendor script, depends on `core/jquery`.
- `masonry/masonry.layout` — `js/masonry.js`, `drupalSettings.masonry: []` placeholder, depends on
  `core/jquery`, `core/drupal`, `masonry/imagesloaded`, `masonry/masonry`. **This is the only
  library you attach**; the other two come in as dependencies.
