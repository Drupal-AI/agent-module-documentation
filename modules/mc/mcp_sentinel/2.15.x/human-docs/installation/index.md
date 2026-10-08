# Installation

## Requirements

- **Drupal 10.6 or 11.3** (`core_version_requirement: ^10.6 || ^11.3`).
- **PHP 8.3** or newer.
- The stack MCP Sentinel builds its guarantees on, all pulled in by Composer:
  - **Audit Chain** (`audit_chain`) — the tamper‑evident, hash‑chained audit trail.
  - **Key** (`key`) — for the HMAC signing key and other secrets.
  - **Encrypt** (`encrypt`) — for protecting data at rest.
  - **Simple OAuth** (`simple_oauth`) and **Consumers** (`consumers`) — for
    authenticating agent access.
  - **Tool** (`tool`), core **JSON:API** (`jsonapi`), and core **User** and **Node**.

### Recommended companions

- **MCP Server** (`mcp_server`) — exposes MCP Sentinel's Tool plugins to MCP clients
  (via the `mcp_sentinel_server` submodule). **Strongly recommended.**
- **GraphQL Compose** (`graphql_compose`) — enables the `mcp_sentinel_graphql`
  submodule for mutation gating, field redaction, and audit on GraphQL.
- **MCP Tools** (`mcp_tools`) — adds a large set of site‑building tools that MCP
  Sentinel then governs.
- **Charts** (`charts`) — optional; upgrades the dashboard's inline‑SVG charts to
  interactive, exportable ones. The dashboard works without it.

Note this module is **not covered by Drupal's security advisory policy** — review it
carefully before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/mcp_sentinel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Audit Chain, Key,
Encrypt, Simple OAuth, Consumers, Tool, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mcp_sentinel -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mcp_sentinel -y
```

## Submodules — enable what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Approval** | `mcp_sentinel_approval` | A human‑approval gate: queues destructive operations for a person to approve/deny, bound to an HMAC‑sealed action manifest. Also provides the **break‑glass** mechanism (`drush mcp-sentinel:break-glass`) for time‑boxed, single‑use `mcp_admin` elevation. Depends only on `mcp_sentinel`. |
| **GraphQL** | `mcp_sentinel_graphql` | Extends governance to the GraphQL Compose endpoint — mutation gating, field redaction (`[REDACTED]`), DLP scanning, audit, and schema discovery. Requires `graphql` and `graphql_compose`. |
| **Server** | `mcp_sentinel_server` | Registers Sentinel's Tool plugins with **MCP Server** and wires OAuth scopes; provides the setup/provisioning Drush commands. Requires `mcp_server` (production readiness needs `mcp_server:mcp_server_oauth`). |

For example, to add the human‑approval gate:

```bash
drush en mcp_sentinel_approval -y
```

## Verify it worked

Open **Configuration → Web services → MCP Sentinel**
(`/admin/config/services/mcp-sentinel`) and the dashboard at **Reports → MCP
Sentinel** (`/admin/reports/mcp-sentinel`). Then run the built‑in checks:

```bash
drush mcp-sentinel:status        # readiness contract, active policy, audit, lock state
drush mcp-sentinel:verify        # secure-install evidence document
```

A non‑zero exit code from an inspection command means something needs attention. See
[Configuration](../configuration/index.md) for the full setup and the deploy‑time
commands.
