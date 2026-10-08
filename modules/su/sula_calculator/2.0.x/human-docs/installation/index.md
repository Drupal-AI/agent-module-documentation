# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.
- No third-party Composer packages or PHP libraries are required.
- For the intended responsive layout, a **Bootstrap 5-based theme** is
  recommended. The module works without one, but some styling relies on Bootstrap
  5 classes.

## Install with Composer

From the project root:

```bash
composer require drupal/sula_calculator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sula_calculator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sula_calculator -y
```

Enabling the module registers the two calculator blocks and the settings form,
but nothing appears on the site until you place a block — see
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Structure → Block layout**. When you click **Place block** in any region,
the block picker should now list the **SULA credit calculator** and **SULA
clock/time calculator** blocks.
