# Installation

## Requirements

Migrate Source Scraper is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — Drupal enables it automatically as a
  dependency when you turn on this module.

The Symfony BrowserKit and DomCrawler components it relies on ship with Drupal
core, so there are no extra third-party libraries to install. There is no minimum
PHP requirement beyond what your Drupal version already needs.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_source_scraper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_source_scraper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_source_scraper -y
```

That's all it takes. There is no configuration form — the `php_scraper` source
plugin is now available to any migration definition.

## Verify it worked

Enabling the module gives you the `php_scraper` source plugin. The real test is a
migration: write a small migration YAML that uses `plugin: php_scraper` (see the
[main guide](../index.md) for an example), then run
`drush migrate:status` to confirm your migration appears, and
`drush migrate:import <migration_id>` to run it. Scraped rows are tracked in the
standard Migrate map tables, so you can re-run and roll back as usual.
