# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Node** module (`node`), enabled automatically as a dependency.
- The **Solo** theme (by Flash Web Center), or a sub-theme of Solo, set as your
  active default front-end theme — otherwise every feature stays inert.

There are no third-party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/solo_utilities -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/solo_utilities -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en solo_utilities -y
```

There are no submodules.

## Next steps

Make sure Solo (or a Solo sub-theme) is your default theme, then turn on the
features you want: the **block title visibility** and **custom node width**
features are switched on from the **Solo theme settings form**, and Color Schemes
Rules are created under **Configuration → Solo Utilities → Color Schemes Rules**.
See **How to use it** on the [overview page](../index.md).
