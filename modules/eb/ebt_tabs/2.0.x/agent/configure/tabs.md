<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using & configuring EBT Tabs

EBT Tabs has no settings page. Enabling it installs the structures below; you then create "EBT Tabs"
blocks (block UI or Layout Builder) and add tabs.

## Installed structures (`config/install/`)

- **Block type** `block_content.type.ebt_tabs` ("EBT Tabs").
  - Field `field_ebt_tabs` — unlimited paragraph reference to `ebt_tab`.
  - Field `field_ebt_settings` — EBT settings field (from `ebt_core`), edited with widget
    `ebt_settings_tabs`.
- **Paragraph type** `paragraphs.paragraphs_type.ebt_tab` with fields:
  | Field | Type | Role |
  |---|---|---|
  | `field_ebt_tab_title` | text | Tab label |
  | `field_ebt_tab_content` | list (text/page/block/views) | Selects which value field is used |
  | `field_ebt_tab_text` | formatted text | Content when `text` |
  | `field_ebt_tab_page` | entity reference (node) | Content when `page` |
  | `field_ebt_tab_block` | block_field | Content when `block` |
  | `field_ebt_tab_views` | viewsreference | Content when `views` |

## Content-type selector behaviour (hooks)

`EbtTabsHooks` (`src/Hook/EbtTabsHooks.php`):
- `field_widget_single_element_entity_reference_paragraphs_form_alter` and
  `field_widget_single_element_paragraphs_form_alter`: for `ebt_tab` paragraphs, add `#states` so only
  the value field matching `field_ebt_tab_content` is visible
  (`text→field_ebt_tab_text`, `page→field_ebt_tab_page`, `block→field_ebt_tab_block`,
  `views→field_ebt_tab_views`).
- `form_alter`: on `block_content_ebt_tabs_form`, appends validator `_ebt_tabs_form_validation`
  (`.module`) which requires the value field for each tab's selected content type (else sets a
  "field is required" error).

## Settings widget & style presets

`EbtSettingsTabsWidget` (id `ebt_settings_tabs`, field type `ebt_settings`) extends
`ebt_core`'s `EbtSettingsDefaultWidget` and adds:
- `pass_options_to_javascript` (hidden, TRUE) — hands the settings to the jQuery UI Tabs JS.
- `styles` radios: `default`, `without_header_background`, `minimalist_tabs`, `tabs_like_buttons`,
  `vertical_tabs`, `vertical_tabs_rotated`.

## Create a Tabs block

1. Structure → Block layout → Add custom block → **EBT Tabs** (or add it in Layout Builder).
2. Add one or more tabs; per tab set the title, choose content type, fill the shown value field.
3. Pick a style preset in the EBT settings; save and place the block.
