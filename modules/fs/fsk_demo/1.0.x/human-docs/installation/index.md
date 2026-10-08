# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).

There are no module dependencies and no third‑party Composer or PHP library
requirements. This is demonstration code — install it on a development or learning
site, not in production.

## Install with Composer

From the project root:

```bash
composer require drupal/fsk_demo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fsk_demo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fsk_demo -y
```

No configuration is required.

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep fsk_demo`.
The module's example form is then available for you to view and study. When you have
finished exploring it, disable the module (`drush pm:uninstall fsk_demo -y`) —
there is no reason to leave demo code enabled on a real site.
