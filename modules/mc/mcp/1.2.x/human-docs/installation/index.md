# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Module dependencies (Composer pulls these in):
  - Core **Serialization** (`serialization`).
  - **JSON‑RPC** (`drupal/jsonrpc`, `^2.1`) — provides the HTTP/JSON‑RPC endpoint.
  - **Key** (`drupal/key`, `^1.19`) — holds the shared bearer token, if you use one.

Several built‑in plugins need **optional** extras before they do anything. Add these
only if you want that plugin:

| Plugin | Needs |
|--------|-------|
| content | core **Node** (`node`) |
| jsonapi | core **JSON:API** (`jsonapi`); the `jsonapi_schema` tool additionally needs `drupal/jsonapi_schema` |
| aif | **Drupal AI** (`drupal/ai`) |
| aia | **AI Agents** (`drupal/ai_agents`) plus an AI provider |
| tools | **Tool** (`drupal/tool`) |
| drush | the **Drush** CLI (development only) |

## Install with Composer

From the project root:

```bash
composer require drupal/mcp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed, including JSON‑RPC and Key.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mcp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mcp -y
```

Only the **general** plugin is enabled by default, and the endpoint is locked behind
the **Use MCP server** permission plus request authentication — so enabling the module
does not expose your site. Continue to [Configuration](../configuration/index.md) to
set up authentication and turn on the plugins you need.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| MCP Studio | `mcp_studio` | Lets admins define **no‑code MCP tools** whose output is a static string or a Twig template rendered from the call arguments, managed at `/admin/config/mcp/studio`. Disabled by default. |

Enable it with `drush en mcp_studio -y` if you want to build tools without writing PHP.

## Verify it worked

Go to **Configuration → Web services → MCP Configuration** (`/admin/config/mcp`). You
should see the authentication settings, and the **Plugins** and **Connection** pages
under it. Nothing is reachable by a client yet until you configure authentication and
grant the **Use MCP server** permission — that is the next step.
