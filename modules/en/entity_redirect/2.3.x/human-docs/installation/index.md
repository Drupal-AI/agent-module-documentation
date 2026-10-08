# Installation

## Requirements

Entity Redirect is lightweight and has no third-party libraries:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).

It has no module dependencies of its own. It ships configuration schema for node,
media, taxonomy, contact, paragraphs, profile, and webform bundles, so it works
with whichever of those you have installed — but none of them are required to
enable it. Core's **Layout Builder** (`layout_builder`) is optional: if it's
enabled, the "Layout Builder page" redirect destination becomes available.

There are no Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_redirect -y
```

## After enabling

The module does nothing until you configure a bundle. Two things to know:

1. Each bundle's redirect behavior is set on that bundle's edit form — see
   [Configuration](../configuration/index.md).
2. If you want to allow the **external URL** destination, grant the **Set external
   entity redirects** permission (`set external entity redirects`) to the
   appropriate roles under **People → Permissions**. Without it, only local
   destinations are available.
