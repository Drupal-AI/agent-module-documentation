# Model Context Protocol — manual setup guide

**Model Context Protocol** (`mcp`) turns your Drupal site into an **MCP server** — a
single endpoint that LLM clients such as Claude Desktop, Claude Code, and Cursor can
connect to in order to call *tools* and read *resources* from your site. Everything
runs over one JSON‑RPC 2.0 HTTP endpoint (`POST /mcp/post`), built on the
`drupal/jsonrpc` module.

What the assistant can actually do is decided by **MCP plugins**. The module defines
an `mcp` plugin type and ships several built‑in plugins: **general** (site info and
update status), **content** (expose selected content types' nodes as resources plus a
search tool), **jsonapi** (read entities through JSON:API), **aif** and **aia** (surface
Drupal AI function calls and AI agents), **tools** (Tool API tools), and **drush** (run
an allow‑list of Drush commands — off by default, development only). A submodule,
**MCP Studio**, lets admins build no‑code tools whose output is a static string or a
Twig template.

This module does **not** expose anything useful the moment you enable it — access is
deliberately locked down. Reaching the server requires both the **Use MCP server**
permission and a request that authenticates. Authentication is a setting: you can turn
on a **shared bearer token** (a Key entity mapped to one Drupal user) and/or **HTTP
Basic auth**, and OAuth2 or an existing session cookie also work. Only the **general**
plugin is enabled by default; you choose which other plugins to switch on and which
roles may use them, tool by tool.

It requires **Serialization**, **JSON‑RPC** (`jsonrpc`), and the **Key** module, and
runs on PHP 8.1+. Note the project is in the process of merging with the *MCP Server*
module; this one remains stable and usable in the meantime.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and pick optional plugins' dependencies.
2. [Configuration](configuration/index.md) — turn on authentication, enable plugins,
   scope them to roles, tune individual tools, and grab a ready-made client config.

## Where it lives in the admin menu

All admin screens sit under **Configuration → Web services → MCP Configuration**
(`/admin/config/mcp`), gated by the **Administer MCP configuration** permission:

- **`/admin/config/mcp`** — authentication settings.
- **`/admin/config/mcp/plugins`** — the list of plugins (enable them, set roles, and
  open each plugin's per‑tool settings).
- **`/admin/config/mcp/connection`** — copy‑paste client configuration for Claude
  Desktop, Claude Code, and Cursor.

## How to use it

Enable the module, decide how clients will authenticate, enable the plugins you want,
then open the **Connection** page and paste the generated config into your MCP client.
The client connects to `POST /mcp/post`, lists the available tools and resources, and
calls them. Every request is re‑checked against the **Use MCP server** permission,
per‑plugin and per‑tool role rules, and the underlying entity/JSON:API access checks —
so a tool can never return more than the authenticated user is allowed to see.
