# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Feeds** module — this fetcher plugs into Feeds, so Feeds must be enabled.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_http_key_fetcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_http_key_fetcher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_http_key_fetcher -y
```

If you don't already have Feeds enabled, add it too:

```bash
drush en feeds -y
```

## Where the key is entered

There is no site-wide settings page. The API key is entered per feed, in the
**Authorization X API Key** field beneath the feed URL, and is saved with that
feed's Feeds configuration. Each feed can use its own key.

## Verify it worked

Create or edit a feed type at **Structure → Feed types** and confirm that
**Download From URL with X API Key** appears in the **Fetcher** options.
