<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Jellyfin Integration connects a Drupal site to a Jellyfin media server through a reusable client service and an admin-only browsing UI.

---

`JellyfinClient` (`jellyfin_integration.client`, injected with `http_client`, `config.factory`, `logger.factory`) wraps the Jellyfin REST API: system info, users, virtual folders / media folders, items with filters, latest/resume/similar items, search hints, genres, studios, artists, persons, playback info, and image/poster/backdrop/stream URL builders. Every authenticated request adds an `Authorization: MediaBrowser Token="<api_key>"` header. The server URL and API key are stored in `jellyfin_integration.settings` and edited at `/admin/config/media/jellyfin` via `JellyfinSettingsForm` (which offers a test-connection button). `JellyfinLibraryController` renders admin pages to browse libraries, movies, TV shows, per-library items, and item details with artwork.

All six routes require `administer site configuration`, so the browsing UI and settings are admin-only; there are no anonymous or mutating public endpoints. The server URL comes from admin config. TLS verification is left at Guzzle defaults (enabled); no `verify => false`.

---
- Configure the Jellyfin server URL and API key.
- Test connectivity to the Jellyfin server from the settings form.
- Browse all Jellyfin libraries from the Drupal admin.
- Browse movies available on the Jellyfin server.
- Browse TV shows / series.
- List items inside a specific library.
- View an item's detail page with poster and backdrop.
- Fetch system info from the Jellyfin server programmatically.
- List Jellyfin users via the client service.
- Query items with custom filters (type, parent, limits).
- Retrieve "latest", "resume", and "similar" item lists.
- Perform search-hint lookups against the media server.
- List genres, studios, artists, or persons.
- Build a poster or backdrop image URL for an item.
- Build a direct stream URL for a video item.
- Get playback info for an item.
- Trigger a Jellyfin library refresh via the client.
- Reuse `jellyfin_integration.client` in custom media code.
- Log Jellyfin API errors to the `jellyfin_integration` channel.
- Gate the whole feature behind `administer site configuration`.
