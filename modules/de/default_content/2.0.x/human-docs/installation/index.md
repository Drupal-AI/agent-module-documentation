# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- **Drush**, since export is driven entirely by Drush commands.
- No other module dependencies and no third‑party Composer libraries.

> **Note:** the 2.0.x branch is a **beta** release (`2.0.0-beta1`). Treat it
> accordingly on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/default_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/default_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en default_content -y
```

There is no settings form. Once enabled, the Drush export commands (`dce`,
`dcer`, `dcem`, `dcemr`) are available, and any `content/` directory shipped by
an enabled module is imported automatically. See the
[overview](../index.md#how-to-use-it) for the export/commit/import workflow.

## Submodules

Default Content ships no submodules.
