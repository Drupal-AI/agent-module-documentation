# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`). The module renders
  through a Single Directory Component (SDC), which requires Drupal 10 or newer.
- No dependent modules, no PHP libraries, and no third‑party Composer packages —
  dependencies are core only.

Note that this is an early **release candidate** and is not covered by Drupal's
security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_menu_tree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_menu_tree -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_menu_tree -y
```

## Verify it worked

After enabling, go to **Administration → Structure → Block layout** and place the
**menu tree** block in a region. Choose a menu or taxonomy vocabulary as its data
source, give it a title, and save. The menu tree should render on your site — see
[How to use it](../index.md#how-to-use-it) for the full walkthrough.
