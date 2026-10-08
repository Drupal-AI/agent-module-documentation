# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Feeds** module (`feeds`) — this module extends Feeds importers, so Feeds
  must be present and enabled.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_dependency -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_dependency -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_dependency -y
```

Drupal enables the Feeds dependency automatically if it isn't already on.

## Verify it worked

Make sure you have at least two feeds at **Content → Feeds**, then edit one of
them. You should see a new entity‑reference field for selecting another feed as a
dependency (plus the option to clear the dependency when this feed is cleared). If
that field is present, the module is working.
