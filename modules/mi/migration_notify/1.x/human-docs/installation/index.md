# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement: ^8||^9||^10||^11||^12`).
- Core's **Migrate** module (`migrate`) — Drupal enables it automatically as a
  dependency when you turn on this module.
- For Slack notifications, an incoming Slack webhook (or token) so the module can
  post to your workspace; for email, a working mail setup on the site.

There are no third-party Composer or PHP library requirements.

> This release line (`1.x`) is a development branch, though the project is
> actively maintained. Test the notifications on a non-critical migration before
> relying on them.

## Install with Composer

From the project root:

```bash
composer require drupal/migration_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migration_notify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migration_notify -y
```

## Verify it worked

After enabling, open the settings form (`migration_notify.settings`) and configure
at least one notification channel and recipient (see
[Configuration](../configuration/index.md)). Then run a small migration and
confirm the notification arrives on the channel you chose. If you set the module to
check on cron, remember to run cron (`drush cron`) so the status check fires.
