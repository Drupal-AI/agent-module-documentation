# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

Cookie Condition has no module dependencies, no permissions, and no routes — it is
a single condition plugin. There are no third‑party PHP or JavaScript library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cookie_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookie_condition -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookie_condition -y
```

There is no required configuration.

## Verify it worked

Go to **Structure → Block layout**, place or edit a block, and open its visibility
settings. You should see a new **Cookie** condition where you can enter a cookie
name and value. That confirms the plugin is available — see "How to use it" in the
[overview](../index.md) for setting it up.
