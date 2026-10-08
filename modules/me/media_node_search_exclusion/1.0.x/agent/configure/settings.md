<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Node Search Exclusion — configuration

Settings form: `/admin/config/search/media-node-search-exclusion` (permission `administer site configuration`). `SettingsManager` exposes:

- **Media exclusion field** — the boolean field on media (from `search_api_exclude_entity`) that marks a media item as search-excluded.
- **Allowed media bundles** — restrict propagation to specific media bundles (empty = all).
- **Queue processing** — defer node updates to a Drupal queue (`QueueManager`) instead of running inline in the entity hook, for entities with many references.
- **Debug logging** — when on, resolvers/controllers log detailed decisions to the `media_node_search_exclusion` channel.

Flow: `EntityHooks` fires on media/node save → `NodeMediaExclusionResolver` (+ `DefaultCustomNodeExclusionRule`) decides exclusion → `NodeExclusionUpdater` writes the node's exclusion field (inline or queued). The node/media edit forms attach JS that calls `POST /media-node-search-exclusion/statuses` with `{media_ids:[...]}` and render each item's `excluded` flag. `POST /media-node-search-exclusion/tour-seen` records per-user tour dismissal in `user.data`; the tour-reset form clears it for all users.
