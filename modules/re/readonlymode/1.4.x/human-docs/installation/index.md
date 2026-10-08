# Installation

## Requirements

Read Only Mode is self-contained. It needs:

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`, and it
  explicitly requires `drupal/core: ^10.1 || ^11`).
- No other modules, third-party Composer packages, PHP extensions, or JavaScript
  libraries. (It attaches to core's Maintenance mode settings form.)

## Install with Composer

From the project root:

```bash
composer require drupal/readonlymode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/readonlymode -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en readonlymode -y
```

Enabling the module does **not** lock the site — read-only mode is off until you
switch it on. It adds a "Read Only Mode" section to the Maintenance mode form and
defines its two permissions.

## Verify it worked

Go to **Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`) and confirm a **Read Only Mode** section
appears on the form. Before you rely on the lock, grant administrators the *Access
forms* permission on **People → Permissions** so they can keep editing during a
freeze. See [Configuration](../configuration/index.md) for the full setup.
