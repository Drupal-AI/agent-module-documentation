<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The five MCP tools, the query service, and OAuth setup

## Install & enable

```bash
drush en ai_content_assistant_mcp -y
```

Pulls in `mcp_server`, `mcp_server_oauth`, and the `simple_oauth_21` OAuth-discovery submodules.
Because `mcp_server` and `mcp/sdk` have no stable release, pin both to tested commits before
enabling (see the parent README's "Admin setup" — it also covers generating the OAuth keypair and
creating an OAuth scope that maps to real Drupal permissions). Every tool requires the
**`generate ai content`** permission on the authenticated user.

## Common shape

All five plugins live in `src/Plugin/Tool/`, extend `Drupal\mcp_server\Plugin\ToolPluginBase`, and
carry a `#[Tool(...)]` attribute (id, label, description, `inputSchema`, and the MCP behavior hints
`readOnly` / `destructive` / `idempotent` / `openWorld`). Each returns
`{success, message, data}`. Authorization is uniform:

```php
public function checkAccess(AccountInterface $account): AccessResultInterface {
  return AccessResult::allowedIfHasPermission($account, 'generate ai content');
}
```

There are **no role-name/name-based checks** anywhere — authorization is by permission only, and
each call executes as the current (OAuth-authenticated) Drupal user.

## Declared scope vs. real effect

| Tool | `readOnly` | `destructive` | `idempotent` | What it actually does |
|---|---|---|---|---|
| `list_content_types` | TRUE | FALSE | TRUE | Read; lists creatable bundles. |
| `describe_content_type` | TRUE | FALSE | TRUE | Read; returns bundle schema. |
| `list_entities` | TRUE | FALSE | TRUE | Read; entity label search. |
| `get_node` | TRUE | FALSE | TRUE | Read; one node's fields+paragraphs. |
| `create_node` | FALSE | FALSE | FALSE | Write; creates **one unpublished draft node**. |

The declared scopes are accurate: the only writing tool is marked `readOnly: FALSE`, and it is
`destructive: FALSE` because it neither deletes nor overwrites existing content — it creates a new
draft (`status = 0`) only.

## The tools

### `list_content_types` — `ListContentTypesTool`

Loads all `node_type` entities and returns `{machine_name, label, description}` for each one the
current user passes `AiContentGenerateAccess::access()` on (permission + per-bundle create-access).
`description` is the bundle's `ai_content_assistant.node_type_description` third-party setting. No
input.

### `describe_content_type` — `DescribeContentTypeTool`

Input `{bundle}`. Loads the node type (404-style message if missing), runs the same access check
(denied → `success: FALSE`), then returns `ContentSchemaDiscovery::getSchema($bundle)`
(`{bundle, label, description, usage_notes}` where `usage_notes` is the full field/paragraph schema
including referenceable entity IDs). The referenceable IDs come from access-checked queries (see
below), so the tool does not disclose entities the user cannot view.

### `list_entities` — `ListEntitiesTool`

Input `{entity_type, bundle?, search?, limit?}`. Delegates to
`EntityQueryService::searchEntities()`. Works for any content entity type the user can view; the
caller names the entity type. This is a read-only, access-checked search — it returns only
`{id, label}` pairs and only for entities the user may view.

### `get_node` — `GetNodeTool`

Input `{nid}`. Delegates to `EntityQueryService::getNodeAsArray()`. Returns `NULL` →
"not found or access denied" when the node is missing or the user cannot view it.

### `create_node` — `CreateNodeTool`

Input `{bundle, title, fields?, paragraphs?}` (`bundle` + `title` required). Builds a
`{title, fields, paragraphs}` payload and calls the parent
`ContentGenerator::generateFromData($payload, $bundle)`, which **re-runs the full access check**
(permission `andIf` per-bundle node create-access) and maps the payload onto node/paragraph/
reference/image values. On `AccessException`/`InvalidArgumentException` it returns `success: FALSE`
with the message; on `MissingTextToImageProviderException` it returns an actionable message; other
throwables are logged and reported generically. Success returns `{nid, uuid, url, edit_url}`.

- **Draft-only:** the created node is always `status = 0`.
- **Idempotency:** before creating, it checks `cache.default` under
  `ai_content_assistant_mcp:create_node:` + `sha256(bundle|uid|title)`; a hit within
  `IDEMPOTENCY_TTL = 600` s replays the original response. This makes the documented
  "do not retry on timeout" guidance safe — a retry with the same bundle+user+title returns the
  original node rather than creating a duplicate. The cache key includes the user id, so one user's
  cached result is never returned to another.
- **Nested paragraphs:** sub-paragraphs go inside the parent's `fields` (one level deep); the tool
  description tells clients not to use a sibling `paragraphs` key on a parent paragraph.

## `Service\EntityQueryService`

Read-only backing service for `list_entities` and `get_node`. Constructor:
`@entity_type.manager`, `@logger.factory`.

- `searchEntities($entity_type, $bundle?, $search?, $limit?)` — builds an entity query with
  `accessCheck(TRUE)`, `range(0, min($limit ?? 50, 100))`, optional bundle equality and label
  `CONTAINS` conditions, sorted by id DESC; then **loads and filters each entity by
  `->access('view')`** before returning `{id, label}`. Unknown entity types are logged and yield
  `[]`.
- `getNodeAsArray($nid)` — loads the node, returns `NULL` unless `->access('view')`; otherwise
  returns `{nid, uuid, type, title, status, url, edit_url, fields, paragraphs}`. Paragraph fields
  are walked one level deep and each referenced paragraph is itself `->access('view')`-checked;
  formatted-text fields collapse to `{value, format}` to round-trip into `create_node`.

Both methods enforce the current user's view access, so the read tools cannot exfiltrate content the
user could not otherwise see.

## `EventSubscriber\McpAuthChallengeSubscriber`

Subscribes to `KernelEvents::RESPONSE` (priority `-10`, after `mcp_server_oauth`'s own subscriber).
When an **anonymous** request to `/_mcp` produced a `403`, it replaces the response with a `401`
JSON-RPC error carrying `WWW-Authenticate: Bearer realm="mcp_server", resource_metadata="<host>/.well-known/oauth-protected-resource"`
(RFC 9728), so discovery-less clients (claude.ai) can start the OAuth dance. It deliberately leaves
**authenticated** 403s as honest 403s (an authorized-but-lacking-access user is not told to
re-authenticate). It grants no access — it only rewrites the error response for anonymous probes.

## Operating notes

- Each MCP call runs as the OAuth-authenticated Drupal user; the same per-bundle create permissions
  and entity access apply whether the user is in the Drupal UI or working through an AI client.
- `simple_oauth` intersects role permissions with token-scope permissions, so a non-admin user needs
  an OAuth scope mapping to real Drupal permissions (parent README, step 4) plus `Access MCP server`,
  `Grant OAuth2 codes`, `Generate AI content`, and per-bundle `Create X content`.
- Logs go to the `ai_content_assistant_mcp` channel (created nodes, replays, failures).
