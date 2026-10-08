# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements declared.

## Install with Composer

Note the **project name is plural** (`background_sliders`) even though the module you
enable is `background_slider`. From the project root:

```bash
composer require drupal/background_sliders -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/background_sliders -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `background_slider` (singular):

```bash
drush en background_slider -y
```

After enabling, build the slideshow on the settings form and place the block — see the
*How to use it* section on the [overview page](../index.md).

> **Before going live:** review the access‑control note on the [overview page](../index.md)
> — the settings form is reachable by any authenticated user, not just administrators.
