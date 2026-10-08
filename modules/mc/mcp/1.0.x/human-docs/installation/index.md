# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- No contrib dependencies for the base module. The **MCP AI** submodule needs the
  [AI](https://www.drupal.org/project/ai) module to be present, since it exposes
  AI function-calls as tools.

## Install with Composer

From the project root:

```bash
composer require drupal/mcp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mcp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mcp -y
```

The base module gives you the JSON-RPC/SSE endpoints and the built-in **General**
plugin.

## Submodules — enable only what you need

MCP ships two optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **MCP Content** | `mcp_content` | Exposes Drupal content as readable MCP resources and adds a content-search tool, so an assistant can retrieve and search your content. |
| **MCP AI** | `mcp_ai` | Surfaces the Drupal **AI** module's function-calls as MCP tools an LLM client can invoke. Requires the AI module. |

For example, to expose content to clients:

```bash
drush en mcp_content -y
```

Both submodules require the base `mcp` module, which is already present once you
have installed it above.

> Each of these submodules adds to what clients can reach through the endpoints
> — `mcp_content` serves node content and `mcp_ai` exposes AI tools. Review the
> [access model](../index.md#a-note-on-the-auth-and-access-model) before enabling
> them on anything public.

## Verify it worked

After enabling, visit **Configuration → Web services → MCP Configuration**
(`/admin/config/mcp`). You should see the settings form with an **Enable HTTP
SSE** checkbox and a section for each discovered plugin. From there, connect your
MCP client to `/mcp/get` or `/mcp/post` and run the `initialize` handshake.
