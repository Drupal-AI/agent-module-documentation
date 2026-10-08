# Installation

## Requirements

User Expire is a small, core‑only module:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **User** module (`user`), enabled — the only dependency (it is always on).
- A working **cron** — all account blocking and warning emails happen on cron runs, so
  cron must be scheduled.

There are no third‑party Composer packages or PHP extensions to install. The optional
Rules action becomes available only if you separately install the contributed **Rules**
module, but Rules is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/user_expire -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/user_expire -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en user_expire -y
```

Or enable **User Expire** from **Extend** (`/admin/modules`).

There are no submodules.

## Next steps

Enabling the module changes nothing until you either set a per‑role inactivity period or
set an expiration date on an account. Continue to
[Configuration](../configuration/index.md), and remember that cron must run for any
account to actually be blocked.
