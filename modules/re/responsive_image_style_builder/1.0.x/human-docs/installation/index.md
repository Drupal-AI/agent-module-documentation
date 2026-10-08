# Installation

## Requirements

Responsive Image Style Builder needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Responsive Image** module (`responsive_image`) enabled — Drupal
  enables it automatically as a dependency.
- A theme that defines a **breakpoint group** (most themes do), since the module
  generates image styles from those breakpoints.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_image_style_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_image_style_builder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_image_style_builder -y
```

## Verify it worked

Go to **Configuration → Media → Responsive image styles**, add a new responsive
image style, choose a theme breakpoint group, and save. Then check your list of
plain **image styles** (**Configuration → Media → Image styles**) — you should
see newly created styles, one per breakpoint and multiplier. See
[Configuration](../configuration/index.md) for the full walk‑through.
