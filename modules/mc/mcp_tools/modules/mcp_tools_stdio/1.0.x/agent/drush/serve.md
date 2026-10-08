<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp-tools:serve — STDIO transport

## Enable

`drush en mcp_tools_stdio -y` (needs `mcp_tools` + the `mcp/sdk` Composer package). No config.

## Command

`drush mcp-tools:serve [--server=ID] [--scope=read,write,admin] [--uid=N] [--all-tools] [--gateway]`
(aliases `mcp-tools-server`, `mcp-tools:server`). Defined in `McpToolsStdioCommands::serve()`.

Client config typically launches it, e.g. `.mcp.json`:

```
{ "mcpServers": { "drupal": { "command": "drush",
  "args": ["mcp-tools:serve", "--quiet", "--uid=1", "--scope=read,write"] } } }
```

## Execution flow (source order)

1. Guard: if `Mcp\Server` (mcp/sdk) is missing, print to STDERR and return.
2. **Account**: if `--uid` is numeric and the user loads, `accountSwitcher->switchTo($account)`
   (`$switched = TRUE`); otherwise continue as the current Drush bootstrap user (a warning is
   written if the uid was given but not found).
3. **Server profile**: `serverConfigRepository->getServer($serverId)`; abort if unknown. Abort if
   `allowsTransport($config, 'stdio')` is false. `checkAccess($config, NULL)` must allow.
4. **Scopes**: `--scope` (comma-split) → `accessManager->setScopes(...)`; else the profile's
   `scopes`. These become the connection's effective scopes for every tool.
5. **Flags**: `--all-tools`/profile `include_all_tools`, `--gateway`/profile `gateway_mode`,
   profile `enable_resources`/`enable_prompts`.
6. Build the server with `McpToolsServerFactory::create(...)` and `run(new StdioTransport())`. On
   exit, `accountSwitcher->switchBack()` if it switched.

## Authorization boundary

STDIO has **no authentication of its own** — anyone who can run the Drush command already has shell
access. What still applies: every tool is checked by `McpToolsToolBase::checkAccess()` against the
**resolved user** (`--uid` account or the bootstrap user) — it must hold `mcp_tools use <category>`
— **and** the effective **scope** (read/write/admin), **and** the parent's read-only / config-only
policy. So `--uid=1 --scope=read` yields a superuser identity limited to read tools; a restricted
uid with write scope is bounded by that account's permissions. Prefer a least-privilege `--uid` and
the narrowest `--scope` for the task. There is no request-supplied URL, no outbound call, and no
secret handled here.
