# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Nothing else — the module has no third‑party Composer or PHP library
  requirements and no contrib dependencies. It builds entirely on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/r4032login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/r4032login -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en r4032login -y
```

The module takes effect immediately with sensible defaults — anonymous users
hitting a 403 are sent to `/user/login` and returned to the original page after
login. There are **no submodules**.

## Grant the admin permission

Configuring the module is gated by the **Administer r4032login** permission. Grant
it to the roles that should manage the settings, for example:

```bash
drush role:perm:add site_admin 'administer r4032login'
```

## Next steps

To adjust the login path, messages, redirect code, or authenticated‑user behavior,
see [Configuration](../configuration/index.md).
