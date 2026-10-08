# Permissions

Defined in `rebuild_cache_access.permissions.yml`:

| Permission | Machine name | Gates |
|---|---|---|
| Rebuild Cache | `rebuild cache access` | Showing the toolbar button / Navigation block and access to the rebuild route `/rebuild-cache-access/rebuild-cache`. |

- This is the module's only permission. It is **not** marked `restrict access`, so it is
  safe to assign to editorial/support roles that should clear caches without broader admin
  rights.
- Grant it at **People → Permissions** (`/admin/people/permissions`), row "Rebuild Cache".
- The route also enforces a CSRF token, so the cache is only rebuilt via the generated
  button link, not by pasting the URL.
- Users without the permission never see the toolbar tab or the block.
