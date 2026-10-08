# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) — enabled on most sites by default.
- The **Protect Form Flood Control** module
  (`drupal/protect_form_flood_control` ^1.1) — the parent module that provides the
  Flood manager, the IP whitelist, and blocked‑submission logging. Composer pulls
  it in and Drupal enables it as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/protect_views_flood_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the parent
`protect_form_flood_control` module along with any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/protect_views_flood_control -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en protect_views_flood_control -y
```

This also enables `views` and `protect_form_flood_control` if they aren't already
on. On install, the module registers its Views display extender globally, so a
**Flood control** section appears in the *Advanced* panel of every View display —
protection stays off until you enable it on a display.

## Housekeeping: clear the flood table

Flood records are cleared by cron, so run cron regularly (Drupal cron, `drush
cron`, or a cron module like Ultimate Cron / Simple Cron) to keep the flood table
tidy. Next, see [Configuration](../configuration/index.md) to turn on protection.
