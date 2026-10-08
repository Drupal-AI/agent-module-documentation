# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only dependency,
  and Drupal enables it automatically as a dependency when you turn on CKEditor Font.

There are no third‑party Composer or PHP library requirements.

> **Note:** this is a **beta** release, and the module is **deprecated** in favor of
> the CKEditor5 Plugin Pack module for new sites. Weigh that before adopting it on a
> new build.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_font -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_font -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_font -y
```

Enabling the module makes the four toolbar buttons available, but they aren't added to
any editor yet. Continue to [Configuration](../configuration/index.md) to add them to
a text format and set up the font, size, and color lists.

There are no submodules.
