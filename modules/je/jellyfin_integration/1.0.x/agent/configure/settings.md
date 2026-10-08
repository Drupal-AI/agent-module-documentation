<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Jellyfin Integration

## Settings
Route `jellyfin_integration.settings` → `/admin/config/media/jellyfin` (permission `administer site configuration`). Form `JellyfinSettingsForm` edits `jellyfin_integration.settings`:
- `server_url` (`#type url`) — base URL of the Jellyfin server.
- `api_key` (`#type textfield`) — a Jellyfin API key.

A "Test connection" button validates reachability before values are committed (on failure the original values are restored).

## Browsing routes (all `administer site configuration`)
- `/admin/config/media/jellyfin/library` — list libraries.
- `/admin/config/media/jellyfin/movies` — browse movies.
- `/admin/config/media/jellyfin/series` — browse TV shows.
- `/admin/config/media/jellyfin/library/{library_id}` — items in a library.
- `/admin/config/media/jellyfin/item/{item_id}` — item detail.
