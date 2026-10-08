# Installation

## Requirements

View Marquee needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), which is part of a standard Drupal install and
  enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements, and the plugin ships
no JavaScript of its own — scrolling is the browser's native `<marquee>` behavior.

## Install with Composer

From the project root:

```bash
composer require drupal/view_marquee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/view_marquee -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en view_marquee -y
```

There is nothing to configure globally. Once enabled, edit any view and set its
**Format** to **Marquee**, then adjust the style options — see the
[main guide](../index.md#how-to-use-it).
