# Setup & behavior (there is nothing to configure)

EXIF Orientation has **no configuration**: no settings form, no `configure` route, no config
schema, no permissions, no image style effect. Enabling the module is the entire setup.

```bash
drush en exif_orientation -y
```

## What happens after enabling

Every time an image **file entity is saved** (i.e. on upload, or any programmatic save), the
module's `hook_file_presave()` runs `_exif_orientation_rotate()`, which:

1. Acts only on files whose MIME type is `image/jpeg` or `image/png`.
2. Reads `exif_read_data()` on the file; if there is no `Orientation` tag, it does nothing.
3. Physically rotates the stored file via the image toolkit (`image.factory`) and re-saves it:

   | EXIF `Orientation` | Rotation applied |
   |---|---|
   | 3 | 180° |
   | 6 | 90° |
   | 8 | 270° |
   | 1 / missing / other | none |

The rotation is applied to the **stored master file**, so every image style/derivative
generated afterward inherits the corrected orientation.

## Requirements & caveats

- **PHP EXIF extension** must be available — the code no-ops if `exif_read_data()` does not
  exist. Verify with `php -m | grep exif`.
- Only **JPEG and PNG** are processed; other image formats are ignored.
- Only the **rotation-only** orientation values 3, 6, 8 are handled. **Odd/mirrored
  (flipped) values are not corrected** (the source notes odd numbers "would need a different
  process").
- To avoid core's `file_validate_image_resolution` resizing an image and stripping its EXIF
  data before rotation, the module inserts its own validator ahead of it (see the api doc).
- There is no admin UI at all; to change behavior you would override the module in code.
