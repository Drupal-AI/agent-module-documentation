<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AmplitudeJS Formatters (amplitudejs_formatters) — agent index

Submodule of **amplitudejs**. Provides seven **field formatter** plugins that render entity-reference
(media) and core file audio fields as themed **AmplitudeJS** players. Package **Media**.
Core `^9.3 || ^10 || ^11`. License GPL-2.0-or-later. Version **1.0.4**.

## Dependencies (`.info.yml`)

`drupal:file`, `drupal:media`, `token:token`, `amplitudejs:amplitudejs`.

## What it provides

- **7 field formatters** (`src/Plugin/Field/FieldFormatter/`), all `field_types = { entity_reference, file }`,
  all extending abstract **`PlayerBase`** (extends core `EntityReferenceFormatterBase`):
  - `amplitudejs_single_song_player` → `SingleSongPlayer`
  - `amplitudejs_multiple_songs` → `MultipleSongs`
  - `amplitudejs_blue_playlist` → `BluePlaylist`
  - `amplitudejs_white_playlist` → `WhitePlaylist`
  - `amplitudejs_flat_black_playlist` → `FlatBlackPlaylist`
  - `amplitudejs_simple_black_playlist` → `SimpleBlackPlaylist`
  - `amplitudejs_visualization_player` → `VisualizationPlayer`
- **7 theme hooks** (`amplitudejs_formatters_theme()`), one Twig template each in `templates/`
  (`single-song-player.html.twig`, etc.), all with variables `has_songs`, `html_id`, `songs`,
  `module_path`.
- **8 asset libraries** (`amplitudejs_formatters.libraries.yml`): a shared `amplitudejs_players_init`
  (`js/amplitudejs-players-init.js`) plus one per-skin CSS library, and an external
  `michaelbromley_visualizations` JS library used only by the Visualization Player.
- **No** routes, permissions, services, config entities, config schema, hooks beyond `hook_theme`,
  or Drush.

## Where things live

- Shared logic (settings, token resolution, render array, drupalSettings): **`PlayerBase`** —
  see [fields/formatters.md](fields/formatters.md).
- Per-skin classes differ only in `getHtmlId()`, `getTheme()`, `isAddJsClickHandlerToPlayer()`,
  `getAttachedLibraries()`, and optionally `processAlbumArtUrl()` / `getVisualizations()`.

## Solution docs

- **All seven formatters, their five token settings, resolution/sanitization, templates, and the init
  JS** → [fields/formatters.md](fields/formatters.md)
