# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Simple Sitemap** (`simple_sitemap`) — the base module Super Sitemap extends.
- **Ultimate Cron** (`ultimate_cron`) — used to control the sitemap build process.
- Core **Views** (`views`).

Composer pulls in the contributed dependencies (Simple Sitemap and Ultimate Cron)
for you when you require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/super_sitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Simple Sitemap and Ultimate Cron.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/super_sitemap -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en super_sitemap -y
```

Drush enables the required dependencies (Simple Sitemap, Ultimate Cron, Views)
alongside it.

## After enabling

Super Sitemap is not fully hands-off on enable — an administrator needs to set up
the sitemap structure and the taxonomy customizations before a useful sitemap is
produced. Configure Simple Sitemap and the Super Sitemap customizations, then let
the cron-driven build generate the sitemap files.

> **Note:** This release is a beta (1.0.0-beta2) and is not covered by Drupal's
> security advisory policy. Review it before relying on it in production.
