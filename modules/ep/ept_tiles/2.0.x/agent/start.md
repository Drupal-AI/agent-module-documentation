<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Tiles (ept_tiles) — agent index

Ready-made **Tiles** paragraph type — a responsive 1–4 column grid of tiles, each with a
title, WYSIWYG text, a Media image and an optional link — from the **Extra Paragraph Types**
family. Requires `ept_core` and `paragraphs` (and Media, via ept_core). Version **2.0.1**.
Core requirement `^10.1 || ^11 || ^12` (reaches into a major that does not yet exist).

## What it installs

Two paragraph types plus their fields (all shipped as `config/install`):

- **`ept_tiles`** (container) — `field_ept_title` (text_long), `field_ept_text` (text_long),
  `field_ept_settings` (the `ept_settings` design field, widget `ept_settings_tiles`), and
  `field_ept_tiles` — a Paragraph entity-reference-revisions field holding the child tiles.
- **`ept_tiles_item`** (one tile) — `field_ept_tiles_title` (text_long),
  `field_ept_tiles_text` (text_long, WYSIWYG), `field_ept_tiles_image` (entity_reference →
  Media, `default:media` handler), `field_ept_tiles_link` (link, cardinality 1), and
  `field_ept_clickable_tile` (boolean — wraps the whole tile in the link's anchor).

No permissions, no Drush commands, no services beyond a hooks class. Provides a config schema
via ept_core's `ept_settings` field type.

## How it renders

- Widget `EptSettingsTilesWidget` extends ept_core's `EptSettingsDefaultWidget`, adding a
  **Styles** radio (`one_column`/`two_columns`/`three_columns`/`four_columns`, default
  `three_columns`) and a **Links** details group (`link_in_a_new_tab`, `add_nofollow`).
- `templates/paragraph--ept-tiles--default.html.twig` picks the column CSS library from the
  chosen style, prints the title (with ept_core's `title_wrapper`/`strip_tags` options) and the
  child tiles, then emits ept_core's generated `<style>` block via `{{ styles|raw }}`.
- `templates/paragraph--ept-tiles-item--default.html.twig`: if `field_ept_clickable_tile` is
  set and a link exists, the whole tile becomes an `<a>` (honouring `link_in_a_new_tab` /
  `nofollow` from the parent container's settings, read in `hook_preprocess_paragraph`).
- `EptTilesHooks::themeRegistryAlter` registers the item and field templates; the module ships
  per-column CSS in `css/`.

## Trade to state plainly

- *Good case* — a site that wants a competent card grid now, no strong opinion on markup.
- *Poor case* — a design system with definite ideas: markup/fields are the module's, so a
  design the settings don't cover means overriding templates, and a local type is often cheaper.
- **Becomes a dependency of the content** — removing it leaves paragraph entities with no type.

## Map

- `configure/` — enabling, where the type appears, the Styles/Links options, ept_core settings.
- `fields/` — the exact field set of both paragraph types and how they render.
