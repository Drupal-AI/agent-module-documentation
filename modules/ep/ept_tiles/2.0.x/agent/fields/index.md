<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Tiles fields

Two bundles, both created from `config/install`. The container references the items.

## `ept_tiles` (container paragraph type)

| Field | Type | Notes |
|-------|------|-------|
| `field_ept_title` | text_long | Optional heading rendered above the grid; ept_core `title_wrapper`/`strip_tags` options control the tag and tag-stripping. |
| `field_ept_text` | text_long | Optional intro/body text for the container. |
| `field_ept_settings` | `ept_settings` (ept_core) | The design-settings field; edited with the `ept_settings_tiles` widget (adds Styles radio + Links group on top of ept_core's design options). |
| `field_ept_tiles` | entity_reference_revisions → paragraph | Holds the child `ept_tiles_item` paragraphs (the tiles). |

## `ept_tiles_item` (one tile)

| Field | Type | Notes |
|-------|------|-------|
| `field_ept_tiles_title` | text_long | Tile heading. |
| `field_ept_tiles_text` | text_long | Tile body, WYSIWYG; rendered through a text format (autoescaped/format-filtered). |
| `field_ept_tiles_image` | entity_reference → media | `default:media` handler, target bundles restricted per config; the tile image. |
| `field_ept_tiles_link` | link (cardinality 1) | Tile link; `title` enabled, `link_type` 17 (internal + external). |
| `field_ept_clickable_tile` | boolean | When TRUE and a link exists, the entire tile becomes the link's `<a>` wrapper. |

## Rendering notes

- The container template chooses the column CSS library from `field_ept_settings…styles` and
  ends with `{{ styles|raw }}` — ept_core's generated per-paragraph `<style>` block for the
  design options (spacing, background, container width).
- The item template reads `link_in_a_new_tab` and `nofollow` from the **parent container's**
  `field_ept_settings` (set in `ept_tiles_preprocess_paragraph`) to decide `target`/`rel` on
  the tile anchor. The link href is `content.field_ept_tiles_link.0['#url']`, a Url object that
  Twig autoescapes.
- Clickable-tile mode prints the tile content via
  `content|without('field_ept_tiles_link', 'field_ept_clickable_tile')` inside the anchor;
  otherwise it prints everything except the boolean and shows the link normally.
