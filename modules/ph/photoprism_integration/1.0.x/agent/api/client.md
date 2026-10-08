<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PhotoPrismClient service

Service id `photoprism_integration.client` (`src/Service/PhotoPrismClient.php`).

- `request($method,$endpoint,$options)` prepends config `server_url`, adds `Authorization: Bearer <access_token>` (+ JSON headers), calls Guzzle, returns decoded JSON or NULL (logs on error).
- Methods cover status/config, albums (CRUD + photos), photos (search/get/update/batch-delete/like), labels, subjects/people, geo, folders, moments, calendar, and thumbnail/preview-token URLs.
- **TLS:** default Guzzle verification.
- **Config:** `server_url` and `access_token` live in `photoprism_integration.settings` (admin settings form); treat config exports as sensitive.
