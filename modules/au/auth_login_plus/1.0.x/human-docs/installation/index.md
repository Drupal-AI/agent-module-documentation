# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No third-party Composer or PHP library requirements are declared.

Note that the current release is an early **alpha** (1.0.0-alpha1) — test it before
relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/auth_login_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auth_login_plus -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auth_login_plus -y
```

## Migrating from alogin / aloginplus

Authenticator Login Plus is the successor to the older `alogin` / `aloginplus`
modules. If you are coming from one of those, this module is the replacement to move
to.

## Next steps

Grant the relevant permissions and turn 2FA on from the settings form, then have users
enroll — see [Configuration](../configuration/index.md). The module also ships Drush
commands for managing enrollment.
