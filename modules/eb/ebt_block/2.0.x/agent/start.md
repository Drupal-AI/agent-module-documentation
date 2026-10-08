<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Block (ebt_block) — agent index

A **config-only** module: it ships a `block_content` type **`ebt_block`** that embeds any Drupal
block (View / content block / programmatic block) via **Block Field** and wraps it in the shared
**Extra Block Types (EBT)** design layer. No `src/` PHP. Package `Extra Block Types`.
Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Version 2.0.0.

- **What it installs, the fields, displays, templates, and how to operate it** →
  [config/block-type.md](config/block-type.md)

## Dependencies

- `ebt_core:ebt_core` (`^2.0`) — contributes the `ebt_settings` field type/widget/formatter, the
  `field_ebt_settings` field storage, the `styles` render variable, and all inline-`<style>`
  generation. See the ebt_core docs: [../../../ebt_core/2.0.x/agent/start.md](../../../ebt_core/2.0.x/agent/start.md).
- `block_field:block_field` (`^1.0`) — provides the `block_field` field type/widget/formatter used
  by `field_ebt_block_block` to pick and configure the embedded block plugin.

## What it actually provides (from source)

- **Block type**: `block_content.type.ebt_block` (id `ebt_block`, label "EBT Block").
- **Fields on the bundle**:
  - `body` — core `text_with_summary` (rich text).
  - `field_ebt_block_block` — `block_field`, cardinality 1, `selection: categories` (the embedded
    block; storage `field.storage.block_content.field_ebt_block_block`).
  - `field_ebt_settings` — `ebt_settings` field type (design options; storage owned by ebt_core).
- **Form display** (`core.entity_form_display.block_content.ebt_block.default`): a `field_group`
  Tabs group with a **Content** tab (info, body, block) and a **Settings** tab (`field_ebt_settings`,
  widget `ebt_settings_default`).
- **View display** (`core.entity_view_display.block_content.ebt_block.default`): body (`text_default`),
  block (`block_field`), settings (`ebt_settings_default`, label hidden).
- **Templates**: `templates/block--block-content--ebt-block.html.twig` and
  `templates/block--inline-block--ebt-block.html.twig` (registered against ebt_block by
  `ebt_core`'s `hook_theme_registry_alter`).
- **No** permissions, routes, services, hooks, Drush commands, or config schema of its own
  (schema for `ebt_settings` lives in ebt_core).

## Operate it

- Enable: `drush en ebt_block -y` (pulls in `ebt_core` and `block_field`).
- Create: Structure » Block layout » Add content block » **EBT Block**; choose the embedded block
  on the **Content** tab, set design options on the **Settings** tab; place via Layout Builder.
- No settings form ships here; site-wide EBT defaults (colours, breakpoints) are configured by
  ebt_core at `/admin/config/content/ebt-core`.
