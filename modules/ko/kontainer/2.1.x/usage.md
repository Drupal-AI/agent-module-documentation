<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Kontainer integrates the Kontainer digital asset management platform with Drupal's media system, importing assets (or referencing them via Kontainer's CDN) and reporting file usage back to Kontainer.

---

The module ships five media types (kontainer_image/video/document/file and a CDN type) and a JavaScript-driven import flow. When an editor picks an asset, the browser POSTs the asset JSON to `/kontainer/create-media` (CSRF-token protected, JSON format); `KontainerService::createEntities()` then either downloads the file server-side into `public://Kontainer` and creates a Drupal file + media entity, or — for the CDN source — stores the remote URL on a CDN media type. A `checkAccess()` guard requires the acting user to hold the `create <media_type> media` permission before anything is written. Downloaded file names are sanitised (a dangerous extension gets `.txt` appended unless insecure uploads are explicitly allowed). CDN image conversions are configurable entities (`/admin/structure/cdn-image-conversion`) that append a `?d=<templateId>` transform to CDN URLs.

Kontainer calls back into Drupal at `/kontainer/api/file-usages` to read where assets are used; this route is protected by a dedicated `kontainer_auth` authentication provider that compares a Base64 `Bearer id:secret` header against the configured integration id/secret using `hash_equals()`, and returns a session with a synthetic `kontainer_auth_role`. A single file's usage can be queried via the `kontainerFileId` query or body parameter. TLS verification is left at Guzzle's secure default (no `verify => false`).

Set-up: configure the Kontainer URL, media source and (for CDN) the CDN asset host at `/admin/config/media/kontainer`, add the integration id/secret, register the `.../kontainer/api/file-usages` URL in Kontainer, and enable the Kontainer entity-usage tracking plugin.

---

- Connect Drupal to a Kontainer account by setting the Kontainer URL and integration credentials.
- Choose whether imported assets map to a CDN media type or a local (downloaded) media type.
- Import an image/video/document/file from Kontainer into Drupal media via the Media Library.
- Reference assets by Kontainer CDN URL instead of downloading them.
- Configure the CDN asset host so CDN media can be saved.
- Define CDN image conversions (`/admin/structure/cdn-image-conversion`) with a template id and format.
- Apply a crop/resize conversion to a CDN image via the `?d=<templateId>` transform.
- Set a fallback image conversion for CDN fields that specify none.
- Report where each Kontainer asset is used back to Kontainer via `/kontainer/api/file-usages`.
- Track asset usage on nodes (and nested paragraphs) using the Entity Usage plugin.
- Query usage for a single file id via the `kontainerFileId` parameter (query string or request body).
- Restrict who can change settings with the `administer kontainer settings` permission.
- Restrict CDN conversion management with `administer cdn_image_conversion`.
- Bulk-delete Kontainer media types via `/kontainer/delete-media-types`.
- Authenticate Kontainer's callback with a Bearer id:secret token verified by `hash_equals()`.
- Toggle the media source between CDN and non-CDN without losing existing media.
- Run the module on Drupal 10.3+/11 with Entity Usage 2.2 or 5.x.
- Log import/download failures (asset URL + HTTP status line) to the `kontainer` logger channel.
- Export the created media-type configuration with `drush cex` after setup.
