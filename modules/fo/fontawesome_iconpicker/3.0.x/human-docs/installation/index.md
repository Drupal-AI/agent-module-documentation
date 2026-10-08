# Installation

## Requirements

Font Awesome Iconpicker has a couple of dependencies beyond core:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The contributed **Font Awesome** module (`drupal/fontawesome`), enabled — it supplies
  the icon CSS/webfont that the rendered icons use.
- The external **`d34dman/vanilla-icon-picker`** JavaScript library (`^1.3.0`), which
  provides the searchable popup. Composer installs it into `/libraries` for you.

## Install with Composer

From the project root:

```bash
composer require drupal/fontawesome_iconpicker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the **Font Awesome**
module and the **`d34dman/vanilla-icon-picker`** library, and update any shared
dependencies. (For the library to land under `/libraries`, your project needs an
`installer-paths` entry for `type:drupal-library`, which the standard Drupal Composer
template provides.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fontawesome_iconpicker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fontawesome_iconpicker -y
```

This also enables the **Font Awesome** module if it isn't already on. Or enable **Font
Awesome Iconpicker** from **Extend** (`/admin/modules`).

There are no submodules and no configuration form.

## Verify the library is present

If the picker popup doesn't appear on a field, confirm the JS library is installed at
`/libraries/vanilla-icon-picker/dist/icon-picker.min.js`, and that the **Font Awesome**
module is enabled and loading its icons.

## Next steps

The widget and formatter become available once the module is enabled; you apply them per
field on *Manage form display* and *Manage display*. See
[How to use it](../index.md#how-to-use-it) on the overview page.
