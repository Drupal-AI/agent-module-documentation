# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field** module (`field`), which is standard and enabled on any Drupal
  site with content fields; Drupal enables it automatically if needed.

There are no third-party Composer or PHP library requirements. The shipped data
sources call external APIs over the network, so the site needs outbound HTTP
access to reach them.

## Install with Composer

From the project root:

```bash
composer require drupal/external_data_source -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/external_data_source -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_data_source -y
```

The module ships no submodules and adds no configuration page. To use it, add an
**External Data Source Field** to a bundle — see
[Configuration](../configuration/index.md).
