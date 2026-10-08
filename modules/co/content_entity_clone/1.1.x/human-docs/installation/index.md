# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third-party Composer libraries and no contrib dependencies. It works with core's
  Entity system. (The **copy layout** field processor is only useful if you use core's
  Layout Builder.)

## Install with Composer

From the project root:

```bash
composer require drupal/content_entity_clone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/content_entity_clone -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_entity_clone -y
```

Enabling the module adds the **Content Entity Clone** admin overview but does not
enable cloning for any bundle yet — no Clone action appears until you turn it on. Head
to [Configuration](../configuration/index.md) to enable cloning per bundle and grant
the permissions.
