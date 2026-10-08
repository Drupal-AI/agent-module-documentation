<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File MIME rewrites the extension-to-MIME-type map Drupal uses when guessing an uploaded file's MIME type, feeding it entries parsed from a server `mime.types` file and/or administrator-supplied override lines.

---

Drupal derives a file's MIME type from its **extension**, applying a hard-coded map in core's `ExtensionMimeTypeGuesser`; the guess is wrong or absent often enough to matter, and modern formats (`.webp`, `.avif`, `.woff2`, `.geojson`) arrive faster than the map is updated, so they land as `application/octet-stream`. File MIME lets an administrator supply additional or overriding mappings in the standard `mime.types` line format — either by pointing at a readable server file such as `/etc/mime.types` (config key `file`) or by typing lines into a textarea (config key `types`, which is applied after and therefore overrides the file). Mechanically, on Drupal **11.2+** the module registers an event subscriber, `MimeTypeMapLoadedSubscriber`, on core's `MimeTypeMapLoadedEvent`; when core builds its MIME map the subscriber parses each configured line (tokens split on whitespace, `#` starts a comment, first token is the type, remaining tokens are extensions) and calls `$map->addMapping($type, $extension)` for each — so the overrides are injected into the single guesser core already uses, rather than the module supplying its own guesser service. The recorded type is not cosmetic: it becomes the `Content-Type` header on download and decides whether a browser displays or downloads a PDF, whether a font loads, whether a video plays. Two admin-only routes exist under `/admin/config/media/filemime`, both gated by core's `administer site configuration` permission: a settings form (`FileMimeConfigForm`, using `#config_target` to bind the two fields to `filemime.settings`) and an **Apply** confirm form (`FileMimeApplyForm`) that runs a batch over every row in `file_managed`, re-guessing and re-saving the `filemime` value of each locally-stored file so the new map takes effect retroactively. There is no custom permission, no Drush command, and no plugin; config is two strings (`file`, `types`), both empty on install, with a D7 `variable`→config migration provided. Uninstalling restores core's built-in map. One thing to hold onto that runs opposite to the module's purpose: **a MIME type is a claim about a file, not a verified fact** — forcing a type asserts something about bytes nobody inspected, and anything downstream that trusts the recorded type is trusting whoever uploaded the file.

---

- Serve FLAC uploads as `audio/flac` instead of `application/x-flac`.
- Give `.webp` uploads a real `image/webp` type instead of octet-stream.
- Set `image/avif` for AVIF uploads.
- Map `.woff2` to `font/woff2` so webfonts load.
- Map `.geojson` to `application/geo+json`.
- Make PDFs display inline rather than force a download (via the `Content-Type`).
- Correct office-document types (`.docx`, `.xlsx`, `.pptx`).
- Import the server's `/etc/mime.types` as the mapping source.
- Override a single extension's type without touching a file.
- Add a type for a bespoke or in-house extension.
- Fix video playback served from a file field.
- Standardise MIME handling across a site from one config page.
- Re-stamp the MIME type of all previously uploaded files after changing the map (Apply batch).
- Fix wrong types recorded during a content migration.
- Support a newly standardised image or media format core does not yet know.
- Set a type for a data-export or archive extension.
- Migrate Drupal 7 `filemime_file` / `filemime_types` variables into Drupal config.
- Point at a per-environment `mime.types` file so dev and prod share the same rules via config.
- Correct a download-prompt-vs-inline behaviour that users report as "the file doesn't work".
- Export the mapping as normal Drupal config and deploy it across environments.
