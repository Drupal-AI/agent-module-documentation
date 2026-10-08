<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Call to Action (ept_cta) — agent index

Paragraphs bundle **`ept_cta`**: a call-to-action section — title + rich text + optional Media image
laid out in **one or two columns** with **one or two styled link buttons** — built on
**`ept_basic_button`** (which brings **`ept_core`**) and **`paragraphs`**. Version **2.0.x**
(module 2.0.2). Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Maintainers: levmyshkin,
Narine_Tsaturyan.

## What it actually is
- A Paragraphs type + field/display config, **one Twig template**, one CSS file, and a little PHP:
  a field widget, a CSS-builder service, and a hooks class. No routes, no permissions, no Drush, no
  config schema of its own, no `configure` link.
- **Dependencies (info.yml):** `drupal:link`, `drupal:media`, `ept_basic_button:ept_basic_button`,
  `paragraphs:paragraphs`. `ept_basic_button` in turn depends on `ept_core` (source of the
  `ept_settings` field type + shared Design options + `GenerateCSS`). composer: `drupal/ept_basic_button:^2.0`,
  `drupal/paragraphs:^1.0`.
- **Install gate:** `ept_cta.install` `hook_requirements('install')` errors unless a Media type with
  id `image` exists (used by the CTA image field).

## Fields on the `ept_cta` bundle (config/install)
- **`field_ept_title`** — `text_long`, optional; rendered as an `<h2>` heading.
- **`field_ept_text`** — `text_long`, optional; the CTA body copy.
- **`field_ept_cta_column_image`** — `entity_reference` → Media, **cardinality 1**, target bundle
  `image` only; the column/visual image. (Storage shipped here.)
- **`field_ept_cta_link`** — `link` (primary button; title required, `link_type: 17`). (Storage here.)
- **`field_ept_cta_second_link`** — `link` (optional second button; `title: 2`). (Storage here.)
- **`field_ept_settings`** — `ept_settings` (from `ept_core`); the Settings tab. Its storage and the
  title/text storages come from `ept_core`, not this module.

## PHP it provides (`src/`)
- **`Plugin/Field/FieldWidget/EptSettingsCtaWidget`** — `@FieldWidget id = "ept_settings_cta"`
  (for the `ept_settings` field type), extends `ept_basic_button`'s
  `EptSettingsBasicButtonWidget`. Adds the CTA layout options and a **Second Link** button-style
  group. All new fields are constrained radios / selects / a number, plus validated color/class
  fields inherited from the button widget. See `agent/config/settings.md`.
- **`Services/GenerateCtaCSS`** (service `ept_cta.generate_cta_css`) — builds a scoped inline
  `<style>` from the settings: mobile-stack `@media` query at the chosen breakpoint, column order for
  image-left/right, mobile image-first/last order, and fluid-image sizing. See `agent/api/generate-css.md`.
- **`Hook/EptCtaHooks`** — `hook_help` (help.page.ept_cta) and `hook_preprocess_paragraph`: for
  `ept_cta` paragraphs it sets `$variables['button_styles']` (from `ept_basic_button.generate_custom_css`)
  and `$variables['cta_styles']` (from `ept_cta.generate_cta_css`), each scoped by a
  `paragraph-id-<id>` class. `ept_cta.module` registers the legacy hook shims.

## Rendering
- `templates/paragraph--ept-cta--default.html.twig` attaches `ept_basic_button/ept_basic_button_view`
  and `ept_cta/ept_cta`, builds the wrapper classes (`ept-cta`, the `styles` value, `image-position-*`,
  `align-content-*`, shape/size/align/stretched, `paragraph-id-<id>`), renders the two-column or
  one-column body with the two `<a class="ept-basic-button…">` buttons (nofollow/target via `|raw`
  string flags), and ends with **`{{ styles|raw }}` `{{ button_styles|raw }}` `{{ cta_styles|raw }}`** —
  the three scoped `<style>` blocks (ept_core design, button colors, responsive columns).
- `css/ept_cta.css` (library `ept_cta/ept_cta`) styles the CTA layout/columns.

## Config shipped (config/install)
- `paragraphs.paragraphs_type.ept_cta` — the bundle (no behavior plugins).
- The six field instances + three field storages listed above.
- `core.entity_form_display.paragraph.ept_cta.default` — `field_group` **Tabs**: **Content** tab
  (title, text, image via `media_library_widget`, both links via `link_default`) and **Settings** tab
  (`field_ept_settings` with widget `ept_settings_cta`).
- `core.entity_view_display.paragraph.ept_cta.default` — image via `entity_reference_entity_view`,
  links via `link`, settings via `ept_settings_default`, title/text via `text_default` (labels hidden).

## Solution docs
- `agent/config/settings.md` — the bundle, fields, form/view displays, and every `ept_settings_cta`
  widget option (layout, alignment, image position/order, breakpoint, second-button styles).
- `agent/api/generate-css.md` — `GenerateCtaCSS::generateFromSettings()` and the preprocess wiring
  that emits `button_styles` / `cta_styles`.

## Relation to the EPT family
Same shape as the other EPT paragraph types (`ept_columns`, `ept_text`, `ept_block`, …): all share
`ept_core`'s `ept_settings` Design tab and the `{{ styles|raw }}` scoped-style emission; `ept_cta`
additionally layers `ept_basic_button`'s button styling and its own two-column responsive CSS. The
EBT family (`ebt_*`, incl. `ebt_cta`) is the block-plugin equivalent.
