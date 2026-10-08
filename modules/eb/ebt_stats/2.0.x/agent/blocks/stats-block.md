<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Stats — block type, paragraph type, fields, displays

All defined as shipped config in `config/install/`. Installed on module enable; `hook_uninstall()`
(`ebt_stats.install`) only logs a notice and intentionally leaves the block type in place.

## Install / enable

`drush en ebt_stats` (pulls in `ebt_core` and `paragraphs`). EBT Core expects a Media **Image**
type to exist first (used for background/icon images). No settings form is provided by this module;
site-wide EBT defaults (colors, breakpoints) live under EBT Core.

## Block content type `ebt_stats`

`block_content.type.ebt_stats.yml` — id `ebt_stats`, label "EBT Stats", `revision: 0`. Fields:

- **`body`** — `text_with_summary` (`field.field.block_content.ebt_stats.body.yml`), optional, WYSIWYG
  intro/description shown above the numbers. Rendered with the `text_default` formatter.
- **`field_ebt_settings`** — EBT Core `ebt_settings` field type
  (`field.field.block_content.ebt_stats.field_ebt_settings.yml`), optional, translatable. Holds the
  shared design options (margins/padding/borders, background color/image/video, edge-to-edge,
  container width) plus this module's **styles** selection (see settings-widget.md). Default value
  seeds `design_options` and `pass_options_to_javascript: false`.
- **`field_ebt_stats`** — `entity_reference_revisions`
  (`field.storage.block_content.field_ebt_stats.yml` + `.field_ebt_stats.yml`), `cardinality: -1`,
  **required**, target type `paragraph`, restricted to bundle `ebt_stats_item`. This is the
  repeatable list of statistics.

## Paragraph type `ebt_stats_item`

`paragraphs.paragraphs_type.ebt_stats_item.yml` — id `ebt_stats_item`, "EBT Stats Item". Fields:

- **`field_stats_item_number`** — `text_long`, **required**. The large statistic value (free text,
  so "10k+", "99.9%" etc. are allowed).
- **`field_stats_item_text`** — `text_long`, optional. Caption/description under the number.
- **`field_stats_item_link`** — `link`, optional (title optional, external/internal allowed).
- **`field_stats_item_image`** — `entity_reference` → media, restricted to the `image` bundle,
  optional. Used as an icon/badge.

All four are cardinality 1 and stored per paragraph item.

## Form display (`core.entity_form_display.block_content.ebt_stats.default`)

Uses **field_group** to build a "Tabs" group with **Content** (body + `field_ebt_stats` via the
`paragraphs` widget, drag-and-drop, add mode `dropdown`) and **Settings** (`field_ebt_settings` via
the `ebt_settings_stats` widget). Paragraph item form
(`core.entity_form_display.paragraph.ebt_stats_item.default`) uses `media_library_widget` for the
image, `text_textarea` for number/text, and `link_default` for the link.

## View display (`core.entity_view_display.block_content.ebt_stats.default`)

- `body` → `text_default` (label hidden)
- `field_ebt_settings` → `ebt_settings_default` formatter (from ebt_core; emits the design CSS)
- `field_ebt_stats` → `entity_reference_revisions_entity_view` (renders each paragraph)

Paragraph view display (`core.entity_view_display.paragraph.ebt_stats_item.default`): number/text as
`text_default`, image as `entity_reference_entity_view`, link as `link`. All labels hidden. All
field content is rendered through standard Drupal field/formatter pipelines (text-format filtered),
not raw.

## Operating notes

- Create reusable blocks at Block layout → Custom block library → "EBT Stats", or add inline blocks
  inside a Layout Builder section (both templates ship: block-content and inline-block).
- If Field Layout is enabled it may force Layout Builder onto the block display; disable it at
  `/admin/structure/block/block-content/manage/ebt_stats/display/default` (see README).
