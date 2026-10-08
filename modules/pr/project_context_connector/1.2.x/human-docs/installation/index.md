# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Tool** module (`tool`) and the **MCP Server** module (`mcp_server`) —
  these are dependencies. Composer pulls them in with the command below. The MCP
  tool integration in particular relies on `mcp_server`.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/project_context_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the `tool` and
`mcp_server` dependencies and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/project_context_connector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en project_context_connector -y
```

Drupal enables `tool` and `mcp_server` at the same time if they aren't already on.

## Verify it worked

Run the Drush command to produce a snapshot locally:

```bash
drush pcc:snapshot
```

You should get a JSON snapshot of your site. Before exposing the HTTP endpoints,
go to [Configuration](../configuration/index.md) to set permissions, the signing
secret, rate limiting, and CORS.
