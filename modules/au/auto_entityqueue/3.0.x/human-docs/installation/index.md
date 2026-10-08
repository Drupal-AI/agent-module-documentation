# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- The **Entityqueue** module (`drupal/entityqueue`, `^1.8`) — this is what
  Auto Entityqueue extends, and Composer pulls it in for you.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_entityqueue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the shared
dependencies (including Entityqueue) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_entityqueue -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_entityqueue -y
```

This also enables Entityqueue if it is not already on. Now open any Entityqueue's
edit form and you will find the new **Auto Entityqueue** options — see
[Configuration](../configuration/index.md).
