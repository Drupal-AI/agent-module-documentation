# Permissions

Defined in `jsonrpc.permissions.yml` (neither marked `restrict access: true`).

| Permission | Gates |
|---|---|
| `use jsonrpc services` | Reaching the `/jsonrpc` endpoint at all (route requirement) and the discovery routes in `jsonrpc_discovery`. Does NOT by itself authorize any specific method — each method additionally checks its own `access` permissions. |
| `administer jsonrpc` | The settings form (`/admin/config/system/jsonrpc`) that selects allowed auth providers. |

Important interaction:
- `use jsonrpc services` is the floor for *all* methods. A method with a non-empty `access` array still requires
  those extra permissions. But a method authored with an **empty** `access` array is executable by anyone holding
  just `use jsonrpc services`.
- Decide carefully which roles get `use jsonrpc services`; on a decoupled site it is often granted to an
  API/service account rather than to end users.
