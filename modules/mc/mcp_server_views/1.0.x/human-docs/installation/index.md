# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`) — enabled automatically as a dependency.
- The **MCP Server** module (`mcp_server`), version **2.x**, which actually serves the
  resources to MCP clients.
- **MCP Server UI** — the admin forms that let you enable the resource and
  resource‑template providers. Without it you cannot turn the providers on, and MCP
  Resource displays stay invisible to agents.

There are no third‑party Composer or PHP library requirements beyond those modules.

## Install with Composer

From the project root:

```bash
composer require drupal/mcp_server_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in MCP Server and any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mcp_server_views -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mcp_server_views -y
```

Enable the MCP Server UI at the same time if it is not already on, so you can reach the
provider settings:

```bash
drush en mcp_server_ui -y
```

## Verify it worked

Go to **Structure → Views**, edit any view, and add a display. The **MCP Resource**
display type should now appear in the list of display types you can add. That confirms
the module is active. The next step — adding the display, aliasing fields and enabling the
providers — is covered in [Configuration](../configuration/index.md).
