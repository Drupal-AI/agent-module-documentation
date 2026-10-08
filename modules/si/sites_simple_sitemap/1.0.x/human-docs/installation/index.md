# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Simple XML Sitemap** (`simple_sitemap`) enabled — this module extends it, so
  it is a hard dependency.
- The **Sites** module in place for Drupal 10/11. As the project notes, Sites
  Simple Sitemap can only be used once Sites is available for your Drupal version.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sites_simple_sitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Simple XML
Sitemap and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sites_simple_sitemap -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sites_simple_sitemap -y
```

Drupal enables Simple XML Sitemap automatically as a dependency if it is not
already on.

## Verify it worked

With Simple XML Sitemap configured to include some content, regenerate the
sitemaps (via cron or Simple XML Sitemap's own generate action) and confirm each
site serves its own sitemap with its own URLs.
