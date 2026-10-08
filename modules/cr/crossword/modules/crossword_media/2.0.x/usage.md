<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crossword Media integrates Crossword with core Media by providing a `crossword` media source, so a crossword file becomes a reusable Media entity whose thumbnail is an image generated from the puzzle (via crossword_image), and it extends the crossword pseudofields to media bundles.

---

This submodule of Crossword (requires `crossword`, `crossword_image` and core `media`) defines the `crossword` media source plugin (`Plugin/media/Source/Crossword`, extending core's file media source) so you can create a media type backed by crossword files. Its source field defaults to `txt puz` extensions, and its media-type configuration form adds a "Crossword Image Plugin for Thumbnail" select (default `thumbnail`) whose chosen `crossword_image` plugin generates the media thumbnail through `crossword.image_service::getImageUri()` (config schema `media.source.crossword`). When `crossword_pseudofields` is also enabled, `crossword_media` mirrors that module's pseudofields onto media bundles that have a crossword field via `hook_entity_extra_field_info()` / `hook_media_view_alter()`, so a crossword media entity's title, grid, clues, etc. can be placed individually. This is also the foundation the `crossword_contest` submodule builds its contest media type on.

---

- Turn crossword files into reusable core Media entities.
- Create a "Crossword" media type using the bundled `crossword` media source.
- Use a generated puzzle image (thumbnail, numbered, or solution) as the media thumbnail.
- Choose which `crossword_image` plugin produces the thumbnail per media type.
- Reference one crossword media entity from many nodes.
- Manage crosswords in the Media library like any other media.
- Place crossword pseudofields (title, grid, clues, …) on media displays (with crossword_pseudofields).
- Provide the media-type foundation used by the crossword_contest submodule.
- Restrict uploads on the source field to Across Lite `txt`/`puz` files by default.
