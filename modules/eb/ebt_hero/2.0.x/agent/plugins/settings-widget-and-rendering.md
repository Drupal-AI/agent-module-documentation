<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ebt_hero — settings widget, CSS service, preprocess & templates

The render path is: **`ebt_settings_hero` widget** saves settings → **`preprocessBlock`** hook builds
inline CSS via two services → **Twig templates** print the columns/buttons + the CSS.

## Widget: `EbtSettingsHeroWidget` (id `ebt_settings_hero`)

File `src/Plugin/Field/FieldWidget/EbtSettingsHeroWidget.php`. `@FieldWidget` for field type
`ebt_settings`. **Extends** `Drupal\ebt_basic_button\...\EbtSettingsBasicButtonWidget`, so it inherits
the button design/link options and adds these elements inside `ebt_settings`:

- `styles` (radios): `two_columns` (default) | `one_column`.
- `overlay` (checkbox), `overlay_color` (textfield, default `#000000`), `overlay_alpha` (number,
  min 0 / max 1 / step 0.01, default `0.6`).
- `image_position` (radios): `left` (default) | `right` — for two-column layout.
- `image_order_mobile` (radios): `image_first` (default) | `image_last` | `hide_image`.
- `mobile_breakpoint` (textfield) — defaults to `ebt_core.settings:ebt_core_mobile_breakpoint`, else `480`.
- `link_options2` — a **clone of the inherited `link_options`** (second button): open-in-new-tab,
  nofollow, colors, hover colors, alignment, shape, size, stretched, custom class.

`__construct` injects `config.factory` and reads `ebt_core.settings`. `massageFormValues()` flattens
`link_options` (the first button) up onto the settings root so the templates can read them directly.

## Service: `GenerateHeroCSS` (`ebt_hero.generate_hero_css`)

File `src/Services/GenerateHeroCSS.php`, `services.yml` arg `@config.factory`. Method
`generateFromSettings($settings, $block_class)` returns a `<style>…</style>` string scoped to
`$block_class` (`.ebt-hero-container` and `.hero-col-1/2`). It emits:

- A `@media (max-width: {mobile_breakpoint}px)` rule that makes both columns full-width and stacks
  them (`flex-direction: column`). `mobile_breakpoint` comes from settings else `ebt_core.settings`
  else `480`; a `px` suffix is stripped.
- Column ordering: `image_position == right` (two-column) swaps `order`; `image_order_mobile`
  (`image_first` / `image_last`) sets mobile `order` inside the media query.
- Overlay: when `overlay` is set, parses `overlay_color` hex via `ltrim('#')` + 3→6 expansion +
  `sscanf("%02x%02x%02x")`, then writes a `.{block_class}:after` `rgba(r,g,b,{overlay_alpha})`
  full-cover layer plus `position: relative` on the block and `z-index` on `.ebt-container`.

## Preprocess hook: `EbtHeroHooks::preprocessBlock`

File `src/Hook/EbtHeroHooks.php` (attribute `#[Hook('preprocess_block')]`; `ebt_hero.module` keeps a
`#[LegacyHook]` procedural shim). Guard: returns unless the block is a `block_content` of bundle
`ebt_hero` with a non-empty `field_ebt_settings`. Then it computes `$block_class`
(`block-revision-id-…` for inline blocks, else `ebt-block-{plugin_id}`) and sets:

- `$variables['button_styles']` from `ebt_basic_button.generate_custom_css`.
- `$variables['hero_styles']` from `ebt_hero.generate_hero_css`.

`EbtHeroHooks::help` implements `hook_help` for `help.page.ebt_hero` (one About paragraph).

## Templates

`templates/block--block-content--ebt-hero.html.twig` and `…--inline-block--…` are near-identical.
They build a class list (style, image-position, button shape/size/alignment/stretched, custom class),
`attach_library` `ebt_basic_button/ebt_basic_button_view`, `ebt_hero/common` and the per-style
library, then render two columns: `.hero-col-1` = `field_ebt_hero_column_image`, `.hero-col-2` =
title_prefix + title + body + up to two buttons built from the link fields' `#url`/`#title`. They
print `{{ styles|raw }}`, `{{ button_styles|raw }}`, `{{ hero_styles|raw }}` at the end — these are
the module-generated `<style>` blocks (and `styles` from ebt_core). Button link text and URLs are
printed through normal Twig autoescaping; the only `|raw` values are the module's own
`rel="nofollow"` / `target="_blank"` fragments and the generated style tags.
