# Installation

## Requirements

- **Drupal 11.2 or newer**, or Drupal 12 (`core_version_requirement:
  ^11.2 || ^12`).
- **PHP 8.3 or newer**.
- Core's **Node** module (`node`) — enabled by default on a standard install.
- The contributed **[Key](https://www.drupal.org/project/key)** module (`key`,
  `^1.18`), used to store the API key securely. Composer pulls it in automatically.
- Cron must be running, since queued webhook requests are sent on cron.

## Install with Composer

From the project root:

```bash
composer require drupal/page_refresh_webhook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and bring in the Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_refresh_webhook -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_refresh_webhook -y
```

This also enables the Key module if it is not already on.

## Upgrading from 1.x

If you are moving from the 1.0.x branch, run the database updates after updating the
code so the stored crawl depth is converted correctly:

```bash
drush updb -y
```

Your existing webhook configuration is otherwise preserved.

## Verify it worked

After configuring an endpoint and content types (see
[Configuration](../configuration/index.md)), save a node of a watched content type,
then run cron and confirm your endpoint receives the POST:

```bash
drush queue:run page_refresh_webhook   # send pending webhook requests now
# or
drush cron
```

Check **Reports → Recent log messages** (`/admin/reports/dblog`, channel
`page_refresh_webhook`) if a request does not arrive.
