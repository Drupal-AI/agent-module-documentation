# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module (enabled on most sites by default) — the module's
  plugins attach to a View's Feed display.

There are no other module dependencies and no third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/xmlfeedviews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/xmlfeedviews -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en xmlfeedviews -y
```

There is no configuration page. Once enabled, the *XML Feed Views* style and *XML
Feed Views fields* row formats become available on any View's **Feed** display —
see [the overview](../index.md#how-to-use-it) for how to build a feed.
