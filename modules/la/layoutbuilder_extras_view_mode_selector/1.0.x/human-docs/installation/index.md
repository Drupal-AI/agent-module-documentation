# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`), enabled and in use.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layoutbuilder_extras_view_mode_selector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layoutbuilder_extras_view_mode_selector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layoutbuilder_extras_view_mode_selector -y
```

## Verify it worked

Go to **Structure → Block types**, edit a block content type, and confirm you can
now choose which view modes are exposed and assign icons to them. Place a block of
that type in Layout Builder and check that the view‑mode picker shows only your
curated, icon‑illustrated choices. See "How to use it" in the
[overview](../index.md).
