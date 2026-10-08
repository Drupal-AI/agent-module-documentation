<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & use the Basic Button block

No dedicated settings form. Configuration is (a) the shipped block type + fields and (b) global
defaults from EBT Core.

## Block type and fields

`config/install` creates block content type `ebt_basic_button` with:
- `field_ebt_basic_button_link` — core **Link** field (the button target + text).
- `field_ebt_settings` — `ebt_settings` field type (provided by `ebt_core`), edited with the
  `ebt_settings_basic_button` widget below.

Create instances at *Content → Block library → Add custom block → EBT Basic Button*, or add an
inline block in Layout Builder. Placement/creation uses core block content and Layout Builder
permissions — this module adds none of its own.

Troubleshooting (README): if the Field Layout module forces Layout Builder onto the block type,
disable it at `/admin/structure/block/block-content/manage/ebt_basic_button/display/default`.

## Widget settings (`ebt_settings_basic_button`)

Rendered inside a "Link options" details group (`EbtSettingsBasicButtonWidget::formElement`), stored
in `field_ebt_settings.ebt_settings`:

| Setting | Type | Default |
|---|---|---|
| `open_in_new_tab` | checkbox | off |
| `add_nofollow` | checkbox | off |
| `title_color` | text (colour) | `#ffffff` |
| `background_color` | text (colour) | EBT Core `ebt_core_background_color` |
| `custom_hover_colors` | checkbox | off (reveals the two hover fields) |
| `hover_title_color` | text (colour) | empty (fallback `#fff`) |
| `hover_background_color` | text (colour) | empty (fallback `#0d77b5`) |
| `alignment` | radios left/center/right | `left` |
| `shape` | radios square/round/circle | `square` |
| `size` | radios small/medium/large | `medium` |
| `stretched` | checkbox | off |
| `custom_class_name` | text | empty |

Colour fields run `EbtSettingsDefaultWidget::validateColorElement`; `custom_class_name` runs
`EbtGenericValidator::validateClassElement`. `massageFormValues()` flattens the `link_options`
subtree back onto `ebt_settings` and (legacy) maps old `ept_settings` keys.

Attached libraries: `ebt_core/colorpicker` and `ebt_basic_button/ebt_basic_button_form`.

## Global defaults (EBT Core)

Primary/secondary colours and mobile/tablet/desktop breakpoints are set once in EBT Core at
*Configuration → Content authoring → Extra Block Types (EBT) settings*
(`/admin/config/content/ebt-settings`) and used as defaults across EBT blocks (e.g. the button
background colour default above).

## Generated CSS

On block render, `EbtBasicButtonHooks::preprocessBlock()` (hook_preprocess_block) invokes the
`ebt_basic_button.generate_custom_css` service. `GenerateCustomCSS::generateFromSettings()` builds a
scoped inline `<style>` — selectors `.<block-class> .ebt-basic-button{…}` and `:hover{…}` — from the
stored colours, each passed through `Html::escape`. The result is the `button_styles` twig variable.
