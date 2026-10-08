# Installation

## Requirements

- **Drupal 11.2** (`core_version_requirement: ^11.2`).
- Core's **Field UI** module (`field_ui`) — Drupal will enable it as a dependency.
- No external Composer or JavaScript library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/easy_entity_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easy_entity_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easy_entity_field -y
```

Field UI is enabled automatically as a dependency.

## Verify it worked

Log in as an administrator and go to `/admin/config/development/easy-entity-field`.
You should see the settings form where you choose which entity types get base‑field
management. From there, follow [Configuration](../configuration/index.md).

> **A word of caution before you start:** this module changes entity storage schemas.
> Grant its permissions only to trusted administrators, and note that the module
> **prevents itself from being uninstalled while managed base fields still exist** —
> you must delete those fields first. On a young or high‑stakes site, test the whole
> add/edit/delete cycle in a non‑production environment before relying on it.
