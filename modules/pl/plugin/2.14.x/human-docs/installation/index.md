# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Nothing else — Plugin depends only on Drupal core, with no third‑party Composer
  packages, PHP libraries, or other module dependencies.

Often you won't install Plugin directly at all — another module that depends on it
will pull it in automatically when you require that module with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/plugin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plugin -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plugin -y
```

There is no settings form to configure. Once enabled, the read‑only plugin overview
is available at **Structure → Plugins** (`/admin/structure/plugin`) for users with
the **View plugin overview** permission, and the module's developer APIs are ready
to use. See the [overview](../index.md#how-to-use-it) for what you can do with it.
