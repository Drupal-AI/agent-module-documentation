<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Cache Rebuild adds a "Cache rebuild" tab to the canonical page of every content entity type, letting a privileged user invalidate that entity's cache tags on demand.
---
The module dynamically generates a route `entity.<type>.cache_rebuild` at `<canonical>/cache-rebuild` for each content entity type that has a canonical link template (via a route callback), plus a matching local-task deriver so the tab appears next to View/Edit. The controller triggers the page-cache kill switch, loads the entity, collects its cache tags (plus the entity type's list and bundle-list cache tags), fires an `hook_entity_cache_rebuild` alter (so other modules can add tags or change the message), calls `Cache::invalidateTags()`, sets a status message and redirects back to the entity. Access is gated by the single permission `rebuild cache for all content entity types`; there is no settings form and no dependency beyond Drupal core. This is a debugging/operations convenience for editors and site builders chasing stale render caches on a specific node/term/user without a full `drush cr`. Grant the permission only to trusted roles.
---
- Grant "rebuild cache for all content entity types" to trusted roles.
- Click the "Cache rebuild" tab on a node to flush its cache tags.
- Rebuild cache for a taxonomy term page.
- Rebuild cache for a user profile page.
- Rebuild cache for a media entity with a canonical route.
- Rebuild cache for a commerce product or any custom content entity.
- Clear stale render output after an external data change.
- Debug why an entity page shows outdated field values.
- Invalidate cache tags for one entity without running a full `drush cr`.
- Refresh listing/view caches by invalidating the entity type's list cache tags.
- Add extra cache tags to invalidate via `hook_entity_cache_rebuild_alter()`.
- Customise the confirmation message via the alter hook.
- Let editors self-service cache refresh on a single page.
- Verify cache-tag coverage while developing a module.
- Force a fresh page-cache miss on the next view (kill switch).
- Provide a one-click refresh for content that aggregates remote data.
- Restrict the tab to admins by not granting the permission broadly.
- Refresh a node whose referenced entities changed, extending tags via the alter hook.
- Give support staff a quick way to bust a single stale page.
- Confirm an entity's cache tags repopulate correctly after invalidation.
