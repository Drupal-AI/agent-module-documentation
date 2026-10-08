<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Splidebox (splidebox) — agent index

A full-screen image/media **lightbox** built on the **Splide** slider. It has no
formatter of its own: it registers itself as a Blazy lightbox and is switched on
through Blazy's **Media switcher → "Image to Splidebox"** option. Vanilla JS
(no jQuery). Hard-depends on `splide` (which depends on `blazy`); core
requirement `>=8.8` (runs on 10 and 11).

## What you'd do → where

- **Turn the lightbox on for a field** → set a Blazy or Splide field formatter's
  **Media switcher** to "Image to Splidebox" at *Manage display*. See
  [fields/media-switcher.md](fields/media-switcher.md).
- **Lightbox inline body images** → enable **Blazy Filter** on a text format,
  Media switcher "Image to Splidebox".
- **Lightbox a Views gallery** → use a Blazy-related Views style (Blazy Grid,
  Splide, Table, List) with Media switcher "Image to Splidebox".
- **Add thumbnail (asNavFor) navigation** → Blazy UI, *Extras settings →
  Splidebox nav* at `/admin/config/media/blazy` (needs `blazy_ui`).
- **Change the lightbox slider/skin** → edit the `splidebox` Splide optionset at
  `/admin/config/media/splide/list/splidebox/edit` (needs `splide_ui`).
- **Load a node into the lightbox via AJAX** → pick a single-value link field in
  the formatter's **Lightbox AJAX link** select (appears when switcher is
  Splidebox on an entity-reference field).
- **Override per-field behavior in code** → `hook_splidebox_attach_alter($load,
  $attach)`; keys: `box_nav`, `box_ajax_only`, `box_ajax_drag`, `box_layout`,
  `box_caption_pos`, `skin_lightbox`.

## Key facts (real names)

- **No custom routes, permissions, forms, or Drush.** Config UI is borrowed from
  Blazy UI (`administer blazy`) and Splide UI (`administer splide`).
- **Service** `splidebox` → `Drupal\splidebox\Splidebox` (extends
  `Drupal\splide\SplideManager`, implements `SplideboxInterface`); procedural
  shortcut `splidebox()` in `splidebox.module`.
- **Wiring is all Blazy hooks** in `splidebox.module`:
  `hook_blazy_lightboxes_alter` (registers the `splidebox` lightbox),
  `hook_blazy_attach_alter`, `hook_blazy_settings_alter`,
  `hook_blazy_is_blazy_alter`, `hook_blazy_form_element_alter` (adds the AJAX-link
  select), `hook_preprocess_blazy`, `hook_config_schema_info_alter`,
  `hook_form_blazy_settings_form_alter` (adds the *Splidebox nav* select).
- **Mechanism:** `Splidebox::toAttributes()` serializes the lightbox Splide
  optionset to `base64_encode(Json::encode(...))` into `data.splidebox`; the
  loader `js/splidebox.load.min.js` decodes it with `atob` + JSON parse and
  builds the lightbox DOM from a dummy template on click.
- **Skin plugin** `SplideboxSkin` (`@SplideSkin` id `splidebox_skin`) registers
  the `sbox-nav` nav skin. Default main skin is **Skyblue** (`skin: skyblue`).
- **Install config** (no schema file of its own): `splide.optionset.splidebox`
  (main) and `splide.optionset.splidebox_nav` (thumbnail strip), enforced-owned
  by this module and edited via Splide UI.
- **Libraries** (`splidebox.libraries.yml`): `base`, `splidebox`, `load`, `nav`,
  `zoom`, `ajax` — all layered on `blazy/*` and `splide/*` deps.
- **AJAX-link safety** lives in `Splidebox::toAjaxUrl()`: entity `view` access +
  `Url` access checks, rejects external URLs, `UrlHelper::filterBadProtocol()`.

## Accessibility — verify by hand

The lightbox root sets `tabindex="-1"`, `aria-label`, `aria-hidden`, a
`polite` counter, and Escape closes it (`keydown` handler). Still confirm:
focus **moves into** the dialog and is **trapped**, focus **returns to the
trigger** on close, and the dialog exposes an appropriate **role/name** — these
are what separate a usable lightbox from a broken one.
