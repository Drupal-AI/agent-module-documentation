# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), which is part of Drupal core and enabled on
  most sites — this is the module's only dependency.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/views_role_based_global_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_role_based_global_text -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_role_based_global_text -y
```

There is no configuration page. As soon as the module is enabled, every **Global:
Text area** handler in your views gains the extra **Roles** section — see the
[overview](../index.md#how-to-use-it) for how to use it. Existing text areas keep
working unchanged (an empty role selection means "show to everyone").
