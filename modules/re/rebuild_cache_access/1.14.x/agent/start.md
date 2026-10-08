# rebuild_cache_access — agent start

Adds a "Rebuild Cache" toolbar button (and a Navigation-module block) that flushes all
caches for any role holding one permission. Depends on core `toolbar`. No config UI.

- The action route is `/rebuild-cache-access/rebuild-cache` (CSRF-protected,
  `_permission: 'rebuild cache access'`); the controller runs `drupal_flush_all_caches()`.
- Toolbar tab is added via `hook_toolbar()` (`ToolbarHandler`); a
  `RebuildCacheAccessNavigationBlock` block plugin provides the same button for the
  Navigation module.
- Grant access / the single permission → [permissions/permissions.md](permissions/permissions.md)
