# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`; the module requires
  `drupal/core >= 10`).
- No third‑party libraries — it builds on jQuery and core JavaScript that ship with
  Drupal.
- No dependencies on other contrib modules.

## Install with Composer

From the project root:

```bash
composer require drupal/improved_multi_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/improved_multi_select -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en improved_multi_select -y
```

Once enabled, go to the settings page at **Configuration → User interface →
Improved Multi Select** (`/admin/config/user-interface/ims`) to choose where the
widget applies — see [How to use it](../index.md#how-to-use-it).

## Submodule — IMS Options Widget

The package ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **IMS Options Widget** | `ims_options_widget` | A real field widget so the order a user arranges in the *selected* panel is saved onto the entity's field. Enable it if you need the chosen order persisted (the base module only restyles the widget). |

Enable it if you need ordered storage:

```bash
drush en ims_options_widget -y
```
