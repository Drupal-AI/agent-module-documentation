# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no contrib‑module or PHP‑library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/query_auth_params -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/query_auth_params -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en query_auth_params -y
```

## Verify it worked

Log in as a user with the **Administer site configuration** permission and open
**Configuration → Development → Query Auth Params**
(`/admin/config/development/query_auth_params`). You should see the settings form
where you add protected pages. Add one rule, then confirm the behavior: visiting the
plain path should redirect you, while visiting it with the correct `?name=value`
should show the page. See [Configuration](../configuration/index.md) for the
details.
