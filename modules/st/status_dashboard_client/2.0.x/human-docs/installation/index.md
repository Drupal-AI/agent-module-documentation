# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Update** (Update Manager) module enabled — the module's only dependency,
  and Drupal enables it automatically. The report is built from core's update data.
- Separately, a **Status Dashboard** monitoring site to poll this client. That's a
  different module installed on a different site; this client module just exposes
  the endpoint it consumes.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/status_dashboard_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/status_dashboard_client -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en status_dashboard_client -y
```

> **Do this next:** the module ships with **no secret set**. Set a strong secret —
> see [Configuration](../configuration/index.md).

## Permission

The module adds one permission, **Administer status_dashboard_client
configuration**, which controls access to the settings form. Grant it to trusted
roles at **People → Permissions** if someone other than a full administrator needs
to manage the secret.
