<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Assistant — MCP (ai_content_assistant_mcp) — agent index

Submodule of **ai_content_assistant** that exposes content discovery and draft creation as
**Model Context Protocol tools** for AI clients (Claude, Codex), authenticated per-user over OAuth.
Package `AI`. Core `^11`. License GPL-2.0-or-later. Version 1.0.2 (dir 1.0.x). Parent:
[../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md).

- **Depends on:** `ai_content_assistant`, `mcp_server`, `mcp_server_oauth`,
  `simple_oauth_server_metadata`, `simple_oauth_pkce`, `simple_oauth_client_registration`.
  `mcp_server` + `mcp/sdk` have no stable release — pin both to tested commits (parent README).
- No permissions, config, config schema, or Drush of its own. Plugin **type** is `mcp_server`'s
  `Tool`; this module only provides plugin **instances**.

## What it provides

- **Five Tool plugins** (`src/Plugin/Tool/`, `#[Tool(...)]` attribute), each `checkAccess()` =
  `AccessResult::allowedIfHasPermission($account, 'generate ai content')`:

  | Tool id | Class | Scope declared | Real effect |
  |---|---|---|---|
  | `list_content_types` | `ListContentTypesTool` | `readOnly: TRUE` | Lists bundles the user can create (per-bundle create-access). |
  | `describe_content_type` | `DescribeContentTypeTool` | `readOnly: TRUE` | Returns a bundle's field/paragraph schema + referenceable IDs (access-checked). |
  | `list_entities` | `ListEntitiesTool` | `readOnly: TRUE` | Label/bundle entity search, `accessCheck(TRUE)` + per-entity view. |
  | `get_node` | `GetNodeTool` | `readOnly: TRUE` | Reads one node (view-access-checked). |
  | `create_node` | `CreateNodeTool` | `readOnly: FALSE, destructive: FALSE, idempotent: FALSE` | Creates an **unpublished draft** node. |

- **Services** (`ai_content_assistant_mcp.services.yml`):
  - `ai_content_assistant_mcp.entity_query` → `Service\EntityQueryService` — read-only entity
    search + node read (backs `list_entities`, `get_node`).
  - `ai_content_assistant_mcp.auth_challenge_subscriber` →
    `EventSubscriber\McpAuthChallengeSubscriber` (event_subscriber) — RFC 9728 401 challenge.

## Solution doc

- **Every tool, its declared scope vs. real effect, the query service, and OAuth setup** →
  [plugins/tools.md](plugins/tools.md)

## Key facts (from source)

- Declared MCP scopes match real effects: the four read tools are `readOnly: TRUE`; only
  `create_node` is `readOnly: FALSE`, and it is `destructive: FALSE` because it only writes a draft.
- Authorization is **not** name/role-based — every tool checks the `generate ai content` permission.
  `create_node` additionally re-checks per-bundle create-access inside
  `ContentGenerator::generateFromData()`, so it cannot exceed the acting user's rights.
- All reads run `accessCheck(TRUE)` and a per-entity `->access('view')` filter
  (`EntityQueryService`); tool arguments are entity ids/text (no URL parameters).
- `create_node` deduplicates by `sha256(bundle|uid|title)` for 600 s (`cache.default`) to make
  timeout-retries idempotent.
