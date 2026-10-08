# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Simplenews** module at **4.1 or newer** (`drupal/simplenews:^4.1`). Simplenews is a
  hard dependency and must be enabled — Composer and Drupal will pull it in for you. If you do
  not already run Simplenews newsletters, set that up first (create a newsletter, configure
  sending), because Simplenews Scheduler only adds scheduling on top of it.

There are no other third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/simplenews_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies (including
Simplenews) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/simplenews_scheduler -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplenews_scheduler -y
```

Enabling it also enables Simplenews if it is not already on.

## Set the permissions

The module adds two permissions at **People → Permissions** (`/admin/people/permissions`):

- **`send scheduled newsletters`** — lets a user see and use the *Scheduled Newsletter* form on
  a newsletter's send tab. Grant this to your newsletter editors.
- **`overview scheduled newsletters`** — lets a user view the `/node/{node}/editions` overview
  of generated and upcoming editions.

## Make sure cron runs

All scheduled sends are driven by **Drupal cron** — there is no "send now" button in this
module. Run cron often enough for your shortest interval (for a daily newsletter, at least
daily). Verify that your site's cron is configured and firing before you rely on a schedule.

There are no submodules.
