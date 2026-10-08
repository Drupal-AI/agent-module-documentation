# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Tool API** module — MCP Server turns Tool API plugins into MCP tools, so
  you'll want tools to expose (write your own, or install a set such as the Tool Belt
  module).
- For HTTP transport with authentication: the **Simple OAuth 2.1** module, which
  provides the OAuth 2.1 implementation MCP Server uses. (The module's maintainer
  also maintains Simple OAuth and Simple OAuth 2.1.)
- The official **MCP PHP SDK** (`modelcontextprotocol/php-sdk`), installed
  automatically via Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/mcp_server -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the SDK and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mcp_server -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mcp_server -y
```

This is a **beta** release, so validate it in a non‑production environment first.

## Verify it worked

Go to **Configuration → Web services → MCP Server → Tools**
(`/admin/config/services/mcp-server/tools`). If you can reach the tool‑configuration
UI, the module is installed. For a quick end‑to‑end check of the STDIO transport, run
the MCP Inspector against the Drush command:

```bash
npx @modelcontextprotocol/inspector vendor/bin/drush mcp:server
```

Next, expose a tool and grant access — see [Configuration](../configuration/index.md).
