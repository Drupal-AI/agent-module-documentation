<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Image Style On Upload

Config object `image_style_on_upload.settings`. Form at `/admin/config/media/image_style_on_upload` (route `image_style_on_upload.settings`, form `src/Form/SettingsForm.php`, permission `administer site configuration`). `info.yml` declares no `configure` route, so the module's `configure` metadata is null even though the form and a menu link exist.

## Settings keys (schema `image_style_on_upload.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `image_style` | string (image style machine name) | `upload` | The image style applied to each qualifying uploaded file. Set to empty (`- No image style -`) to disable processing. |
| `mime_types` | string (space-separated) | `image/gif image/jpeg image/png` | MIME whitelist; only files whose `getMimeType()` is in this list are processed. |

## How it applies (`ImageStyleApplier::apply()`)

1. Skips if no config, or the file is not temporary (`$file->isTemporary()`), or the MIME is not whitelisted.
2. Loads the configured image style; logs an error and aborts if it does not exist.
3. `$imageStyle->createDerivative($uri, $uri.'.'.$ext)` builds the processed image.
4. `FileSystem::move(derived, original, FileExists::Replace)` overwrites the original file with the derivative.
5. Updates the file entity size (`$file->setSize(filesize(...))`).

Net effect: the **stored source file is replaced** by the styled version — this is destructive to the original, unlike core image styles which keep the original and generate derivatives on request.

## Shipped optional style

`config/optional/image.style.upload.yml` installs an image style `upload` with a single `image_scale` effect: width 2000, height null, upscale false. This is the default target of `image_style`.

## Set config with Drush (example)

```bash
# Apply a custom style and add webp to the whitelist
ddev drush cset image_style_on_upload.settings image_style my_upload_cap -y
ddev drush cset image_style_on_upload.settings mime_types 'image/gif image/jpeg image/png image/webp' -y
```
