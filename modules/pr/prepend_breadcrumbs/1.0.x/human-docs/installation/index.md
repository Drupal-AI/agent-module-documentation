# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Menu Breadcrumb](https://www.drupal.org/project/menu_breadcrumb)** module
  (`menu_breadcrumb`), which this module depends on. It generates the breadcrumb
  trail from the menu; Prepend Breadcrumbs adds the leading items on top of it.

## Install with Composer

From the project root:

```bash
composer require drupal/prepend_breadcrumbs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Menu Breadcrumb dependency for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prepend_breadcrumbs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prepend_breadcrumbs -y
```

Drupal will enable Menu Breadcrumb at the same time as a dependency.

## Verify it worked

After enabling, go to **Configuration → User interface → Prepend Breadcrumbs**,
set at least one leading breadcrumb item (see
[Configuration](../configuration/index.md)), and save. Then view any page with a
breadcrumb trail — your leading item(s) should appear at the very start of it.

> **This module is at an early (alpha) release.** Test the breadcrumb output on a
> staging copy before relying on it in production.
