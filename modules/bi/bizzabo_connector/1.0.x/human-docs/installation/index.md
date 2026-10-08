# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- A **Bizzabo account** with API access — you need the events API base URL and a
  bearer authentication key (see [Configuration](../configuration/index.md)).

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bizzabo_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bizzabo_connector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bizzabo_connector -y
```

Once enabled, set the API base URL and bearer key before using the listing —
continue to [Configuration](../configuration/index.md).
