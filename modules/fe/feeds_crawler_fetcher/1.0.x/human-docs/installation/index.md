# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Feeds** module — this fetcher plugs into Feeds, so you need Feeds enabled
  to use it.
- A parser for your source. The module currently works with **XML/HTML**, so a
  parser such as one from [Feeds Extensible Parsers](https://www.drupal.org/project/feeds_ex)
  is a natural companion.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_crawler_fetcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_crawler_fetcher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_crawler_fetcher -y
```

If you don't already have Feeds (and a suitable parser) enabled, add them too, for
example:

```bash
drush en feeds -y
```

## Verify it worked

Create or edit a feed type at **Structure → Feed types** and confirm that **Crawl
a set of url** appears in the **Fetcher** options. If it does, the module is ready
to use.
