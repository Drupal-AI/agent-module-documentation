# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Translation Management Tool (TMGMT)** module. This module is a TMGMT
  translator plugin — it only does anything useful with TMGMT present, so install
  and enable [`drupal/tmgmt`](https://www.drupal.org/project/tmgmt) first if it is
  not already on your site.
- A **Bureau Works account** with API credentials, so the connector has something
  to authenticate against.

## Install with Composer

From the project root:

```bash
composer require drupal/bureau_works_tmgmt_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bureau_works_tmgmt_connector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bureau_works_tmgmt_connector -y
```

If TMGMT is not yet enabled, enable it too:

```bash
drush en tmgmt bureau_works_tmgmt_connector -y
```

Once enabled, continue to [Configuration](../configuration/index.md) to register
Bureau Works as a translation provider and enter its credentials.
