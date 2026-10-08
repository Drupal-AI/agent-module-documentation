<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crossword Image turns a Crossword file into an actual image (empty grid thumbnail, numbered thumbnail, or filled solution) using the GD image toolkit, and adds a `crossword_image` plugin type plus a rendered-image field formatter so those generated images can be shown, styled with image styles, and reused as media thumbnails.

---

This submodule of Crossword provides the `crossword.image_service` (`CrosswordImageService`) which, given a crossword file and a `crossword_image` plugin id, generates and caches a managed image file (stored in a `crossword/` subdirectory next to the source file, named `{fid}-{plugin}.{ext}`), tracks it in `file_usage`, and returns its URI or file entity. It defines a `crossword_image` plugin type (manager `crossword.manager.image`, annotation `@CrosswordImage`) with three bundled plugins — `thumbnail` (`CrosswordThumbnail`, empty grid), `numbered_thumbnail` (`CrosswordNumberedThumbnail`, grid with clue numbers using the bundled RobotoMono font), and `solution_thumbnail` (`CrosswordSolutionThumbnail`, filled grid) — all built on `CrosswordThumbnailBase`/`CrosswordImagePluginBase`. The `crossword_image_rendered` field formatter (`CrosswordImageRendered`, extends core `ImageFormatter`) renders the chosen generated image, honoring image styles and link options. Because images are generated once and then reused, an admin-only form at `/admin/config/media/crossword/regenerate` (permission `administer crossword images`) runs a batch to delete and rebuild images after a plugin change. It requires the base `crossword` module and core `image`; it is itself a dependency of `crossword_media`, `crossword_download` and the crossword_token image tokens.

---

- Generate an empty-grid thumbnail image of a puzzle for teasers and listings.
- Generate a numbered-grid thumbnail (clue numbers drawn with the bundled RobotoMono font).
- Generate a filled solution image for downloads or answer pages.
- Show a generated crossword image with the `crossword_image_rendered` formatter and apply an image style.
- Link the rendered image to content, the image file, or the original crossword file.
- Reuse a generated crossword image as a core Media thumbnail (via `crossword_media`).
- Offer a generated solution image as a download link (via `crossword_download`).
- Emit an image URL from a token (via `crossword_token`), optionally with an image style.
- Regenerate all crossword images in a batch after changing or adding a `crossword_image` plugin.
- Regenerate only selected image plugins to limit the resource cost.
- Add a custom image style of a puzzle by writing a new `crossword_image` plugin.
- Keep generated images as managed files tracked in `file_usage` so they are cleaned up correctly.
- Store generated images beside their source file (or in `public://crossword` for public-root files).
- Automatically refresh a generated image when the source crossword file is newer than the cached image.
- Restrict image regeneration to administrators via the `administer crossword images` permission.
