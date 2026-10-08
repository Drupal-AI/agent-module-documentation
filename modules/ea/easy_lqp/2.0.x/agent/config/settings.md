<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & generated image styles

## Install & enable

```bash
composer require drupal/easy_lqp
drush en easy_lqp -y
```

Only dependency is core **`image`**. `hook_install()` (`easy_lqp.install`) creates the `easy_lqp`
DB table. No sub-modules, no permissions of its own, no Drush commands.

## The form

`GenerateImageStyles` (`src/Form/Config/GenerateImageStyles.php`, extends `ConfigFormBase`, form id
**`easy_lqp_images_generator`**):

- Route **`easy_lqp.generate`** → `/admin/config/media/image-styles/generate`, requirement
  `_permission: 'administer image styles'`.
- Exposed as a **local task** ("Generate image styles") on the Image styles collection
  (`easy_lqp.links.task.yml`, base route `entity.image_style.collection`), and as the module's
  `configure` link.
- Edits config object **`easy_lqp.settings`** (`getEditableConfigNames()`).

## Config object `easy_lqp.settings`

Schema `config/schema/easy_lqp.schema.yml` (type `config_object`; every value typed `string`):

| Key | Form widget | Meaning |
|---|---|---|
| `generate_lqp_upload` | checkbox | Generate LQP versions eagerly on file **upload** (slower uploads) instead of lazily on first render. Not in schema but read/written by the form and `easy_lqp.module`. |
| `threshold_width` | number 10–500 step 10 | Preferred pixel gap between generated width styles. |
| `minimum_width` | number 50–1000 step 50 | Smallest generated width. |
| `maximum_width` | number 50–3000 step 50 | Largest generated width. |
| `aspect_ratios` | textarea | Newline-separated `w:h` list (e.g. `16:9`, `4:3`). |
| `threshold_height` | number 10–500 step 10 | Preferred pixel gap between generated height styles. |
| `minimum_height` | number 50–1000 step 50 | Smallest generated height. |
| `maximum_height` | number 100–3000 step 50 | Largest generated height. |

`validateForm()` makes the width group (threshold/min/max/aspect_ratios) mutually required if any
width field is set, and likewise for the height group.

## What submit generates

`submitForm()` saves the config, then via `image_style` storage creates any missing styles and
finally **deletes** every style whose name starts with `responsive_` that is not in the freshly
generated set. Naming (constants `EASY_LQP_WIDTH = 30`, `EASY_LQP_HEIGHT = 30`,
`EASY_LQP_ASPECT_RATIO_MULTIPLE = 5` in `EasyLqpImagesManager`):

- **Width axis** (when `minimum_width` & `maximum_width` set):
  - `responsive_30w_lqp` — the LQP source, `image_scale` width 30, upscale, **no** convert.
  - `responsive_<w>w` for `w` from min to max stepping by `threshold_width` (default 100) —
    `image_scale` width `w` + `image_convert` to `webp`.
- **Aspect ratios** (also requires width min/max): for each `w:h`:
  - `responsive_<w*5>_<h*5>_lqp` — the LQP source, `image_scale` to `w*5 × h*5`, upscale + convert.
  - `responsive_<w>_<h>_<width>w` for each width step — `focal_point_scale_and_crop` (if
    `focal_point` enabled) else `image_scale_and_crop` to `width × (width/w*h)`, + convert to webp.
- **Height axis** (when `minimum_height` & `maximum_height` set):
  - `responsive_30h_lqp` — `image_scale` height 30, upscale, no convert.
  - `responsive_<h>h` for each height step — `image_scale` height `h` + convert to webp.

> Re-saving the form deletes any other `responsive_*` image style. Do not name unrelated styles
> with the `responsive_` prefix, or they will be removed on the next save.

## Config export example

```yaml
# easy_lqp.settings
generate_lqp_upload: false
threshold_width: '100'
minimum_width: '50'
maximum_width: '1450'
aspect_ratios: |-
  16:9
  4:3
threshold_height: ''
minimum_height: ''
maximum_height: ''
```
