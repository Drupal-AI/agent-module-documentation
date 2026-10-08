<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Immich Integration provides a comprehensive `ImmichClient` service (and a small admin UI) for talking to a self-hosted Immich photo/video management server's REST API.
---
The `immich_integration.client` service wraps Guzzle to call the Immich API using a configured server URL and API key (sent as the `x-api-key` header), covering server info/health, albums (CRUD + asset add/remove), assets (list/get/update/delete/statistics, thumbnail & original URLs), search, timeline buckets, people/face recognition, shared links, tags, users, libraries, and memories. All methods return `NULL` on failure and log errors. An admin settings form at `/admin/config/media/immich` (permission `administer site configuration`) stores the server URL + API key and offers an AJAX "Test Connection". Additional admin routes list and view albums; every route requires `administer site configuration` and is an `_admin_route`.

Requests use Drupal's default Guzzle `http_client`, so TLS certificate verification is **on**, and the server URL is admin-configured. The API key is saved from the `api_key` textfield to `immich_integration.settings`. The module is a foundation/service layer — it renders galleries only through its own admin album pages; building front-end display is left to integrators.

Typical setup: enable the module, go to `/admin/config/media/immich`, enter the Immich server URL and an API key generated in Immich, test the connection, and save; then inject `immich_integration.client` into custom code.
---
- Connect Drupal to a self-hosted Immich server.
- Test the Immich connection from the settings form.
- List and view Immich albums in the admin UI.
- Fetch albums and their assets programmatically.
- Create, update, and delete Immich albums from code.
- Add or remove assets from an album.
- Retrieve asset thumbnails and original file URLs.
- Search Immich assets by metadata (city, camera, etc.).
- Read Immich server version, config, features, and stats.
- Build a custom photo gallery backed by Immich.
- List people (faces) and update person names.
- Manage Immich tags and tag assets.
- Create or delete Immich shared links.
- Read timeline buckets for date-based browsing.
- Fetch the current Immich user and preferences.
- List libraries and their statistics.
- Retrieve Immich memories.
- Inject `immich_integration.client` into a custom module.
- Store the Immich server URL and API key centrally.
- Log Immich API failures for debugging (methods return NULL).
- Restrict Immich configuration to site administrators.
