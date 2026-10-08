<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cache Register is a developer helper that wraps Drupal's core cache backend with Drawer/Slot/Register objects so you can cache arbitrary data without hand-building or tracking cache IDs.

---

Cache Register provides a single service, `cache_register.manager`, that returns three lightweight object types layered over core's `CacheBackendInterface`: a **Drawer** groups related cache entries under a shared prefix (`implementor_id.drawer_name`) and a shared cache tag (`drawer:<drawer_id>`); a **Slot** is an accessor for one concrete cache entry whose cid is derived as `<drawer_id>:<slot_id>`; and an optional **Register** is a special Slot whose cache entry keeps a list of every Slot ID opened on its Drawer. The Manager derives every cid for you, merges the Drawer's tag onto each Slot's tags, and offers convenience methods (`isCached`, `setCache`, `setCacheStrict`, `getCache`, `getCacheData`, `addCacheTags`, `invalidateCache`, `deleteCache`, and Drawer-wide `invalidate()`). It also keeps a per-request static fallback so a value read in the same request it was written stays consistent even on backends that return empty on immediate re-read. The module ships no UI, routes, permissions, config, or Drush -- it is purely a code-level convenience, and installing or uninstalling it has no effect on site data. It can be pointed at any cache bin (including a permanent cache bin from PCB) by injecting a different backend into a custom Manager service.

---

- Cache arbitrary data (API responses, computed values) without writing cid strings by hand.
- Group all cache entries for a feature under one Drawer so they invalidate together.
- Invalidate every entry in a Drawer at once with `$drawer->invalidate()` (via the `drawer:<id>` tag).
- Read cached data anywhere in the codebase by re-opening the same Slot from the Manager.
- Guard expensive work with `if (!$slot->isCached()) { ... $slot->setCache($data); }`.
- Set a cache entry only when empty using `$slot->setCacheStrict($data)`.
- Store a value with an expiry timestamp and cache tags in one call: `$slot->setCache($data, $expire, $tags)`.
- Append cache tags to an already-set entry with `$slot->addCacheTags($node->getCacheTags())`.
- Retrieve the raw cache item (`$slot->getCache()`) or just the data (`$slot->getCacheData()`).
- Fetch even expired/invalidated data when acceptable via `$slot->getCacheData(TRUE)`.
- Invalidate a single Slot (`$slot->invalidateCache()`) or delete it outright (`$slot->deleteCache()`).
- Track the set of active Slots in a Drawer by opening a Register and calling `$register->getList()`.
- Build composite cache keys from an array of IDs (`openSlot('mod', ['a','b'], [1,2])`) joined with dots.
- Reduce per-user API caching to a few lines when caching batches of user/entity data.
- Keep cache logic out of service classes -- inject the Manager instead of repeating `$this->cache->get/set`.
- Point the helper at a permanent cache bin (e.g. PCB) by injecting that backend into a custom Manager service.
- Use per-request static caching as a safety net for read-after-write within the same request.
- Standardize cache entry naming across a team so cids are predictable and collision-resistant.
- Throw a clear `CacheNotSetError` when adding tags to a Slot whose cache was never set.
- Avoid Register overhead for high-cardinality Drawers by leaving `open_register_if_inactive` at its FALSE default.
- Enforce type-safe Slot IDs (strings/ints or arrays thereof) via built-in `\TypeError` validation.
