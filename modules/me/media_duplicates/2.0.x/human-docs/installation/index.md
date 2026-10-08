# Installation

## Requirements

Media Duplicates works on top of core's Media system. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **PHP 7.3 or newer** (`php: >=7.3`).
- Core's **Media** module (`media`) enabled — this is its only module dependency,
  and Drupal will enable it automatically as a dependency.

**Optional:** the contributed **Entity Usage** module (`drupal/entity_usage`) is
suggested — not required. It helps you find *where* duplicate media are used so you
can consolidate them, which Media Duplicates itself does not do.

## Install with Composer

From the project root:

```bash
composer require drupal/media_duplicates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_duplicates -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_duplicates -y
```

Enabling the module adds a `duplicates_checksum` field to every media entity and
begins fingerprinting media as it is saved.

## Important first step on an existing site

If your site already has media, those older items won't have a checksum yet — and
the status report (`/admin/reports/status`) will warn that "N media entities are
missing a duplicates checksum." Generate them once, either with the Drush command:

```bash
drush media-duplicates:checksums:rebuild all
```

or via the **Rebuild checksums** batch form at
`/admin/config/media/media-duplicates/refresh`. See
[Configuration](../configuration/index.md) for the details and for turning on
enforcement.
