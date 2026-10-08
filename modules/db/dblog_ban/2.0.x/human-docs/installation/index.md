# Installation

## Requirements

- **Drupal 9.4 or higher, 10, or 11** (`core_version_requirement: ^9.4 || ^10 ||
  ^11`).
- **PHP 7.3 or higher**.
- Core's **Ban** module (`ban`) — used to enforce the IP bans.
- Core's **Database Logging** module (`dblog`) — the report the ban links attach
  to.

Both core modules are enabled automatically as dependencies when you turn on this
module. There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dblog_ban -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dblog_ban -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dblog_ban -y
```

Enabling Database logging ban operation also enables core's Ban and Database
Logging modules if they aren't already on.

## Verify it worked

Enabling the module is **not** enough on its own — the Ban/Unban link only appears
after you add its field to the watchdog View. Follow the one-time step in
["How to use it"](../index.md#how-to-use-it): edit the watchdog view, add the
**Ban/Unban link** field (`dblog_ban_ban_unban_link`), and save. Then open
**Reports → Recent log messages** and confirm a Ban or Unban link shows on each
entry.
