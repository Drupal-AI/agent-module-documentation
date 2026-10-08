# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  it's on by default on most sites.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_auto_refresh -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_auto_refresh -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_auto_refresh -y
```

There is no settings form and no permissions to grant. To use it, edit a View,
add the **Global: Auto Refresh** header (or footer), and make sure the View has
**Use Ajax** on and **caching** off — see [the main page](../index.md#how-to-set-it-up)
for the full walkthrough.
