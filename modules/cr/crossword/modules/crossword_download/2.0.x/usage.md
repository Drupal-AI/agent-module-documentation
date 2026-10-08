<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crossword Download provides field formatters that turn a crossword field into download links — either a link to download the original puzzle file, or a link to download a generated crossword image (typically the solution) — with tokenized, human-friendly link text.

---

This submodule of Crossword requires `crossword`, `crossword_image`, `crossword_token`, and the contrib `token` and `file_download_link` modules; its formatters extend `file_download_link`'s `FileDownloadLink`. It ships two formatters. `crossword_file_download_link` ("File Download Link", `CrosswordFileDownloadLink`) offers a download link to the original uploaded crossword file, with example link text using crossword tokens like `[file:crossword_title] ([file:crossword_dimensions])`. `crossword_image_download` ("Crossword Image (download link)", `CrosswordImageDownload`) generates a crossword image (default the `solution_thumbnail`) via `crossword.image_service` and offers that image as a download, with a `crossword_image` plugin selector and token-based example text. Both inherit File Download Link's standard options (link text, tokens, etc.), so you control exactly how the download link reads.

---

- Offer a download link to the original crossword puzzle file.
- Offer a download link to a generated solution image of the puzzle.
- Choose which `crossword_image` plugin (thumbnail/numbered/solution) the image download uses.
- Label download links with crossword metadata via tokens (title, dimensions, author).
- Let visitors save a printable solution image after finishing a puzzle.
- Provide "download the puzzle" alongside a playable rendering on the same page.
- Combine with the puzzle and solution formatters across different view modes.
- Reuse File Download Link's link-text and token features for crossword-specific downloads.
