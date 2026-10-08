<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TinyPNG — agent index

Integrates Drupal `image` with the external **TinyPNG/Tinify** compression API (lib
`tinify/tinify`). Compresses either every uploaded image (`on_upload`) or the derivatives of
image styles you flag (`tinypng_compress` third-party setting). Requires a TinyPNG **API key**
(no key → nothing happens). No Drush, no plugin types.

- **Settings form, config keys, permission, per-image-style compression** →
  [configure/settings.md](configure/settings.md)
- **Services & how compression is wired (presave, image-style download override)** →
  [api/services.md](api/services.md)

Key facts:
- Config object: `tinypng.settings` — `api_key` (string, required), `on_upload` (bool),
  `upload_method` (`upload`|`download`), `image_action` (bool).
- Settings form route: `tinypng.settings.form` at `/admin/config/tinypng`; permission
  **`administer tynipng`** (note the misspelling — that is the literal permission id).
- Per-image-style flag: `image.style.<name>.third_party.tinypng.tinypng_compress: true`
  (checkbox appears on the image-style edit form only when `image_action` is on and an
  `api_key` is set).
- Services: `tinypng.compress` (`TinyPng`), `tinypng.image_handler` (`TinyPngImageHandler`).
- Depends on core `image`; external lib `tinify/tinify` and a TinyPNG API key.
