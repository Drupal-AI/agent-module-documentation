# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies are declared — this is a self‑contained
  developer/API utility.

> **Version note:** at the time these docs were written the module was a release
> candidate (1.0.0‑rc2).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_schema -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_schema -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_schema -y
```

## After enabling

The module exports your entity and field definitions as JSON for AI features and
tools to consume. There is no settings page — see the [overview](../index.md) for
how it fits into an AI feature, and expose the schema only where appropriate.
