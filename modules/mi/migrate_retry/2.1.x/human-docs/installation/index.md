# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Migrate** module (`migrate`) — the only dependency, enabled
  automatically when you turn on this module.
- A working **cron** run, since retried rows are processed by a queue worker
  during cron.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_retry -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_retry -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the required settings.php line

Migrate retry needs Drupal to route its queue through the module's own queue
service. Add this line to your `settings.php` (or `settings.local.php`):

```php
$settings['queue_service_migrate_retry'] = 'queue.migrate_retry';
```

Without this line the retry queue will not be handled correctly, so don't skip
it.

## Enable the module

```bash
drush en migrate_retry -y
```

## Verify it worked

After enabling, open the settings form at the `migrate_retry.settings` route
(see [Configuration](../configuration/index.md)) — you should see the list of
migrations you can opt into the retry system. Confirm cron is running so that
enqueued rows are actually re‑processed.
