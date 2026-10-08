# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other module dependencies.

> **Beta release.** This is a `1.0.0-beta4` release. It is covered by Drupal's
> security advisory policy, but test it in your setup before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/healthchecker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/healthchecker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en healthchecker -y
```

## Verify it worked

Visit the default endpoint at `/health-check` — you should get back a small JSON
status string. Then, as an administrator, open **Configuration → Development →
Health Checker Settings** (`/admin/config/development/healthchecker`) to change
the path or the timestamp option, as described in
[Configuration](../configuration/index.md).
