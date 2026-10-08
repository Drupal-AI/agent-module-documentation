# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 7.4** or newer (`php_requirement: 7.4`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this module
  provides a layout for use inside Layout Builder.

There are no third‑party Composer or PHP library requirements.

> **Security advisory coverage:** this project is **not covered** by Drupal's
> security advisory policy, and it is **minimally maintained** (maintenance fixes
> only). Weigh that before relying on it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_dynamic_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_dynamic_tabs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_dynamic_tabs -y
```

Make sure core's Layout Builder is enabled as well (`drush en layout_builder -y`)
if it is not already.

## Verify it worked

Open a Layout Builder layout, add a section, and check the layout chooser — you
should see a **Dynamic tabs** layout. Select it, add a couple of tabs in the
section settings, and confirm the tab switcher appears. If it does, the module is
working.
