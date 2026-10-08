# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working **DKAN** site (`dkan`) — the feed reads datasets from DKAN's
  metastore.
- The **Facets** module.
- The **symfony/property-access** library (pulled in via Composer).

## Install with Composer

From the project root:

```bash
composer require drupal/dkan_rss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`symfony/property-access` dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dkan_rss -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dkan_rss -y
```

## Verify it worked

Visit **`/datasets.rss`** on your site. You should receive a valid RSS 2.0 XML
feed (served as `application/rss+xml`) listing your DKAN datasets — on a standard
install with demo content it should validate cleanly. To surface the feed to
visitors, place the **RSS Link** block via **Structure → Block layout**.
