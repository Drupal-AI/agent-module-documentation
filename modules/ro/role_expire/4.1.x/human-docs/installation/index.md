# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A working **cron** — expired roles are removed on cron runs, so make sure your
  site's cron is running regularly (roles won't drop off until cron next runs).

There are no other module or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/role_expire -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/role_expire -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_expire -y
```

## Optional submodule — Rules integration

Role Expire ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Role Expire Rules** | `role_expire_rules` | Exposes the "a role expired" event to the contrib **Rules** module, so you can build no-code reactions (send an email, log something, grant another role) when a role expires. Requires the Rules module. |

Enable it only if you use Rules:

```bash
drush en role_expire_rules -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → People → Role Expire**
(`/admin/config/people/role-expire`). You should see the settings form listing
your roles. Continue to [Configuration](../configuration/index.md) to set default
durations and per-user expiry dates.
