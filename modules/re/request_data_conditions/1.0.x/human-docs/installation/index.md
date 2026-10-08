# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other modules are required. It builds on core's condition plugin system, and
  the conditions can optionally be used with modules like
  [Context](https://www.drupal.org/project/context) or Page Manager.

There are no third‑party Composer or PHP library requirements.

> **Note:** The current release is a **beta**. Test it before relying on it in
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/request_data_conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/request_data_conditions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en request_data_conditions -y
```

## Verify it worked

Place or edit a block at **Structure → Block layout** and open its visibility
settings. The new **Cookie**, **HTTP header**, **Query parameters**, and
**Session** conditions should appear alongside the core conditions. See
[How to use it](../index.md#how-to-use-it) for the rest.
