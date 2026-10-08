# Installation

## Requirements

Back To Top is deliberately lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Nothing else — there are no other module dependencies, no third‑party Composer
  packages, and no external JavaScript libraries. The button's front‑end code
  uses jQuery and other assets that already ship with Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/back_to_top -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/back_to_top -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en back_to_top -y
```

That is all it takes. The button is active immediately with its default settings
— visit a page long enough to scroll, scroll down, and the button fades in at the
bottom right. To adjust its appearance and behavior, see the **How to use it**
section on the [overview page](../index.md); the settings form lives at
**Configuration → User interface → Back To Top**.

There are no submodules.
