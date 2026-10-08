# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- [**External-use icons**](https://www.drupal.org/project/ex_icons) (`ex_icons`) — the
  module whose icons are previewed.
- [**Styleguide**](https://www.drupal.org/project/styleguide) (`styleguide`) — where the
  preview is rendered.

Composer resolves and installs both dependencies for you.

## Install with Composer

From the project root:

```bash
composer require drupal/ex_icons_styleguide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update ex_icons and
Styleguide at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ex_icons_styleguide -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ex_icons_styleguide -y
```

Drupal enables ex_icons and Styleguide automatically as dependencies. There is no
configuration step — the bridge works immediately.

## Verify it worked

Visit your theme's styleguide at
**`/admin/appearance/styleguide/MY_THEME_NAME`** (replace `MY_THEME_NAME` with your
theme's machine name). You should see the icons managed by ex_icons listed there, each
with its ID.
