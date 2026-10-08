<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stale 404 Purge issues targeted upstream (Varnish/CDN) cache invalidations for URLs that a reverse proxy previously cached as `404 Not Found` but which now resolve, without flushing the whole cache.
---
When a URL is requested before its content exists — before a node is published, before a path alias is created, or before a redirect is removed — a reverse proxy may cache the 404 and keep serving it after the content appears. This module hooks the specific entity events that make a previously-404 URL resolvable and enqueues a precise purge for exactly those paths. It never flushes the entire cache or does broad cache-tag invalidation (core and Purge's tag queuer already cover tags).

Detection lives in thin `.module` hooks that delegate to two injected services: `AffectedPathResolver` builds the canonical path(s) and alias(es) from the triggering entity, and `PurgeDispatcher` enqueues them through the Purge queue. Triggers covered: node first-publish (`hook_node_insert`), node re-publish unpublished→published (`hook_node_presave` transition detection), path alias insert/update, redirect delete (`hook_entity_delete` on `redirect` entities), and permanent public file insert/update (URI-change only). Purge and Redirect are soft dependencies — without Purge, events are detected and logged but nothing is sent; the Redirect entity type is checked at runtime so no hard dependency is required. Private files and full redirect updates are intentionally out of scope.

Setup: install the Purge module, configure a purger/queue for your reverse proxy, and enable the `stale_404_purge` queuer at `/admin/config/development/performance/purge`.
---
- Purge a Varnish/CDN 404 when a node is first published.
- Purge the canonical path and current alias on node re-publish.
- Purge a new alias path when its aliased node is published.
- Purge both old and new alias paths on alias update.
- Purge a redirect source path when the redirect is deleted.
- Purge a public file URL when a permanent file is created.
- Purge a file URL when its URI changes on update.
- Avoid full-cache flushes by targeting exact paths only.
- Enqueue invalidations through the Purge module's queue.
- Enable/disable the queuer via the Purge admin UI.
- Run detection-only (log) when Purge is absent.
- Skip temporary files and metadata-only file updates.
- Preserve query strings on purged redirect source paths.
- Detect unpublished→published transitions via node original state.
- Keep private-file paths out of scope (access-controlled, not cacheable).
- Integrate with the Redirect module without a hard dependency.
- Track which module queued invalidations as a named Purge queuer.
- Debug-log every dispatched target path set.
- Complement core cache-tag invalidation with URL-level purges.