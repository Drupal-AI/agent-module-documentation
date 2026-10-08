# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency, and Drupal will enable it automatically as a dependency.

The Tippy.js and Popper JavaScript libraries are bundled inside the module, so
there are no third‑party Composer or CDN requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_tooltips -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_tooltips -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_tooltips -y
```

Enabling the module doesn't add the tooltip button anywhere yet — you have to add
it to each text format you want it on. Head to
[Configuration](../configuration/index.md) to add the button to a format and (if
you like) tune the global tooltip behaviour.
