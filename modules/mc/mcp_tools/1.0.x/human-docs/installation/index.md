# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3+**.
- The **Tool API** module (`tool`), plus core **Database Logging** (`dblog`) and
  **Update Manager** (`update`) — enabled as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/mcp_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mcp_tools -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mcp_tools -y
```

Enabling the base module gives you the access framework and the settings form — but **no
tools are exposed yet**. You choose what to expose by enabling submodules (below).

## Submodules — expose only the domains you want

MCP Tools ships **37 domain submodules**, and the base module deliberately exposes nothing
on its own. Enable only the surfaces you want an assistant to reach. Some of the most
common:

| Submodule | What it exposes |
|-----------|-----------------|
| `mcp_tools_content` | Create / edit / publish nodes, media, bulk operations |
| `mcp_tools_structure` | Content types, fields, taxonomies — site‑building tools |
| `mcp_tools_users` | User and role management |
| `mcp_tools_views` | Views |
| `mcp_tools_layout_builder` | Layout Builder |
| `mcp_tools_config` | Configuration management |
| `mcp_tools_translate` | Read and create translations (paragraphs‑aware) |
| `mcp_tools_stdio` | **STDIO transport** — MCP over Drush (recommended for local dev) |
| `mcp_tools_remote` | **HTTP transport** — a network endpoint at `/_mcp_tools` |
| `mcp_tools_ai` | Exposes the tool library as plain Tool API plugins for ECA / AI Agents |

Enable them individually, for example:

```bash
drush en mcp_tools_content mcp_tools_stdio -y
```

### Pick a transport

- **STDIO (recommended for local):** `drush en mcp_tools_stdio -y`, then generate a
  client config automatically with `drush mcp-tools:client-config > .mcp.json` (it detects
  DDEV/Lando). Add `--scope=read` for a read‑only connection.
- **HTTP (remote / Docker):** `drush en mcp_tools_remote -y`, configure the execution
  user at `/admin/config/services/mcp-tools/remote`, then create an API key with
  `drush mcp-tools:remote-key-create --label="Claude" --scopes=read,write`. The key is
  shown only once. This transport is network‑reachable — configure it most carefully.

## Verify it worked

Visit **Configuration → Web services → MCP Tools**
(`/admin/config/services/mcp-tools`) — the settings form should load. Then open the
**status** page at `/admin/config/services/mcp-tools/status` to confirm which tools are now
exposed by the submodules you enabled. Next, tune the access model in
[Configuration](../configuration/index.md) before connecting anything beyond local
development.
