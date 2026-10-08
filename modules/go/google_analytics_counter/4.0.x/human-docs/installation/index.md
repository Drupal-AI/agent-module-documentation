# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Node** module (`node`) — a dependency, since counts are stored per node.
- Access to the **Google Analytics API** for the property whose figures you want,
  plus API credentials (see [Configuration](../configuration/index.md)).
- In most cases the separate **Google Analytics** module too, since this module
  only *reads* figures — it does not add the tracking snippet that produces them.

## Install with Composer

From the project root:

```bash
composer require drupal/google_analytics_counter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_analytics_counter -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_analytics_counter -y
```

## Verify it worked

Go to **Configuration → System → Google Analytics Counter**
(`/admin/config/system/google-analytics-counter`) and confirm the settings form
loads. Then continue with [Configuration](../configuration/index.md) to connect the
Google API and run the first sync. After a sync (which happens on cron), the
dashboard will show what has been fetched.
