# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Entity Usage** module (`entity_usage`) enabled — this is the only
  dependency, and everything this module does builds on Entity Usage's tracking.
- A **working cron** (queue mode is drained on cron) and, ideally, a scheduler
  such as crontab to run the cleanup command periodically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage_queue_tracking -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_usage_queue_tracking -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage_queue_tracking -y
```

Enabling the module alone does **not** switch tracking into queue mode — that is
opt-in.

## Turn on queue mode

Queue mode is deliberately not exposed in the UI. Add this line to your
`settings.php`:

```php
$config['entity_usage_queue_tracking.settings']['queue_tracking'] = TRUE;
```

Then rebuild caches (`drush cr`). From now on, reference tracking is deferred to
the `entity_usage_tracker` queue and processed when cron runs. Only enable this
if you are sure no automated process depends on instantly-accurate usage data.

## Schedule the cleanup command

Run this periodically (a crontab entry or your site's scheduler) to prune
duplicate and stale usage rows:

```bash
drush clean_usage_table
```

Add `--pointing` to also remove self-referencing rows:

```bash
drush clean_usage_table --pointing
```

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep
entity_usage_queue_tracking`. After enabling queue mode, save a content item
that references others, then check that a new item appears on the
`entity_usage_tracker` queue and is cleared on the next cron run — usage records
update after cron rather than immediately at save time.
