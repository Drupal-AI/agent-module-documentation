# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Navigation** module (`navigation`) — Progressive Admin filters this
  menu, and Drupal enables it as a dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/progressive_admin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/progressive_admin -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en progressive_admin -y
```

Drupal enables the core **Navigation** module at the same time if it isn't
already on.

## Verify it worked

Visit the configuration page at `/admin/config/progressive_admin` and confirm you
can choose a **Default experience level**. Set one, save, and check that the admin
Navigation menu is filtered accordingly. See the
[main guide](../index.md#how-to-use-it) for details.
