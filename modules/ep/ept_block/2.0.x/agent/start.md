<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Block (ept_block) — agent index

Paragraphs bundle **`ept_block`** whose main field embeds an **existing Drupal block plugin** into
a paragraph, built on the contrib **`block_field`** module, plus the EPT family's shared `ept_core`
per-paragraph design settings. Version **2.0.0**. Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later.

## What it actually is
- **No PHP of its own.** The module is a Paragraphs type + field/display config. All block behaviour
  comes from `block_field`; all design behaviour from `ept_core`.
- **Hard dependencies:** `block_field:block_field`, `ept_core:ept_core`, `paragraphs:paragraphs`.
- **No permissions, no routes, no `configure` link, no Drush, no config schema of its own.**

## Fields on the `ept_block` bundle
- **`field_ept_block_block`** — type `block_field` (contrib). The block reference. **Required**,
  cardinality 1. Widget `block_field_default` with `configuration_form: full` (editor can configure
  the chosen block's own settings inline). Formatter `block_field`. Field selection = `categories`
  with an allowlist that in practice spans every block category on the site.
- **`field_ept_title`** — `text_long`, optional; rendered as an `<h2>` in the template.
- **`field_ept_text`** — `text_long`, optional; rendered before the block.
- **`field_ept_settings`** — `ept_settings` (from `ept_core`); the shared Design tab.

## How the block is chosen and rendered (the real mechanism)
- The editor selects a block plugin by id in the widget; `block_field` stores `plugin_id` +
  per-instance `configuration`.
- At view time `block_field`'s formatter (`BlockFieldFormatter::viewElements`) instantiates the
  block, injects runtime contexts, then calls **`$block->access($currentUser, TRUE)`** and
  **skips rendering when access is not allowed**, merging the access result's cacheability into the
  element. So an access-restricted block auto-hides for viewers who lack access — the render path
  does check block access (this is `block_field`'s behaviour, not `ept_block`'s). See
  `agent/paragraphs/index.md`.
- The block is rendered **at display time**, so editing the referenced block updates every page that
  references it.

## Shared EPT design settings (`ept_core`)
- `field_ept_settings` feeds `ept_core`'s `GenerateCSS::generateFromSettings()`, which builds a
  **scoped inline `<style>`** (class `.paragraph-id-<id>`) for margins/padding/borders, background
  color/image, edge-to-edge and container width. The template ends with `{{ styles|raw }}`.
- Background video/image runtime options are passed to JS via `ept_core`.

## Template
- `templates/paragraph--ept-block--default.html.twig`: wrapper div with EPT classes,
  `.bg-inner` + `.ept-container`, optional `<h2>` title, then the remaining content
  (`field_ept_block_block`, `field_ept_text`), then `{{ styles|raw }}`.

## Relation to the EPT / EBT families
- Same shape as other EPT paragraph types; the EBT family (`ebt_*`) is the block-plugin equivalent.
- Three shapes of "embed a block": this (**paragraph flow**), `ck5_block_embed` /
  `ckeditor_insert_blocks` (**body text**), and core block layout (**a region**).
