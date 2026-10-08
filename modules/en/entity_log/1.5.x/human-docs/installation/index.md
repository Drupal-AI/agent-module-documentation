# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Dynamic Entity Reference** module (`dynamic_entity_reference`, version
  `1.11` or newer). Entity Log uses it to store a reference back to whichever
  entity changed, whatever its type. Composer pulls it in automatically.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Dynamic Entity
Reference and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_log -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_log -y
```

Drupal enables Dynamic Entity Reference as a dependency at the same time.

## Next step

Nothing is logged until you configure at least one log target and choose some
fields to watch — continue to [Configuration](../configuration/index.md).
