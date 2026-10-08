# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **User** module (`user`) — the only dependency, always present.
- A working **cron** schedule, since the module detects inactivity and acts on it
  during cron runs.

There are no third‑party Composer or PHP library requirements. Note this release is
**1.0.4**, the project is **minimally maintained** / maintenance‑fixes‑only, and it
is **not covered by Drupal's security advisory policy** — review it before using it
on a sensitive site, especially since it can delete accounts.

## Install with Composer

From the project root:

```bash
composer require drupal/inactive_users -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inactive_users -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inactive_users -y
```

## Verify it worked

Before it can do anything destructive, review [Configuration](../configuration/index.md)
and set a safe policy. To confirm the module works without risking real accounts,
test with a disposable account: set it up to look inactive, run cron, and check that
the warning email is sent (and, only in a test environment, that the block/delete
step behaves as configured after the grace period).
