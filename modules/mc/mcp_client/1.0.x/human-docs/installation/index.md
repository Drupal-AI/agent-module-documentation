# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.2** or newer.
- These contrib modules, which Composer pulls in as dependencies:
  - **AI** (`ai`) and **AI Agents** (`ai_agents`) — the modules that call the
    discovered tools.
  - **Key** (`key`), version 1.18 or higher — for secure credential storage.
  - **Tool** (`tool`) — the plugin system the discovered MCP tools are exposed
    through.
- The **MCP Client PHP SDK** (`modelcontextprotocol/php-sdk`), installed
  automatically via Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/mcp_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in AI, AI Agents, Key,
Tool, and the MCP SDK, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mcp_client -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mcp_client -y
```

This is currently an **alpha** release, so try it in a non‑production environment
first.

## Verify it worked

Go to **Administration → Structure → MCP Servers**
(`/admin/structure/mcp-server`). If you can reach the page and click **Add MCP
Server**, the module is installed. To confirm end‑to‑end, add a server, enable one of
its tools, and check that the tool appears in the AI API Explorer for your AI agents.
See [Configuration](../configuration/index.md) for the full walkthrough.
