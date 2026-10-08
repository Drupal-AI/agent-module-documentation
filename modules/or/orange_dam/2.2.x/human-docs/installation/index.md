# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core **Node** (`node`) and **Migrate** (`migrate`).
- **Migrate Plus** (`migrate_plus`) — pulled in via Composer.
- **Pathauto** (`pathauto`).
- Access to an **Orange DAM instance** and API credentials from Orange Logic.

There are no extra PHP library requirements, but remember this module is a
foundation: a working integration also needs the custom Drupal data model and
migrations you build on top of it.

## Install with Composer

From the project root:

```bash
composer require drupal/orange_dam -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus,
Pathauto, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/orange_dam -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en orange_dam -y
```

Enabling Orange DAM also enables its Node, Migrate, Migrate Plus, and Pathauto
dependencies if they are not already on.

## Verify it worked

Confirm the module and its dependencies are enabled (`drush pml | grep orange_dam`).
The next step is to connect it to your Orange DAM instance and build your migrations
— see [Configuration](../configuration/index.md), which also covers how to store the
API credentials safely.
