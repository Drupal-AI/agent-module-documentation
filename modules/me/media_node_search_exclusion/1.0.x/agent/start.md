<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Node Search Exclusion (media_node_search_exclusion) — agent index

**Propagates Search API 'exclude from search' flags from media entities to the nodes that reference them, via entity hooks and an optional queue.**

- **Version:** 1.0.x — core `^10 || ^11`
- **Depends:** node, media, system, tour, search_api_exclude_entity
- **Config:** `/admin/config/search/media-node-search-exclusion` (`administer site configuration`) — field name, allowed bundles, queue toggle, debug; plus a tour-reset form
- **Endpoints:** `POST /media-node-search-exclusion/statuses` and `POST /media-node-search-exclusion/tour-seen` — both `access content`
- **Services:** settings_manager, media/node exclusion resolvers, custom rule, node_exclusion_updater, queue_manager, tour managers, form/hook handlers
- **Security:** admin config permission-gated. The `statuses` endpoint is `_permission: 'access content'` (broad/effectively anonymous on many sites), **read-only**, and returns media label + bundle + exclusion boolean for requested media IDs (MediaStatusController.php:49-80) — minor exposure of media labels/exclusion state to low-privilege users; no mutation.

See [configure/settings.md](configure/settings.md).
