<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bmc — configuration, routes, color picker

## Install / enable

`drush en bmc -y` (pulls in core `block`). Then place the block and/or enable the widget, after
setting the account username. Configure link: route `bmc.setting_form`.

## Routes & permissions (`bmc.routing.yml`)

| Route | Path | Handler | Requirement |
|-------|------|---------|-------------|
| `bmc.setting_form` | `/admin/config/bmc-configuration` | `_form: BmcConfigurationForm` | `_permission: administer bmc` |
| `bmc.help` | `/admin/help/bmc` | `BmcHelpController::helpContent` | `_permission: administer site configuration` |

Permission `administer bmc` (`bmc.permissions.yml`) has `restrict access: true` (it controls a
security-sensitive setting — the account/username used for donations). `bmc.help` returns static
`#markup` only.

## Config object: `bmc.settings`

There is **no config schema and no `config/install`** in the module; the single config object is
created on first form save. All values live under the nested key **`bmc_settings`**. Defaults are
supplied inline in PHP (via `?:` / `??`), not in a schema. Written by
`BmcConfigurationForm::submitForm()`; read by `BmcButtonBlock::build()` and
`bmc_page_attachments_alter()`.

Keys (with the code's fallback defaults):

| Key (under `bmc_settings`) | Used by | Default | Notes |
|----------------------------|---------|---------|-------|
| `username` | button + widget | '' | **Required** in the form. Sent as `data-slug` (button) / `data-id` (widget) = your Buy Me a Coffee account. |
| `custom_text` | button | `Buy Me a Coffee` | `data-text`; form `#maxlength 25`. |
| `font_family` | button | `Cookie` | `data-font`; select of Cookie/Lato/Arial/Comic/Inter/Bree/Poppins. |
| `coffee_color` | button | `#FFFFFF` | `data-coffee-color`; `bmc_color_picker`. |
| `background_color` | button | `#FFDD00` (build() fallback) | `data-color`; `bmc_color_picker`. Form default empty. |
| `widget_visible` | widget | `FALSE` | Checkbox; gates the site-wide widget. |
| `widget_description` | widget | `Support me on Buy Me a Coffee!` | `data-description`. |
| `widget_message` | widget | `Thank you for visiting. You can now buy me a coffee!` | `data-message`. |
| `widget_color` | widget | (empty) | `data-color`; `bmc_color_picker`. |
| `widget_align` | widget | `Right` | `data-position`; select Right/Left. |
| `widget_side_spasing` | widget | `18` | `data-x_margin` (px). Key is misspelled "spasing" — match it exactly. |
| `widget_bottom_spasing` | widget | `18` | `data-y_margin` (px). Misspelled key. |

Note the two spacing keys are spelled `..._spasing` in source — reference them verbatim in config
reads/exports.

## How rendering works

- **Button (block):** `BmcButtonBlock::build()` (`src/Plugin/Block/BmcButtonBlock.php`) returns a
  single `#type => html_tag`, `#tag => 'script'` element whose `src` is the fixed CDN URL
  `https://cdnjs.buymeacoffee.com/1.0.0/button.prod.min.js`; the config values populate `data-slug`,
  `data-color`, `data-font`, `data-text`, `data-coffee-color` (plus fixed `data-emoji=''`,
  `data-outline-color`/`data-font-color` `#000000`). Place it via Block layout.
- **Widget (global):** `bmc_page_attachments_alter()` (`bmc.module`) attaches an `html_head`
  `<script>` (fixed CDN `…/1.0.0/widget.prod.min.js`) **only** when `widget_visible` is truthy and
  `str_starts_with($current_path, '/admin')` is false — so it never loads on admin paths. Current
  path comes from `path.current`.

Both scripts are loaded from Buy Me a Coffee's CDN and execute in the browser; no donation data
passes through Drupal.

## `bmc_color_picker` form element (`src/Element/ColorPicker.php`)

Custom `#[FormElement('bmc_color_picker')]` extending core `Radios`. Attaches library
`bmc/color_picker` (and `bmc/color_picker_custom` when `#custom_color` is set).

- `processColorPicker()` builds one radio per `#options` entry (keys hashed as `opt_<md5>` to avoid
  collisions; explicit `#parents` keep the value scalar — it deliberately does **not** set
  `#tree`). With `#custom_color = TRUE` it also adds a native `#type => color` input and a hex
  `textfield` (`#pattern '#[0-9A-Fa-f]{6}'`) under an isolated `_bmc_picker_ui_*` parents prefix so
  the UI-only inputs never pollute the stored value.
- `valueCallback()` / `validateColorPicker()` uppercase-trim the value and accept it only if it is
  empty or matches **`/^#[0-9A-F]{6}$/`**; anything else raises a form error. Non-scalar values are
  nulled. So stored colors are always normalized `#RRGGBB` (or empty).

Used in `BmcConfigurationForm` for `coffee_color`, `background_color`, and `widget_color`; preset
swatch options are the eight brand colors (orange `#FF813F`, blue, violet, red, green, pink, yellow,
white) built in `buildForm()`.

## Operating notes

- Set `username` first (required) — an empty slug yields a non-functional button/widget.
- The widget is head-injected on every non-admin page once enabled; use the block instead when you
  want per-region/per-page placement with core block visibility conditions.
- No cache metadata is attached to the widget script beyond default; config changes take effect after
  a cache clear if pages are cached.
