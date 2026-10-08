# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Field** module (`field`) — the only dependency.
- **Cron must be enabled and running regularly**, because scraping is processed in
  the background through Drupal's cron/queue system. Without regular cron runs,
  scheduled scrapes will not happen.

There are no extra PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/scrape_to_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scrape_to_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scrape_to_field -y
```

## Verify it worked

Go to **Configuration → Content authoring → Scrape to field Settings**
(`/admin/config/content/web-scraper`) and confirm the global settings form loads.
Then open any node and look for the **Scraper Config** tab — that is where per-field
scraping is set up. See [Configuration](../configuration/index.md) for the details.
