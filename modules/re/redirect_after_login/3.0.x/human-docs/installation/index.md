# Installation

## Requirements

Redirect After Login is core-only:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).

There are no third-party Composer packages or other contributed modules required.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_after_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect_after_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_after_login -y
```

## Next steps

Nothing is redirected until you configure a per-role destination. Grant the
**Administer redirect_after_login settings** permission to the right role, then
head to [Configuration](../configuration/index.md) to set the destinations.

There are no submodules.
