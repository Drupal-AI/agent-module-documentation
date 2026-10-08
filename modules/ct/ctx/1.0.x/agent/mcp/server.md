<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CTX MCP server & tool architecture

## Install / enable
```
composer require drupal/ctx --dev
drush en ctx
```
Requires PHP 8.4, core `^11.3`, `drupal/mcp_core`, and the `mcp/sdk` library. Recommended in `settings.php` for local dev so the module never lands in exported config:
```php
$settings['config_exclude_modules'][] = 'ctx';
```
CTX is a local-development tool; the README explicitly warns against enabling it on production or publicly accessible sites.

## The server plugin
`src/Plugin/McpServer/CtxServer.php` — `final readonly class CtxServer implements McpServerInterface` (from `mcp_core`). Declared with the `#[McpServer(...)]` attribute:
- `id: 'ctx'` (also `CtxServer::ID` constant), `version: '1.0.0'`, description "Drupal site context for AI agents."
- `instructions:` a prompt block given to the agent: prefer dedicated `ctx_*` tools over `ctx_php_eval`/`ctx_php_script`; surface tool errors; run `ctx_cache_clear` if a write seems to have no effect; check `ctx_watchdog_list` after a vague write error.

CTX ships no route. mcp_core exposes the server over HTTP at `mcp_core.server` → path `/mcp/{server}` (POST, GET), with requirement `_mcp_core_bearer_token: 'TRUE'`. So agents connect to `/mcp/ctx` with a bearer token issued/configured by MCP Core (admin UI at `/admin/config/services/mcp-core`, `administer site configuration`). CTX itself performs no additional authorization; every tool runs with the executing PHP process's full site privileges.

## Tool plugin architecture
Every tool lives under `src/Plugin/McpTool/<Group>/<Name>Tool.php` and is a `final readonly class … extends McpToolBase` (`Drupal\mcp_core\Tool\McpToolBase`). Each is annotated with `#[McpTool(...)]`:
- `id` (`ctx_*`), `title`, `description`, `server: CtxServer::ID`.
- `inputSchema` — a JSON-Schema object describing arguments (types, enums, `minLength`/`maximum`, defaults). mcp_core validates arguments against this before dispatch.
- optional `outputSchema` — JSON-Schema for structured output (e.g. `ctx_database_query` returns `{rows, rowCount}`; `ctx_content_entity_query` returns `{ids}`).

Execution: `McpToolBase::getHandler()` returns `$this(...)`, so mcp_core invokes the tool's `__invoke()` with the validated named arguments. Tools needing services implement `ContainerInjectionInterface` with a `create()` factory (e.g. `Database\QueryTool` injects `@database`, `ContentEntity\QueryTool` injects the entity type manager). Errors are thrown as `Mcp\Exception\ToolCallException` with a human-readable message, which mcp_core relays to the agent.

See [tools.md](tools.md) for the full catalog. Plugin-type discovery used by `ctx_plugin_*` is documented in [../api/plugin-type-registry.md](../api/plugin-type-registry.md).
