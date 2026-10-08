# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8.0 || ^9.0 || ^10.0`).

There are no dependent modules, no third‑party Composer requirements, and no PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/site_version -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/site_version -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_version -y
```

On enable, the module generates a random 32‑character JSON API key, records the
site UUID, and stamps a "changed" timestamp — but the JSON API itself stays
**disabled** until you turn it on.

## Verify it worked

Grant the `site_version view` permission to the appropriate role and visit
`/site-version` — you should see the version table (empty of a version number
until you set one). Then head to
[Configuration](../configuration/index.md) to fill in the version, build and
description.
