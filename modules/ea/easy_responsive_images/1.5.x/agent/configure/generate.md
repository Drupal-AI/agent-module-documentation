<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generate image styles

Form: **`/admin/config/media/image-styles/generate`** (route `easy_responsive_images.generate`,
form `GenerateImageStyles`, permission `administer image styles`; also a local task on the
Image styles collection). Config object: **`easy_responsive_images.settings`**.

## Settings keys

| Key | Meaning |
|---|---|
| `minimum_width` / `maximum_width` | Width range for generated styles (px). |
| `threshold_width` | Preferred pixel step between successive widths. |
| `aspect_ratios` | Newline-separated `w:h` list (e.g. `16:9`) for cropped styles. |
| `minimum_height` / `maximum_height` | Optional height range for flexible-width styles. |
| `threshold_height` | Pixel step between successive heights. |
| `lazy_loading_threshold` | Native lazy-load distance in px (default **1250**; the only shipped default). |

Validation: if any width field is set, all width fields (incl. `aspect_ratios`) become required;
same for the height group.

## What saving generates (naming)

On submit the module writes `easy_responsive_images.settings` and creates image styles
(iterating width from min to max by `threshold_width`):

- **Scale** (flexible height, keeps ratio): `responsive_<width>w` → effect `image_scale`
  (`width`, `upscale: TRUE`). E.g. min 300 / max 900 / step 300 → `responsive_300w`,
  `responsive_600w`, `responsive_900w`.
- **Aspect-ratio crop** (per `w:h`): `responsive_<w>_<h>_<width>w` → effect
  `image_scale_and_crop` (or `focal_point_scale_and_crop` if the `focal_point` module exists),
  with `height = width / w * h`. E.g. `16:9` → `responsive_16_9_300w`, …
- **Fixed height** (flexible width): `responsive_<height>h` → effect `image_scale`
  (`height`, `upscale: TRUE`).

After generating, any existing `responsive_`-prefixed style **not** in the new set is deleted.

## Delete all generated styles

The form's **"Delete generated image styles"** button (`deleteGeneratedStyles`) deletes every
image style whose name starts with `responsive_`.

## Drush / config

```bash
drush cget easy_responsive_images.settings
# The styles themselves are normal image_style config entities:
drush config:status | grep responsive_
```

There is no Drush command to trigger generation — generation happens on the form submit
(`GenerateImageStyles::submitForm`). To generate programmatically, set the config and create the
image styles the same way, or invoke the form submit.
