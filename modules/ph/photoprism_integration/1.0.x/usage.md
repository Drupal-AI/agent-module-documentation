<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PhotoPrism Integration is a service-oriented client for the PhotoPrism photo-management platform.

---

The core is a `PhotoPrismClient` service (`src/Service/PhotoPrismClient.php`) wrapping the PhotoPrism REST API — status, config, albums, photos, labels, subjects/people, geo, folders, moments and calendar endpoints, plus thumbnail/preview-token URL helpers. Each call goes through a private `request()` method that prepends the configured server URL, attaches an `Authorization: Bearer <access_token>` header from config and decodes the JSON response, logging and returning NULL on failure. An admin settings form (`/admin/config/media/photoprism`, `administer site configuration`) stores the server URL and access token, and an albums controller (`/admin/config/media/photoprism/albums` and `.../album/{album_uid}`, same permission) lists albums and their photos in the admin UI.

Operator notes: the Guzzle client uses default certificate verification. The server URL and access token are admin-configured in module configuration (`photoprism_integration.settings`), so config export carries the token; restrict who holds `administer site configuration`. All routes are admin-permission-gated. Typical setup: create a PhotoPrism app password/token, enter the server URL and token, then browse albums from the admin pages or call the client service from custom code.

---
- Connect Drupal to a PhotoPrism server
- Store the PhotoPrism server URL and access token
- List PhotoPrism albums in the Drupal admin
- View the photos within a specific album
- Fetch album metadata via the API
- Query photos with filters (count, album, search)
- Build thumbnail URLs using the preview token
- Check PhotoPrism server status/config from Drupal
- Retrieve labels, people/subjects and geo data
- Create, update or delete albums programmatically
- Add or remove photos from an album via the client
- Like/unlike photos through the API
- Access moments and calendar groupings
- Reuse the `photoprism_integration.client` service in custom code
- Integrate an external photo library as a DAM source
- Restrict PhotoPrism admin pages to trusted admins
