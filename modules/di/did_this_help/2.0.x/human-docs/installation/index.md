# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11`, with the
  supported core range extending through 12).
- No external PHP or JavaScript library dependencies and no other module
  dependencies. (Views is used for the optional report integration and ships with
  core.)

## Install with Composer

From the project root:

```bash
composer require drupal/did_this_help -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/did_this_help -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en did_this_help -y
```

## Verify it worked

After enabling, the **"Did this help?"** block becomes available under **Structure
→ Block layout**, and the report appears at **Reports → Did this help?**
(`/admin/reports/did-this-help`). Nothing shows to visitors until you place the
block — head to [Configuration](../configuration/index.md) to place it and
customize the question and answers.
