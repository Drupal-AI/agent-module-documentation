# Installation

## Requirements

- **Drupal newer than 10.2** (`core_version_requirement: >10.2`).
- No other module dependencies and no third‑party Composer packages. The `action`
  config entity type it manages is already defined by core's System module.

> **Heads up:** this is a **pre‑1.0** release (`0.2.2`). Test it before relying on
> it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/action -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/action -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en action -y
```

Once enabled, the actions admin page appears at **Configuration → System →
Actions** (`/admin/config/system/actions`) for users with the **Administer
actions** permission. See [Configuration](../configuration/index.md) to create
advanced actions.

There are no submodules.
