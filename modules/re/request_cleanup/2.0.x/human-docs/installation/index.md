# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/request_cleanup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/request_cleanup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en request_cleanup -y
```

That's all that's needed — the middleware is active immediately and begins
stripping the default parameters (`fbclick`, `utm_campaign`, `utm_source`,
`utm_medium`). To change the list, see the `settings.php` override in the
[main guide](../index.md#how-to-configure-the-parameter-list).

## Verify it worked

Load a page with a tracking parameter appended, for example
`/node/1?utm_source=test`, and confirm the site behaves as if you had requested
`/node/1`. Over time, watch your internal page-cache hit-rate improve as fewer
redundant entries are created.
