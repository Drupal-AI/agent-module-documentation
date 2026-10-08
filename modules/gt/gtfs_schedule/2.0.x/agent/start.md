<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GTFS Schedule (gtfs_schedule) — agent index
**Renders transit route timetables fetched from a Drupal GTFS Server for a configured agency.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Routes:** dynamic `/<base_url>/{route_id}` (perm `view gtfs_schedule`); `/admin/gtfs_schedule/settings` + `/debug` (perm `administer gtfs_schedule`); `/gtfs_schedule/regenerate_cache` (POST, custom access)
- **Configure:** `gtfs_schedule.settings`
- **Permissions:** `view gtfs_schedule`, `administer gtfs_schedule`
- **Alters:** request arguments, version, title.

**Security:** display + admin routes are permission-gated. The cache-regenerate endpoint's Bearer-token check runs only `if ($lock)` — with an empty `regenerate_cache_key` the endpoint is reachable unauthenticated (cache invalidation only). See `src/Controller/RegenerateCacheController.php` `access()`. Recommend requiring a non-empty key.
