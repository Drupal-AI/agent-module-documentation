# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- **PHP 7.1 or newer** (`php_requirement: 7.1`).

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/permission_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/permission_group -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permission_group -y
```

## Verify it worked

Log in as an administrator and go to **People → Permission groups**
(`/admin/people/permission_groups`). If the (initially empty) collection page
loads, the module is enabled. Next, follow [Configuration](../configuration/index.md)
to create your first group and assign it to a role.
