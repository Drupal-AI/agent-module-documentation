<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword Image (crossword_image) — agent index

Submodule of **crossword**. Generates images from crossword files with GD and adds a rendered-image
formatter. Deps: `crossword:crossword`, core `image`. Core `^10.2 || ^11`. GPL-2.0-or-later.

## Provides

- **Service** `crossword.image_service` = `CrosswordImageService` (args: `@file_system`,
  `@file.usage`, `@crossword.manager.image`, `@entity_type.manager`, `@database`,
  `@crossword.data_service`). → [services/image-service.md](services/image-service.md)
- **Plugin type** `crossword_image` — manager `crossword.manager.image` (`CrosswordImageManager`,
  dir `Plugin/crossword/crossword_image`, annotation `@CrosswordImage`, interface
  `CrosswordImagePluginInterface`, base `CrosswordImagePluginBase`). Bundled plugins:
  `thumbnail` (`CrosswordThumbnail`), `numbered_thumbnail` (`CrosswordNumberedThumbnail`, uses
  `fonts/RobotoMono-Regular.ttf`), `solution_thumbnail` (`CrosswordSolutionThumbnail`); shared base
  `CrosswordThumbnailBase`.
- **Formatter** `crossword_image_rendered` ("Crossword Image", `CrosswordImageRendered` extends core
  `ImageFormatter`) — setting `crossword_image` (which plugin) + core image-style/link settings.
  Schema `field.formatter.settings.crossword_image_rendered`.
- **Route/form** `crossword_image.regenerate` → `/admin/config/media/crossword/regenerate`,
  `_permission: 'administer crossword images'`, form `CrosswordImageRegenerateForm`. Menu link under
  *Configuration → Media*.
- **Permission** `administer crossword images`.

## Notes

- Generated images are managed `file` entities saved as `{source-fid}-{plugin}.{ext}` in a
  `crossword/` subdir of the source file's directory (or `public://crossword`), registered in
  `file_usage` under module `crossword`, and regenerated when the source file is newer.
- Regeneration is a batch over all `file_usage` rows for module `crossword`; documented as
  "terribly brute force", experimental, dev-oriented. See [services/image-service.md](services/image-service.md).
