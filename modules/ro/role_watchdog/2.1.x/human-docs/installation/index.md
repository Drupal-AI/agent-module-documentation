# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`) — always present on a standard site — and core's
  **Views** module (`views`), which powers the bundled log/history views. Both are
  declared dependencies and are enabled automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/role_watchdog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/role_watchdog -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_watchdog -y
```

Drupal enables Views (and User) at the same time as dependencies. There are no
submodules.

## After enabling

Role logging starts immediately — no configuration required. Two things are worth
doing next:

1. **Review the notification setting.** The module ships with a placeholder
   notify email (`email@example.com`) that is non‑empty, so it will try to send
   notifications to it. Go to [Configuration](../configuration/index.md) and set a
   real address or clear the field.
2. **Grant the reporting permission.** Give the roles who should read the audit
   trail the *Access Role Watchdog reports* permission (and *Administer Role
   Watchdog* to whoever manages the settings) under **People → Permissions**.
