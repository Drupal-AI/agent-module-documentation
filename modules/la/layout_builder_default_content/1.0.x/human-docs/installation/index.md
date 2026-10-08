# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Layout Builder** module (`layout_builder`) enabled — Drupal enables it
  automatically as a dependency.
- The contributed **Default Content** module
  ([`default_content`](https://www.drupal.org/project/default_content)) to actually
  run the export/import commands this module supports. It is the reason the module
  exists, so install it too if it is not already present.

There are no third‑party Composer or PHP library requirements.

> **Security advisory coverage:** this project is **not covered** by Drupal's
> security advisory policy. Weigh that before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_default_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you do not yet have Default Content, add it as well:

```bash
composer require drupal/default_content -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_default_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_default_content -y
```

Enable it on **both** the source and destination sites — the export side records
UUIDs and the import side resolves them, so both ends need the module.

## Verify it worked

Export content that contains a Layout Builder inline block from the source site,
import it on a destination site that also has this module enabled, and confirm the
inline block appears correctly with its content intact (rather than as a broken or
missing reference).
