# Configuration

Configuring DKAN MCP Server is mostly about **access**: which tool groups are on,
which roles hold which per‑tool permissions, and how remote clients authenticate.
Because this module intentionally opens your portal to AI clients, get these
settings right before pointing any client at it.

## Enable tool groups

The module's settings form at **`/admin/config/services/dkan-mcp-server`**
(permission **Administer DKAN MCP server**) toggles which **groups** of tools are
active. This is a coarse on/off switch — it does *not* grant access to individual
tools; that's done with permissions below.

## Permissions — the access model

Grant these on **People → Permissions**. The design separates a broad, safe read
tier from tightly gated write tools.

**Read tools** are gated by MCP Server's base permission:

- **`access mcp server`** — lets a client use the read/query tools (get, list,
  search datasets; datastore queries and stats; harvest reads) and read resources.
  For a public open‑data catalog this is the intended, open tier.

**Write tools** each carry their own dedicated permission (all marked
"restrict access"):

| Permission | Tools it unlocks |
|------------|------------------|
| `edit datasets via mcp` | Patch / update dataset metadata |
| `publish datasets via mcp` | Publish / unpublish (archive) datasets |
| `delete datasets via mcp` | Delete datasets (cascading to distributions and datastore tables) |
| `manage metastore items via mcp` | Create / patch / delete arbitrary metastore items |
| `import datastore via mcp` | Trigger datastore imports for resources |
| `drop datastore via mcp` | Drop datastore tables |
| `manage harvests via mcp` | Register, run and deregister harvest plans |

An access subscriber enforces these on both `tools/call` (it **denies**
unauthorized invocations) and `tools/list` (it **hides** tools the client can't
use), so an unauthorized client neither sees nor can invoke a write tool.

## OAuth scopes for remote clients

If you enabled the OAuth stack (`simple_oauth` + `simple_oauth_21`), the module
ships optional config for two scopes and a role:

- **`dkan_mcp_read`** — the read scope.
- **`dkan_mcp_write`** — the write scope, paired with a `dkan_mcp_write` role.

Assign scopes to your OAuth clients to match the permissions they should have. An
unauthorized‑challenge subscriber adds the appropriate Bearer / resource‑metadata
challenge on anonymous 401/403 responses.

## SSRF guard for harvesting

Harvest registration and runs pass their source URIs through a validator before
use, guarding against server‑side request forgery. There's nothing to configure —
it's on by default — but it's worth knowing the protection is there when you allow
harvest management via MCP.

## Access considerations to get right

- The MCP transport endpoint is owned by the **MCP Server** module; make sure only
  intended clients can reach it (network controls, OAuth).
- The read tier is reachable by whoever holds `access mcp server`. If you grant
  that to the anonymous role, the read tools become anonymously reachable — fine
  for public open data, but make it a conscious decision.
- **Never** grant a `* via mcp` write permission, the `dkan_mcp_write` scope, or
  the `dkan_mcp_write` role to anonymous. Reserve write access for authenticated,
  trusted clients.
