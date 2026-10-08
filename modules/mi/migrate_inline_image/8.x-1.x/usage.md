<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrates the inline images embedded in rich-text/body fields, saving them as managed files and fixing the markup.

---

Provides the `save_inline_image` migrate process plugin (`src/Plugin/migrate/process/SaveInlineImage.php`, `@MigrateProcessPlugin`). In `transform()` it parses the field HTML with Symfony `DomCrawler` (base URI `http://localhost`), iterates every `<img>`, and for each computes the image path relative to a configured `image_file_source_path` (a source row property), then `saveImage()` reads the bytes with `file_get_contents()` and writes them via `FileRepository::writeData()` into a per-run `bat-<uuid>` subfolder under the configured `image_file_save_destination`. It then rewrites the `<img src>` to the new managed file URL and adds `data-entity-type=file` / `data-entity-uuid`, returning the updated body HTML. The plugin requires `image_file_source_path` and `image_file_save_destination` config keys (throws `MigrateException` otherwise) and depends on `migrate` + `migrate_file`. This is a CLI/admin migration-time plugin, not a web route: `file_get_contents()` on a source-derived path runs only when a developer executes the migration. Image URLs come from the source HTML being migrated.

---

- Import legacy body-field HTML while pulling its inline images into Drupal files.
- Rewrite old `<img src>` URLs to managed-file URLs during migration.
- Add `data-entity-type`/`data-entity-uuid` so CKEditor recognises migrated images.
- Keep inline images working after content is migrated from another CMS.
- Save each inline image as a managed file entity.
- Group a migration run's images under a unique `bat-<uuid>` folder.
- Configure the source path and destination scheme per migration.
- Chain after HTML-producing process steps in a migration pipeline.
- Handle multiple `<img>` tags per field value.
- Preserve the rest of the body markup while replacing image sources.
- Work with rich-text/formatted-text destination fields.
- Use alongside `migrate_file` for file handling.
- Target Drupal 10/11 migrations.
- Avoid broken image links after a content import.
- Automate what would otherwise be manual re-uploading of inline images.
- Fail fast (MigrateException) when required config keys are missing.
