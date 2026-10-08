# Redirect Bulk — permissions

From `redirect_bulk.permissions.yml`:

| Permission | Gates | restrict access |
|---|---|---|
| `administer bulk redirects` | Both bulk-create screens (`/add-bulk`, `/add-csv`) — i.e. creating `Redirect` entities in bulk. | not set (no `restrict access: true`) |

The node autocomplete route (`redirect_bulk.node_autocomplete`) uses core `access content`, not this
permission. Its controller runs a parameterized entity query with `accessCheck(TRUE)` and returns only
published nodes the user may view, so it exposes nothing beyond normal content access.

Considerations:
- `administer bulk redirects` is a dedicated admin permission but is NOT flagged
  `restrict access: true`, so it could be granted to a non-superadmin role. A holder can create
  redirects to arbitrary destinations, including external URLs (open redirect). That capability is
  inherent to the Redirect module (its own redirect-admin permission does the same) and is the module's
  intended function; grant it only to trusted roles.
