<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Call to Action — the CSS builder service and preprocess wiring

## Service `ept_cta.generate_cta_css` — `GenerateCtaCSS`
`src/Services/GenerateCtaCSS.php`, `implements ContainerInjectionInterface`, constructed with
`@config.factory` and holding `ept_core.settings`. One method:

`generateFromSettings($settings, $paragraph_class)` — builds a scoped inline `<style>` string for a
single CTA paragraph. Selectors are all prefixed with the passed `paragraph-id-<id>` class:
- `$cta_selector = .<class> .ept-paragraph-cta__content`
- `$col_1_selector = … .column-1`, `$col_2_selector = … .column-2`

Logic:
1. **Mobile breakpoint** — `$settings['mobile_breakpoint']`, else `ept_core_mobile_breakpoint`, else
   `480`; `str_replace('px','', …)` then used numerically. Emits a
   `@media screen and (max-width: <bp>px)` block setting both columns to `width:100%` and the content
   to `flex-direction:column; gap:0` (stacks the two columns on mobile).
2. **Image on right** — if `image_position == 'right'` and `styles` is `two_columns` /
   `two_columns_fluid`: `.column-1{order:2}` / `.column-2{order:1}` (swaps visual order).
3. **Mobile image order** — `image_order_mobile == 'image_first'` → within the breakpoint media query
   `.column-1{order:1}` / `.column-2{order:2}`; `'image_last'` → `.column-1{order:2; margin-top:20px}`
   / `.column-2{order:1}`.
4. **Fluid image** — if `styles == 'two_columns_fluid'`: inside the media query, the column-1 image
   field is reset to `width:auto; position:inherit; height:auto`.

Returns `'<style>' . $cta_styles . '</style>'`. All values fed into the string come from the
constrained widget fields (`image_position`/`image_order_mobile`/`styles` are radios;
`mobile_breakpoint` is a numeric form element), and only fixed CSS literals surround them.

## Preprocess wiring — `EptCtaHooks::preprocessParagraph()`
`src/Hook/EptCtaHooks.php` (registered via `ept_cta.module`'s `#[LegacyHook]`
`hook_preprocess_paragraph`, and its own `#[Hook('preprocess_paragraph')]` attribute):
- Bails unless `#paragraph->bundle() === 'ept_cta'` and the paragraph has `field_ept_settings`.
- `$paragraph_class = 'paragraph-id-' . $paragraph->id();`
- Reads `$ept_settings = $paragraph->field_ept_settings->getValue();`
- Sets `$variables['button_styles'] = ept_basic_button.generate_custom_css
  ->generateFromSettings($ept_settings[0]['ept_settings'], $paragraph_class)` — button + second-button
  colors/hover (`.ept-basic-button` / `.ept-basic-button2`).
- Sets `$variables['cta_styles'] = ept_cta.generate_cta_css->generateFromSettings(…)` — the responsive
  columns above.
The template then prints `{{ styles|raw }}` (ept_core), `{{ button_styles|raw }}`, `{{ cta_styles|raw }}`.

`EptCtaHooks::help()` returns the About text for `help.page.ept_cta`. No other hooks.

## Notes for agents
- `button_styles` comes from **ept_basic_button** (`GenerateCustomCSS`), not this module; it reads
  `title_color`/`background_color`/`hover_*` (validated hex via `Color::validateHex`) and the
  `link_options2` equivalents for the second button, each `str_replace('#','')` + `'#' . Html::escape()`.
- `styles` comes from **ept_core** `GenerateCSS` (the shared Design tab). `cta_styles` is the only
  `<style>` this module builds.
- To customise column behaviour, override `css/ept_cta.css` in a theme rather than the generated
  inline block, which is per-instance and derived from the settings.
