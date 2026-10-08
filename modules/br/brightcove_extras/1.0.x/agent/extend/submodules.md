<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brightcove Extras — submodules

Base `brightcove_extras` only ships the `BrightcoveEmbedUrl` helper. Enable the submodules you need:

- **brightcove_extras_player** — `EntityPlayerBuilder` + `BrightcoveInPagePlayerFormatter` field formatter render an embed URL as a responsive in-page video.js player (SDC `brightcove-player` component) instead of an iframe.
- **brightcove_extras_ga4** — JS (`brightcove-ga4.js`) pushes GA4 `video_start`/`video_progress`/`video_complete` events to the dataLayer; configure at `brightcove_extras_ga4.settings`.
- **brightcove_extras_admin** — a Brightcove videos View (title/ID search) and a broken-reference report (`BrokenVideoReferences` via entity_usage); configure at `brightcove_extras_admin.settings`. Depends brightcove, views, entity_usage.
- **brightcove_extras_sync** — `VideoDeltaSync` incrementally syncs videos changed since the last run; `SyncCommands` Drush commands; configure at `brightcove_extras_sync.settings`. Depends brightcove.
