# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **Responsive Image** module (`responsive_image`) — the formatter
  is built on it and uses responsive image styles.
- The **Token** module, version 1.15 or newer (`drupal/token ^1.15`) — used so the
  CSS selector can contain tokens.

Both dependencies are enabled/pulled in automatically. There are no other
third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bg_img_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies, including Token, as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bg_img_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bg_img_field -y
```

This also enables Responsive Image and Token if they aren't already on. After
enabling, add the field to a bundle and pick a responsive image style — see the
[overview](../index.md#how-to-use-it) for the step‑by‑step.
