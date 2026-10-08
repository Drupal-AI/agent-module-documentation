<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crossword Token adds special file tokens that expose a crossword file's parsed metadata — author, title, dimensions — plus a dynamic image token, so those values can be used in other fields, view modes, metatags, download links and anywhere Drupal tokens are accepted.

---

This submodule of Crossword (requires `crossword` and the contrib `token` module) implements `hook_token_info()` / `hook_tokens()` in `crossword_token.tokens.inc` to register file-scoped tokens resolved via `crossword.data_service`: `[file:crossword_author]`, `[file:crossword_title]`, `[file:crossword_dimensions]`, `[file:crossword_dimension_across]`, `[file:crossword_dimension_down]`. Reached through a crossword field they look like `[node:field_crossword:entity:crossword_title]` or `[media:field_crossword:entity:crossword_dimensions]`. When `crossword_image` is enabled it also registers a dynamic image token `[file:crossword_image:{plugin_id}]`, optionally with an image style `[file:crossword_image:{plugin_id}:{image_style}]`, which generates (via `crossword.image_service::getImageEntity()`) and returns the image URL. These tokens are what the `crossword_download` formatters use to build human-friendly download-link text.

---

- Insert a crossword's title into a metatag, page title or another field via `[file:crossword_title]`.
- Show the puzzle author with `[file:crossword_author]`.
- Show grid dimensions with `[file:crossword_dimensions]` (e.g. `15x15`), or the across/down count separately.
- Reference these from an entity through the field: `[node:field_crossword:entity:crossword_title]`.
- Build a generated crossword image URL with `[file:crossword_image:thumbnail]` (requires crossword_image).
- Apply an image style to the token image with `[file:crossword_image:solution_thumbnail:large]`.
- Provide friendly, tokenized link text for the crossword_download formatters.
- Use crossword metadata anywhere Drupal tokens are supported (Metatag, Pathauto, Views rewrite, etc.).
- Populate a computed/rewritten field with puzzle metadata without custom code.
