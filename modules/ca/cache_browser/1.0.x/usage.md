<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cache browser is an administrative debugging tool that lists Drupal's cache bins, lets you browse the entries in a bin, inspect an individual cache item by its CID, and clear a bin. It uses a plugin system (cache bin derivers and backend processors) to understand the different cache backends (database, APCu, memory, chained fast, backend chain).

Use it to debug caching behavior, see what a cache entry contains, or verify a bin is populated/cleared during development.
---
Enable with `drush en cache_browser` (core ^10). All screens live under `/admin/reports/cache` (summary), `/admin/reports/cache/{bin}` (browse), `/admin/reports/cache/{bin}/cid/{cid}` (view CID), and `/admin/reports/cache/{bin}/clear` (clear). Every route requires the module's `access cache browser` permission, which is `restrict access: true` and warns that caches may contain private/sensitive data.

Backend processor plugins (`src/Plugin/CacheBrowser/CacheBackendProcessor/*`) know how to enumerate entries per backend; a param converter resolves the `{bin}` to a cache bin collection.
---
- List all cache bins on a site.
- Browse the entries stored in a specific bin.
- Inspect a single cache item by its CID.
- See the size of database-backed cache tables.
- Clear an individual cache bin from the UI.
- Debug why a page is (or isn't) cached.
- Verify a cache entry's contents during development.
- Understand which backend serves each bin.
- Confirm a deployment cleared the right bin.
- Investigate cache growth on a busy site.
- Support APCu, memory, database, and chained backends.
- Restrict cache inspection to trusted admins.
- Diagnose stale-content issues via cached entries.
- Check render-cache entries for a component.
- Audit what sensitive data may sit in caches.
- Explore cache bins added by contrib modules.