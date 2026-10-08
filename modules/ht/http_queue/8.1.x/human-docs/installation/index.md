# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Advanced Queue** module (`advancedqueue`) — this provides the queue that
  HTTP Queue processes requests through. Composer installs it automatically as a
  dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/http_queue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Advanced Queue.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_queue -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_queue -y
```

Advanced Queue is enabled automatically as a dependency.

## Verify it worked

Confirm both `http_queue` and `advancedqueue` show as enabled on **Extend**
(`/admin/modules`) or via `drush pm:list --status=enabled`. To confirm it works end
to end, enqueue an outbound request from code, then process the queue (via cron or
Advanced Queue's processor) and check that the request was made — and, if you use
external workers, that job state can be retrieved and updated through the module's
endpoint.
