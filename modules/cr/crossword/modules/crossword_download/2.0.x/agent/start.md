<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword Download (crossword_download) — agent index

Submodule of **crossword**. Download-link field formatters for the crossword file or a generated
crossword image. Deps: `crossword:crossword`, `crossword:crossword_image`, `crossword:crossword_token`,
contrib `token`, contrib `file_download_link`. Core `^10.2 || ^11`. GPL-2.0-or-later.

## Provides (both extend `file_download_link\...\FileDownloadLink`)

- **`crossword_file_download_link`** ("File Download Link", `CrosswordFileDownloadLink`): download link
  to the **original** crossword file. `getExampleToken()` = `[file:crossword_title]
  ([file:crossword_dimensions])`.
- **`crossword_image_download`** ("Crossword Image (download link)", `CrosswordImageDownload`):
  download link to a **generated image**. `defaultSettings()` = `['crossword_image' =>
  'solution_thumbnail'] + parent`; adds a `crossword_image` plugin select (weight -100).
  `getEntitiesToView()` overrides the parent to swap each crossword file for its generated image
  entity (`crossword.image_service::getImageEntity()`), adding the source file as a cacheable
  dependency. Example token text references `crossword_title`.

## Notes

- No routes/permissions/config/services of its own. All link behavior (link text, token support)
  comes from the parent `file_download_link` formatter. `field_types = {"crossword"}` for both.
