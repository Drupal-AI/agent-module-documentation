# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), enabled automatically as a
  dependency.

There are no third-party Composer requirements. The Tippy.js library ships with
the module; Popper is loaded from a local `libraries/popperjs/dist/umd/popper.min.js`
copy if present, otherwise from a CDN — so no extra install step is required to
get tooltips working.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_tippy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_tippy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_tippy -y
```

There are no submodules.

## Next steps

Enabling the module does not change any text format on its own. Follow the
**How to use it** steps on the [overview page](../index.md) to add the Tippy
Tooltip button to a CKEditor 5 toolbar and enable the accompanying filter.
