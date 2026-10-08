# Installation

## Requirements

- **Drupal 11.3** or newer (`core_version_requirement: ^11.3`).

MCP Core has **no hard module dependencies** and no third‑party Composer or PHP
library requirements. Note it is a **beta** release and is **not covered by Drupal's
security advisory policy** — weigh that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/mcp_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mcp_core -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mcp_core -y
```

## Submodules

- **MCP Core Example** (`mcp_core_example`) — a worked example that demonstrates how
  to expose tools, prompts, and resources with the framework. Enable it to explore
  the framework:

  ```bash
  drush en mcp_core_example -y
  ```

## Verify it worked

MCP Core is a framework, so the meaningful test is that a module built on it works.
Enable the `mcp_core_example` submodule (or a real consumer such as the CTX module)
and confirm its tools/resources are exposed to your MCP client as expected.
