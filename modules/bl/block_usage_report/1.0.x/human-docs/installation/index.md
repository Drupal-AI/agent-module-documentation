# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No other module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/block_usage_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_usage_report -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_usage_report -y
```

Once enabled, the report is available at **Reports → Block usage**
(`/admin/reports/block-usage`) — see
[How to use it](../index.md#how-to-use-it). Before relying on it in a shared
environment, confirm the report's access requirement matches who should see this
structural information.
