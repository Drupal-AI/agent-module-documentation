<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy LQP (Low Quality Placeholder) (easy_lqp) — agent index

Generates a low-quality **base64 `data:` URI placeholder** sent inline in the initial HTML, plus a
family of core `responsive_*` **image styles**, and swaps the placeholder for the best-fit
derivative with client JS. Package `Other`. Depends only on core **`image`**. Core requirement
`^10 || ^11`. License GPL-2.0-or-later. Version **2.0.4**. No permissions of its own, no Drush.

- **The settings form, generated image styles, config object & schema** →
  [config/settings.md](config/settings.md)
- **The `Easy LQP Images` field formatter, template & resizer JS** →
  [fields/formatter.md](fields/formatter.md)
- **The `easy_lqp.manager` service, `image_url` Twig filter, DB table & file hooks** →
  [api/manager.md](api/manager.md)

## What it actually is

- **Config form** `GenerateImageStyles` (`src/Form/Config/GenerateImageStyles.php`, form id
  `easy_lqp_images_generator`) at route **`easy_lqp.generate`** →
  `/admin/config/media/image-styles/generate`, permission **`administer image styles`**. Writes
  config object **`easy_lqp.settings`** (schema in `config/schema/easy_lqp.schema.yml`) and, on
  submit, bulk-creates/deletes `responsive_*` image styles.
- **Field formatter** plugin `EasyLqpImagesFormatter` (id **`easy_lqp_images`**, label *"Easy LQP
  Images"*), extends core `ImageFormatter`, `field_types = { "image" }`.
- **Service** `easy_lqp.manager` → `EasyLqpImagesManager` (interface `EasyLqpImagesManagerInterface`):
  generates/reads the LQP base64, builds per-aspect-ratio and per-scale srcset arrays, validates
  files, adds WebP variants.
- **Twig extension** service `easy_lqp.image_url` → `ImageUrl`, providing the **`image_url`** filter.
- **Theme hook** `easy_lqp_formatter` (template `templates/easy-lqp-formatter.html.twig`) and
  **library** `easy_lqp/resizer` (`js/resizer.js`, `css/easy-lqp.css`; deps `core/drupal`,
  `core/once`).
- **DB table** `easy_lqp` (`easy_lqp.install`): `id`, `fid`, `lqp` (mediumtext base64),
  `image_style` (the LQP "type" label). File `hook_ENTITY_insert/update/delete` keep it in sync.

## Mechanism (from source)

- The settings form generates, per configured range/step: one LQP style per axis
  (`responsive_30w_lqp`, `responsive_30h_lqp`, `responsive_<5w>_<5h>_lqp`) plus the full-size
  `responsive_<w>w`, `responsive_<h>h` and `responsive_<w>_<h>_<width>w` styles (each with
  `image_scale` / `image_scale_and_crop` + `image_convert` to `webp`; Focal Point crop if enabled).
  Styles starting `responsive_` that are no longer in the generated set are **deleted**.
- `EasyLqpImagesFormatter::viewElements()` re-themes each element to `easy_lqp_formatter`, computes
  the srcset from `EasyLqpImagesManager::getImagesByScale()` / `getImagesByAspectRatio()`, sets the
  `src` to `getLqp()` (the inline base64), and tags the `<img>` with `easy-lqp-image` +
  `data-multiplier` / `data-cover` / `data-ratio` for the JS.
- `getLqp()` returns the cached row for `(fid, image_style-type)`, else calls `generateLqp()` which
  builds the LQP derivative, base64-encodes it into a `data:` URI and stores it.
- `resizer.js` (`Drupal.behaviors.easyLQP`) observes each image; on viewport entry / container
  resize it selects the smallest `data-srcset` entry ≥ target width and fades in a `<source>`.

## Config keys (`easy_lqp.settings`)

`generate_lqp_upload` (bool — generate on file upload vs. lazily on render), `threshold_width`,
`minimum_width`, `maximum_width`, `aspect_ratios` (newline `w:h` list), `threshold_height`,
`minimum_height`, `maximum_height`. All string/number; details in
[config/settings.md](config/settings.md).

## Notes

- `composer.json` is an unpublished scaffold (`name: kanopi/easy_lqp`, `license: proprietary`,
  `minimum-stability: dev`); the authoritative license is GPL-2.0-or-later (`LICENSE.txt`,
  `easy_lqp.info.yml`). `security_advisory_coverage: not-covered`.
- WebP variants require **ImageAPI Optimize WebP** (or `webp`); external images in the Twig filter
  require **Imagecache External**; aspect-ratio crops honor **Focal Point** when installed.
