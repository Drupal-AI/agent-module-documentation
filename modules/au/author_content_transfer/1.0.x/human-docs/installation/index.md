# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** (`node`) and **User** (`user`) modules — both are standard on
  a typical Drupal site and are enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/author_content_transfer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/author_content_transfer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en author_content_transfer -y
```

After enabling, grant the `administer author content transfer` permission and
configure the inactivity policy and target user **before** relying on the
cron-driven transfer — see [Configuration](../configuration/index.md).
