# Installation

> **Developer tool.** This module performs destructive schema and data changes from
> the command line. Install it in development, back up before running, and remove it
> once your migration is done — it is not something to leave enabled on production.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush** (the module's only interface is a Drush command).
- No other module dependencies, and no third-party PHP libraries.

This module is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/devel_schema_change_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/devel_schema_change_helper -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en devel_schema_change_helper -y
```

## Verify it worked

Confirm the Drush command is registered:

```bash
drush list | grep dsch-rename-field
```

You should see `devel_schema_change_helper:rename-existing-field` (alias
`dsch-rename-field`). See the [main guide](../index.md) for how to run it — and back
up your database first.
