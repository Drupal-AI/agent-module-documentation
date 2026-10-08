# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- Core's **File** module (`file`) — a dependency, enabled automatically.
- **MCP Core** (`mcp_core`) — the module that provides the Model Context Protocol
  server CTX builds on. Composer pulls it in as a dependency.
- No additional PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ctx -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install MCP Core and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ctx -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ctx -y
```

Drupal enables **MCP Core** and **File** at the same time as dependencies.

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep ctx`.
Then connect your AI agent's MCP client to the site's MCP server (provided by MCP
Core) and check that it can list and call the CTX context tools — the agent
should be able to report your site's entity types and fields.
