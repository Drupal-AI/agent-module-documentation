<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & converters

## Settings form

Route `image_webp_converter.settings` → `/admin/config/media/image-webp-settings-form`
(`ConverterSettingsForm`, permission `administer image webp converter`, which is
`restrict access: true`). Writes config object `image_webp_converter.settings`:

| Key | Type | Form default | Config-install default | Notes |
|---|---|---|---|---|
| `selected_converter` | string | `gd` | `gd` | radios: `gd` / `cwebp` / `imagick`. Schema file lists default `cwebp` but install config and the form ship `gd`. |
| `quality` | integer | `80` (form) / `85` (install) | `85` | number field, `#min` 0, `#max` 100, `#required`. |
| `lossless` | integer/bool | `FALSE` | `0` | checkbox. Applies lossless encoding to **PNG only** (`png.encoding = lossless`); JPEG is always lossy. |
| `per_node_conversion` | integer/bool | `FALSE` | `0` | checkbox. Shows the per-node *Convert images to WebP* checkbox on node forms. |

Quality is bounded by the HTML5 number widget (`#min`/`#max` 0–100) rather than a `validateForm()`
method, so a crafted POST is not range-checked server-side; the value is passed straight to the
converter, which clamps it in practice.

## The three converters

The module never runs a binary directly. It calls `WebPConvert::convert($source, $destination, $options)`
from `rosell-dk/webp-convert` (`^2.9`, a Composer requirement). `$options['converters']` is the single
selected back-end:

- **gd** — pure-PHP via the GD extension. Checked with `extension_loaded('gd')`; missing → error, abort.
- **cwebp** — the `cwebp` binary, invoked *by the library* (the library, not this module, builds and
  escapes the shell command). No `extension_loaded` check (the `case 'cwebp'` branch is empty).
- **imagick** — via the Imagick extension. Checked with `extension_loaded('imagick')`; missing → error.

An unrecognised/empty `selected_converter` falls back to `gd` (in `.module` and the batch service),
despite a log message in the batch service that says the default is `cwebp`.

## Conversion options actually passed

Built identically in `.module` `image_webp_converter_convert_to_webp()` and
`ImageBatchConverter::processImage()`:

```php
$options = ['converters' => [$selected_converter]];
$options['png']  = ['encoding' => 'lossy', 'near lossless' => 60];
$options['jpeg'] = ['encoding' => 'lossy', 'auto-limit' => TRUE];
if ($lossless) { $options['png']['encoding'] = 'lossless'; }
$options['quality'] = $image_quality ??= 85;
```

The standalone upload form (`UploadWebpConverter::convertToWebP()`) calls `WebPConvert::convert()` with
**no options at all**, so it uses the library defaults and ignores the configured converter/quality/lossless.
