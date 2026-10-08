# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contributed **Entity Share** module — specifically its **Entity Share
  Client** (`entity_share_client`) submodule, which provides the import pipeline
  this processor plugs into.

There are no PHP library requirements. Composer will pull in Entity Share with the
`-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_share_bypass_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
dependencies such as Entity Share.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_share_bypass_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_share_bypass_fields -y
```

Make sure Entity Share Client is enabled too:

```bash
drush en entity_share_client -y
```

## Verify it worked

Edit an Entity Share import config at
`/admin/config/services/entity_share/import_config` and open the **Processors**
section — a new **Bypass fields** processor should be available to enable. See the
"How to use it" section of the [overview](../index.md) for enabling and configuring
it.
