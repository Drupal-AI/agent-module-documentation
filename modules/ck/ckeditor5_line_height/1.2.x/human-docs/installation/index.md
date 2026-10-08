# Installation

## Requirements

CKEditor5 Line Height needs:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **CKEditor 5** (`ckeditor5`) module enabled. This is the only dependency,
  and Drupal enables it automatically as a dependency when you turn on this module.

The plugin's JavaScript is bundled with the module, so there are no third-party
libraries to install separately.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_line_height -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_line_height -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_line_height -y
```

## Next steps

Enabling the module makes the **Line Height** button available, but it does not add
it to any toolbar automatically. See the [overview](../index.md) for how to drag the
button into a CKEditor 5 text format and set the allowed spacing values.
