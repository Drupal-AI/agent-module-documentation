# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or newer** (`php: 7.4`).
- Nothing else — there are no module dependencies beyond core, and no third‑party Composer
  or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_real_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twig_real_content -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_real_content -y
```

There are no submodules and no settings page. Once enabled, the `real_content` Twig test
and filter are available in every template — see
[How to use it](../index.md#how-to-use-it) on the overview page. After adding them to a
template, rebuild caches (`drush cr`) so the template changes take effect.
