<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YouTube Plus (youtube_plus) — agent index

Imports the videos, channels and playlists of one or more YouTube accounts into Drupal content
through the **YouTube Data API v3** (`google/apiclient ^2.9`, the `Google_Client` /
`Google_Service_YouTube` classes). Package `YouTube`. Core `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.x (packaged 1.0.7).

Info.yml declares **no `dependencies:`**, but the shipped content model and code functionally
require core **`node`**, **`taxonomy`** and **`link`** (thumbnail/URL fields are link fields);
Drush integration needs Drush ^10+.

## The moving parts

- **`youtube_plus_channel`** — a small **config entity** (`src/Entity/YoutubePlusChannelEntity.php`,
  `@ConfigEntityType`, `config_prefix = "youtube_plus"`). It stores only `id` (the YouTube channel
  ID), `name` (a label) and `type` (0 = configured by ID, 1 = by custom URL). It is **not** the
  imported content — it is the per-channel import configuration. Managed at
  `/admin/config/services/youtube_plus` (list builder + add/edit/delete forms).
- **Imported content model** (shipped as `config/optional/`): node type **`ytp_video`** plus two
  vocabularies **`ytp_channels`** and **`ytp_playlists`**, with a set of `field_ytp_*` fields.
  Each video → one `ytp_video` node referencing a channel term and (for playlist videos) playlist
  terms. Details → [entities/data-model.md](entities/data-model.md).
- **The API service** — `YouTubePlusService` (service id `youtube_plus.actions`) orchestrates
  import/rollback; `YouTubePlusUtils` wraps the actual YouTube Data API calls and reads the API
  key from config. How it authenticates, which endpoints it hits, the import/rollback flow, the
  controller route and the Drush commands → [api/service.md](api/service.md).
- **The API key** — a single Google API key stored in config object **`youtube_plus.settings`**
  (`api_key`), set via **`SettingsForm`** at
  `/admin/config/services/youtube_plus/settings` (route `youtube_plus.settings`, the `configure`
  link). Config object, schema, defaults → [config/settings.md](config/settings.md).

## Entry points

- **Settings route** `youtube_plus.settings` — `_permission: administer site configuration`.
- **Channel admin** (list/add/edit/delete) + **import/rollback** routes — all under
  `/admin/config/services/youtube_plus`, gated `_permission: administer youtube plus` (the module's
  one permission, `restrict access: true`, in `youtube_plus.permissions.yml`).
- **Import** `YouTubePlusService::importChannel()`, run from the admin list ("Import"/"Rollback"
  row operations, controller `YouTubePlusImport`), from **`drush youtubeplus:run`** /
  **`youtubeplus:rollback`** (`src/Commands/YoutubePlusCommands.php`), and automatically from
  **`hook_cron`** (`youtube_plus.module` re-imports every channel each cron run).

## Doc map

- [config/settings.md](config/settings.md) — settings form, API-key storage, config object + schema.
- [entities/data-model.md](entities/data-model.md) — channel config entity, `ytp_video` node type,
  the two vocabularies and their fields, install/uninstall hooks.
- [api/service.md](api/service.md) — `YouTubePlusService` / `YouTubePlusUtils`, YouTube Data API
  endpoints, the import & rollback flow, controller, Drush commands, cron, permissions and routes.
