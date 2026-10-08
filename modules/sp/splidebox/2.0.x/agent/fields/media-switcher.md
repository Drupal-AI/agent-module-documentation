<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Splidebox as a Blazy Media switcher

Splidebox provides **no field formatter**. It is a lightbox that any
Blazy-based renderer opts into through the **Media switcher** select.

## Enable on a field formatter

1. *Manage display* for the entity/view mode (e.g.
   `/admin/structure/types/manage/article/display`).
2. For an image/media/paragraphs field, choose a Blazy-related **Format**:
   **Blazy** or **Splide**.
3. Open the formatter's settings (gear icon).
4. **Media switcher** → **Image to Splidebox**.
5. Set **Lightbox image style** (Scale, width + empty height — not cropped) and,
   for thumbnail nav, a cropped **Thumbnail style**.

Same switch works in **Blazy Filter** (text formats, for inline body images) and
in Blazy-related **Views styles** (Blazy Grid, Splide, Table, List).

## Lightbox AJAX link (entity-reference fields)

When the switcher is Splidebox on an `entity_reference` /
`entity_reference_revisions` field of a supported namespace (`blazy`,
`gridstack`, `mason`, `outlayer`, `splide`), the formatter grows a **Lightbox
AJAX link** select (`Splidebox::formElementAlter()`). Pick a **single-value
link/string field** whose value is an internal node URL (`/node/123`); that
node's rendered content is loaded into the lightbox body via `Drupal.ajax`.
Only internal, access-granted, non-external URLs are honored
(`Splidebox::toAjaxUrl()` enforces entity `view` access, `Url` access,
`UrlHelper::filterBadProtocol()`). Other entities/forms are intentionally
unsupported.

## Per-field code overrides

`hook_splidebox_attach_alter(array &$load, array &$attach)` (or the Blazy/Splide
alters) let you set, per field:

- `box_ajax_only` (bool) — replace media with AJAX content only (default FALSE:
  image/video shown above AJAX content, hybrid).
- `box_ajax_drag` (bool) — allow dragging AJAX slides.
- `box_nav` (optionset id) — thumbnail nav optionset (default from Blazy UI
  *Extras → Splidebox nav*, normally `splidebox_nav`).
- `box_layout` (default `bottom`) / `box_caption_pos` (`overlay` default, or
  `inline` Colorbox-style).
- `skin_lightbox` / `skin` — override the lightbox skin (default `skyblue`).

## Optionsets

- `splide.optionset.splidebox` — main lightbox slider (skin Skyblue, 100vw,
  rewind, keyboard global). Edit at
  `/admin/config/media/splide/list/splidebox/edit`.
- `splide.optionset.splidebox_nav` — asNavFor thumbnail strip (skin `sbox-nav`,
  isNavigation, perPage responsive).

Both are enforced config owned by the module; `zoom` and `fullscreen` options are
force-enabled for the main slider in `Splidebox::getOptions()`.
