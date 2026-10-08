# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Libraries API** module (`libraries`) — a dependency used to locate the
  Google API client library.
- The **Google APIs Client Library for PHP** (`google-api-php-client`), placed
  where the Libraries API can find it (for example
  `sites/all/libraries/google-api-php-client`).
- Access to the **Google Analytics Reporting API** for the property you want to
  report on, with API credentials (see [Configuration](../configuration/index.md)).

## Install with Composer

Install the module from the project root:

```bash
composer require drupal/google_analytics_light_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Libraries API
module and update shared dependencies as needed.

### Add the Google API client library

Make the `google-api-php-client` library available to the site — either via
Composer (`composer require google/apiclient`) or by placing the library under your
libraries directory (e.g. `sites/all/libraries/google-api-php-client`) so the
Libraries API can detect it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_analytics_light_report -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_analytics_light_report -y
```

## Verify it worked

After enabling, confirm the two permissions (*View Google Analytics report
(light)* and *Administer Google Analytics Light Report*) appear under **People →
Permissions**, and that the report page at `/analytics-light-report` is reachable.
Once you have connected the Google API (see
[Configuration](../configuration/index.md)), the blocks and page will populate with
your analytics data.
