# Installation

## Requirements

- **Drupal 10.4+ or 11** (`core_version_requirement: ^10.4 || ^11`).
- A working **DKAN** site with the **metastore**, **datastore** and **harvest**
  submodules (`dkan_metastore`, `dkan_datastore`, `dkan_harvest`) enabled — the MCP
  tools operate on these.
- The contributed **MCP Server** module (`mcp_server`), which provides the MCP
  transport and tool framework.
- A bundled read/query submodule, **dkan_query_tools**, pulled in as a dependency.
- **For remote clients (OAuth):** `simple_oauth` (^6) and `simple_oauth_21` — these
  are suggested dependencies; install them if you need the OAuth authentication
  path.
- **Experimental note:** this release currently requires **dev releases** of MCP
  Server and the `mcp/sdk` library, so your Composer stability settings need to
  allow them.

## Install with Composer

From the project root:

```bash
composer require drupal/dkan_mcp_server -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the shared MCP
Server and DKAN dependencies together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dkan_mcp_server -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dkan_mcp_server -y
```

This also enables MCP Server and the bundled `dkan_query_tools` submodule.

## Optional: OAuth for remote clients

If MCP clients will connect remotely, install the OAuth stack and configure it:

```bash
composer require drupal/simple_oauth:^6 drupal/simple_oauth_21 -W
drush en simple_oauth simple_oauth_21 -y
```

The module ships optional config for the `dkan_mcp_read` and `dkan_mcp_write`
OAuth scopes and a `dkan_mcp_write` role — see
[Configuration](../configuration/index.md).

## Verify it worked

Go to **`/admin/config/services/dkan-mcp-server`** and confirm the settings form
loads, showing the tool groups you can enable or disable. Then grant the
appropriate permissions (see [Configuration](../configuration/index.md)) and
connect an MCP client through the MCP Server endpoint to confirm the DKAN read
tools are listed.
