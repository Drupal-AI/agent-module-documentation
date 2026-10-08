<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CTA settings widget, CSS generation & rendering

The CTA layout has no site-wide config object. Every option is stored per block instance in the
`field_ebt_settings` value and edited through the widget below; the module's fallback mobile
breakpoint reads from `ebt_core.settings` (`ebt_core_mobile_breakpoint`, default `480`).

## Widget `ebt_settings_cta`

`src/Plugin/Field/FieldWidget/EbtSettingsCtaWidget.php` (id `ebt_settings_cta`, field type
`ebt_settings`) **extends** `EbtSettingsBasicButtonWidget` from `ebt_basic_button`, so it inherits
the full button + design-options form and adds these CTA controls in `formElement()`:

| Setting key | Element | Options / default | Effect |
|---|---|---|---|
| `styles` | radios | `two_columns` (default), `two_columns_fluid`, `one_column` | Layout; two-column values trigger the image column in Twig. |
| `align_content` | radios | `left` (default), `center`, `right` | Adds `align-content-*` class. |
| `image_position` | radios | `left` (default), `right` | In two-column layouts, `right` swaps column order via CSS `order`. |
| `image_order_mobile` | radios | `image_first` (default), `image_last` | Column `order` under the mobile breakpoint. |
| `mobile_breakpoint` | number | default from `ebt_core.settings` or `480` | Max-width (px) at which columns stack to one. |

It also injects a hidden `pass_options_to_javascript` = FALSE, a heading element, and clones the
inherited `link_options` into **`link_options2`** (weight 3, title "Second Link options") so the
second button gets its own color/shape/size/alignment/custom-class controls. `massageFormValues()`
flattens the first link's `link_options` up onto `ebt_settings` (so `alignment`, `shape`, etc. for
the primary button live at the top level), and defaults each row's `ebt_settings` to `[]`.

## CSS generation — `GenerateCtaCSS`

Service **`ebt_cta.generate_cta_css`** (`src/Services/GenerateCtaCSS.php`, ctor arg `@config.factory`,
reads `ebt_core.settings`). `generateFromSettings($settings, $block_class)` builds selectors scoped
to the block's generated class (`.ebt-block-<plugin_id>`) and returns a single `<style>…</style>`
string covering:

- A `@media (max-width: {breakpoint}px)` rule setting `.column-1`/`.column-2` to `width:100%` and
  the content flex container to `flex-direction: column`.
- `order` swaps for `image_position: right` (two-column styles) and for `image_order_mobile`.
- A fluid-image reset under the breakpoint for `two_columns_fluid`.

The breakpoint falls back: instance `mobile_breakpoint` → `ebt_core.settings.ebt_core_mobile_breakpoint`
→ `480`, then `px` is stripped. All inputs are constrained radio/number settings; no free-text field
feeds the generated CSS.

## Preprocess & templates

`EbtCtaHooks::preprocessBlock()` (`hook_preprocess_block`, `src/Hook/EbtCtaHooks.php`) runs only for
`ebt_cta` blocks that have a non-empty `field_ebt_settings`. It computes `$block_class`
(`block-revision-id-…` for inline blocks, else `ebt-block-<plugin_id>`), then sets two variables from
services:

- `variables['button_styles']` ← `ebt_basic_button.generate_custom_css` (button colors/styles).
- `variables['cta_styles']` ← `ebt_cta.generate_cta_css` (layout/responsive rules above).

`templates/block--block-content--ebt-cta.html.twig` and `…block--inline-block--ebt-cta.html.twig`
build the wrapper class list (including `styles`, `image-position-*`, `align-content-*`, and
button shape/size/alignment classes), render the image into `.column-1` and text+buttons into
`.column-2` for two-column styles (single column otherwise), and emit `{{ styles|raw }}`,
`{{ button_styles|raw }}`, `{{ cta_styles|raw }}` at the end. `custom_class_name` /
`link_options2.custom_class_name` are printed into the button `class` attribute (Twig
auto-escaped). Buttons are plain `<a href="…#url">…#title</a>`; `nofollow`/`target` are literal
strings toggled by the `add_nofollow` / `open_in_new_tab` settings. The templates attach
`ebt_basic_button/ebt_basic_button_view` and `ebt_cta/ebt_cta` (`css/ebt_cta.css`).

## Operate it

There is nothing to configure globally. To change appearance, edit a CTA block and use the
**Settings** tab. To change the default stacking breakpoint across all EBT blocks, set
`ebt_core_mobile_breakpoint` in EBT Core's settings.
