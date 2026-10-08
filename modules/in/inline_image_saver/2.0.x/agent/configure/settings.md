<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Inline Image Saver

Route `inline_image_saver.settings` — `/admin/config/content/inline-image-saver/settings` (permission `administer site configuration`). Config object `inline_image_saver.settings`.

## Sections
- **Processable formats** (`processable_formats`) — text formats to process. Empty = all formats.
- **Image validation** (`enable_validation`, default on) with `validation_settings`:
  - `allow_if_downloadable` — skip validation for external images that can be downloaded (needs download enabled).
  - `allow_data_uri` — let base64 `data:` images pass.
  - `check_file_exists` — verify the file exists on disk.
  - `check_file_mime` — verify a valid/supported MIME (needs MIME detection support).
  - `validate_url` / `validate_url_query` — match image URL (and optionally query) to the file entity URL.
- **Image download** (`enable_download`, default on) — download external images to local files on save; `prefer_reuse_files` reuses a file with identical hash (File Hash module improves matching).
- **Replace broken images** (`enable_replace`, default off) — replace still-broken images with `fallback_markup` (admin-XSS-filtered; placeholders `@src`, `@alt`, etc.).
- **Create new revision** (`create_revision`, default on) + `revision_log`.
- **Skip processing on sync** (`skip_on_sync`, default on) — skip `SynchronizableInterface` entities.

## Behavior
Processing runs in `hook_entity_presave()`. Download fetches the `<img src>` via the Guzzle HTTP client (`downloadImage()`), resolves MIME with the tagged `inline_image_mime_guesser` resolvers, saves a temporary file owned by the current user, and rewrites the markup. Changing `enable_validation` clears field-type/typed-data caches via a config-save subscriber.

## Extending MIME detection
Register a service tagged `{ name: inline_image_mime_guesser, priority: N }` implementing the MIME resolver interface; it is collected into `inline_image_saver.mime`.
