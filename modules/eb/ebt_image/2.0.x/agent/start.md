<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Image (ebt_image) — agent index

Ships an `ebt_image` `block_content` bundle that renders a single Media image with an optional caption, wrapping link, per-block image style, greyscale/hover effects, and a GLightbox popup. Display-only: no routes, permissions, or config form.

- **Version:** 2.0.x · **Core:** `^10.1 || ^11 || ^12` · **License:** GPL-2.0-or-later
- **Composer requires:** `drupal/ebt_core:^2.0`, `drupal/glightbox:^1.0`
- **Module deps (info.yml):** `ebt_core`, `media`, `link`, `glightbox`
- **Install requirement:** `hook_requirements()` (in `ebt_image.install`) errors at install if no `image` media type exists.

## What it provides
- **Block type:** `ebt_image` (`config/install/block_content.type.ebt_image.yml`).
- **Fields on the bundle:**
  - `field_ebt_image` — entity_reference to `media` (bundle `image`), required, cardinality 1.
  - `field_ebt_image_caption` — `text_long` (rich text).
  - `field_ebt_image_link` — `link` (wraps the image).
  - `field_ebt_settings` — `ebt_settings` (shared EBT design settings, provided by ebt_core).
- **Field widget plugin:** `EbtSettingsImageWidget` (id `ebt_settings_image`) extends ebt_core's `EbtSettingsDefaultWidget`; adds Image Style, Enable Image Lightbox, Lightbox Image Style, Greyscale, Colorful on hover.
- **Default displays:** form uses field_group tabs (Content / Settings) + Media Library widget; view display uses `media_thumbnail` (lazy) for the image, `ebt_settings_default` for settings.
- **Service:** only the autowired hook class `Drupal\ebt_image\Hook\EbtImageHooks` (`ebt_image.services.yml`).
- **Libraries:** `ebt_image/ebt_image` (CSS, always attached); `ebt_image/ebt_image_lightbox` (CSS + `glightbox` + `glightbox/init`, attached only when lightbox is on).

## Runtime behavior
`EbtImageHooks::preprocessBlock` (`#[Hook('preprocess_block')]`, legacy shim `ebt_image_preprocess_block`) calls two helpers in `ebt_image.module`:
- `_ebt_image_apply_image_style()` — swaps `#image_style` on the `image_formatter` render element from the block's `image_style` setting.
- `_ebt_image_apply_lightbox_image_style()` — loads the referenced Media → source File, sets `show_lightbox` + `lightbox_url` (absolute file URL, or `ImageStyle::buildUrl()` when a lightbox style is chosen).

## Solution docs
- [Block type, fields & templates](blocks/image-block.md)
- [Settings widget plugin](plugins/settings-widget.md)

No security-sensitive surface: no routes/permissions/request handling; media is rendered through core formatters; lightbox/link URLs come from core File/ImageStyle/Link APIs.
