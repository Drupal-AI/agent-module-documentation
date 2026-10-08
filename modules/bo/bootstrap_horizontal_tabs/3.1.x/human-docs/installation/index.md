# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 | ^12`).
- Core's **Field** and **Text** modules enabled (both are part of standard Drupal
  and are pulled in as dependencies).
- A **theme that provides Bootstrap** CSS and the tab JavaScript (for example a
  Bootstrap 5 theme). The module ships markup only — it loads no Bootstrap assets
  of its own.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_horizontal_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_horizontal_tabs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_horizontal_tabs -y
```

Next, add a **Horizontal Tabs** field to a content type and set the Bootstrap
version to match your theme — see the [overview](../index.md) for the full
walk-through.
