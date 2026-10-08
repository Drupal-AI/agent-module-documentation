# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Entity Share** module — specifically its **Entity Share
  Client** (`entity_share_client`) submodule.
- The contributed **Trash** (`trash`) module.

There are no PHP library requirements. Composer will pull in Entity Share and
Trash with the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_share_trash_ignore -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
dependencies such as Entity Share and Trash.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_share_trash_ignore -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_share_trash_ignore -y
```

Make sure Entity Share Client and Trash are enabled too:

```bash
drush en entity_share_client trash -y
```

## Verify it worked

There is nothing to configure — the processor is active as soon as the module is
enabled. To confirm the behaviour, put a previously imported entity in the Trash
bin on the target site, then run an Entity Share sync: the trashed entity should be
skipped rather than causing a 500 error on import.
