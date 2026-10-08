<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings → classes and inline CSS

ept_hero has **no admin/config route of its own**. Site-wide EPT defaults (primary/secondary
colours, mobile breakpoint, container widths) belong to **ept_core** at
`admin/config/content/ept-core` (config object `ept_core.settings`). Per-paragraph settings live in
each paragraph's `field_ept_settings` value.

## Two output channels

1. **CSS classes on the wrapper** — built directly in
   `templates/paragraph--ept-hero--default.html.twig` from the settings: the style
   (`two_columns`/`one_column`), `image-position-*`, `ept-align-*`, `ept-shape-*`, `ept-size-*`,
   `ept-stretched`, plus any per-element additional classes and the button custom class. All
   additional-class fields are validated at input by
   `EptGenericValidator::validateClassElement`.

2. **A per-paragraph `<style>` block** — three services each return a `<style>…</style>` string,
   scoped to `.paragraph-id-N`, printed at the end of the template with `|raw`:

   | Template var | Service | Provides |
   |--------------|---------|----------|
   | `styles` | `ept_core` `GenerateCSS::generateFromSettings` | box model (margin/border/padding), border-radius, background color/image/media, edge-to-edge, container width, background position/size. |
   | `button_styles` | `ept_basic_button` `GenerateCustomCSS::generateFromSettings` | button + button2 `color` / `background-color`, hover colours (from the link-options colour pickers). |
   | `hero_styles` | this module `GenerateHeroCSS::generateFromSettings` | the mobile media query, column `order` swaps (image position + mobile order), and the overlay `:after` (`overlay_color` → RGB via `sscanf`, `overlay_alpha`). |

`ept_hero_preprocess_paragraph()` (`src/Hook/EptHeroHooks.php`) wires `button_styles` and
`hero_styles`; `styles` is supplied by ept_core's own paragraph preprocess.

## GenerateHeroCSS specifics

`generateFromSettings($settings, $paragraph_class)` builds selectors from the `paragraph-id-N`
class and:

- Always emits `@media screen and (max-width: {mobile_breakpoint}px) { .hero-col-1/2 { width:100% }
  .ept-hero-container { flex-direction: column } }`. `mobile_breakpoint` is taken from the
  paragraph setting (else `ept_core_mobile_breakpoint`, else `480`) and only `str_replace('px','')`
  is applied.
- If `image_position == 'right'` and style is `two_columns`, swaps `order` of the two columns.
- If `image_order_mobile` is `image_first` / `image_last`, emits an ordering rule inside the mobile
  media query.
- If `overlay` is set, converts `overlay_color` (hex, `#` stripped) to `rgb` via `sscanf` and emits
  a `.paragraph-id-N:after` translucent overlay plus `position:relative` / `z-index` helpers.

The colour and breakpoint values that feed these strings originate from **free-text form fields**;
see the security notes for the input-handling caveats around the inline `<style>` output.
