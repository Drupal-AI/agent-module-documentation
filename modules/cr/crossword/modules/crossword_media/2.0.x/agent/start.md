<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword Media (crossword_media) — agent index

Submodule of **crossword**. A core-Media `crossword` source with a generated-image thumbnail, plus
pseudofield support on media. Deps: `crossword:crossword`, `crossword:crossword_image`, core `media`.
Core `^10.2 || ^11`. GPL-2.0-or-later.

## Provides

- **Media source** `crossword` — `Plugin/media/Source/Crossword` (`@MediaSource`, extends core
  `Source\File`), `allowed_field_types = {"crossword"}`. `createSourceField()` sets extensions
  `txt puz`. `defaultConfiguration()` adds `crossword_image_plugin` (default `thumbnail`);
  `buildConfigurationForm()` shows a select of `crossword_image` plugins. `getThumbnail()` →
  `crossword.image_service::getImageUri($file, $plugin)`. Schema `media.source.crossword`.
- **Pseudofield bridge** — when `crossword_pseudofields` is enabled,
  `crossword_media_entity_extra_field_info()` + `crossword_media_media_view_alter()` register/populate
  the same 9 `crossword_*` extra fields on media bundles that carry a `crossword` field (both guarded
  by `moduleHandler->moduleExists('crossword_pseudofields')`).
- **`.install`**: `crossword_media_update_8001` installs `crossword_image` (for the thumbnail plugin
  system).

## Notes

- No routes, permissions, or Drush of its own. It is the media foundation the `crossword_contest`
  submodule extends (`crossword_contest` media type).
