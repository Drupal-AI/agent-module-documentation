<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ebt_video — block type, fields & displays

Everything the module installs is default config in `config/install/`. There is no settings form
(`configure: null`); design defaults come from EBT Core's own config.

## Install / enable

`drush en ebt_video` (or via Composer: `composer require drupal/ebt_video`). On install,
`ebt_video_requirements($phase)` in `ebt_video.install` runs at the `install` phase only and
returns a `RequirementSeverity::Error` (BC-wrapped `REQUIREMENT_ERROR`) unless a **`remote_video`**
media type already exists — so the core Media module's *Remote video* type must be present first
(create it at `/admin/structure/media`). No `hook_update_N`, no schema changes.

## Block content type

- `block_content.type.ebt_video` — id `ebt_video`, label *EBT Video*, `revision: 0`.

## Fields (all on bundle `ebt_video`)

- **`field_ebt_video`** — the video. Storage `field.storage.block_content.field_ebt_video`:
  `type: entity_reference`, `target_type: media`, cardinality 1. Field instance limits
  `handler_settings.target_bundles` to `remote_video` and `video`; `auto_create: false`,
  `auto_create_bundle: remote_video`. Not required.
- **`body`** — `text_with_summary`, `display_summary: false`.
- **`field_ebt_settings`** — `ebt_settings` field type (defined by `ebt_core`); carries the EBT
  design options (margin/padding/border/background/breakpoints).

## Form display (`core.entity_form_display.block_content.ebt_video.default`)

Uses `field_group` to build a horizontal **Tabs** group with two tabs:

- **Content** (`group_content`, open): `info`, `body` (`text_textarea_with_summary`),
  `field_ebt_video` (**`media_library_widget`** — editors pick/upload a Media entity, never type a
  raw URL into this block).
- **Settings** (`group_settings`, closed): `field_ebt_settings` (widget **`ebt_settings_video`**).

Module deps declared by this display: `ebt_video`, `field_group`, `media_library`, `text`.

## View display (`core.entity_view_display.block_content.ebt_video.default`)

- `field_ebt_video` → **`entity_reference_entity_view`** formatter, `view_mode: ebt_video`,
  `link: false` (renders the referenced media entity in the `ebt_video` view mode).
- `field_ebt_settings` → `ebt_settings_default` formatter (from `ebt_core`).
- `body` → `text_default`.

## Media view mode + per-bundle media displays

- `core.entity_view_mode.media.ebt_video` — a media view mode *EBT Video*.
- See [../display/rendering.md](../display/rendering.md) for the `video` and `remote_video`
  view displays that actually output the player/lightbox.
