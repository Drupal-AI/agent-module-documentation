# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Node** (`node`) and **Database Logging** (`dblog`) modules — dblog is
  the watchdog log Grouper analyzes, so it must be enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/grouper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/grouper -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en grouper -y
```

## Optional submodules

Grouper ships optional submodules you can enable individually with `drush en`:

- **Grouper Message Filter** — prevents specified messages from being logged at
  all, reducing database bloat from known, unfixable issues.
- **Grouper MCP Tools** — exposes Grouper's log analysis to AI assistants over MCP,
  so an assistant can answer questions like "what are the main errors on my site?".
  It requires the Tool API and MCP Server modules.

## Verify it worked

Make sure some entries exist in the dblog (watchdog) log, then open Grouper's PHP
Summary view. You should see similar errors consolidated into Issues ranked by
count. To confirm the command line works, run `drush grouper:php-summary --limit=10`
and check that it lists your top PHP errors.
