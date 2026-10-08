<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select the Imagick toolkit & its settings

## Requirement

The `imagick` PHP extension must be loaded (`php -r 'var_dump(extension_loaded("imagick"));'`).
Without it the toolkit's `isAvailable()` fails and it can't be selected.

## Select the toolkit

UI: *Configuration → Media → Image toolkit* (route `system.image_toolkit_settings`,
`/admin/config/media/image-toolkit`) → choose **Imagick image manipulation toolkit** → Save.

The active toolkit is stored by core in config `system.image`, key `toolkit`:

```bash
drush cget system.image toolkit          # -> gd (default) or imagick
drush cset system.image toolkit imagick -y
```

## Toolkit settings (`imagick.config`)

The same form saves an `imagick.config` object (schema `imagick.config`):

| key | default | meaning |
|---|---|---|
| `jpeg_quality` | `75` | quality (1–100) for generated JPEGs |
| `resize_filter` | `22` | ImageMagick filter constant used when resizing |
| `optimize` | `true` | run optimization on save (PageSpeed-friendly) |
| `strip_metadata` | `true` | strip EXIF/metadata from generated images |

```bash
drush cget imagick.config
drush cset imagick.config jpeg_quality 60 -y
```

Constants: `ImagickToolkit::CONFIG_JPEG_QUALITY`, `CONFIG_RESIZE_FILTER`, `CONFIG_OPTIMIZE`,
`CONFIG_STRIP_METADATA`. On `save()` the toolkit applies quality, optionally strips metadata,
and writes the file. Only the derivative-generation path is affected; source files are
untouched.
