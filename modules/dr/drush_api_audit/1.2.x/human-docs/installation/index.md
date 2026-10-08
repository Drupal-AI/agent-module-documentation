# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Drush 12 or 13** installed with your Drupal project — the module's commands
  run through Drush.

There are no third-party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_api_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drush_api_audit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_api_audit -y
```

## Verify it worked

After enabling, run:

```bash
drush api:route --help
```

If Drush prints the command's help text, the module is installed and its commands
are registered. See the [main guide](../index.md) for the full command workflow.
