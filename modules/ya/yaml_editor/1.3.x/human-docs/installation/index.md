# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies.
- The Ace editor library, loaded at runtime from the configured **Editor source** — by
  default a public CDN (cdnjs), so an internet connection is needed unless you point it
  at a self‑hosted copy.

There are no third‑party Composer or PHP library requirements bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/yaml_editor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/yaml_editor -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en yaml_editor -y
```

YAML Editor ships no submodules. Once enabled it immediately enhances tagged YAML
textareas on admin pages. To adjust the Ace source or theme, or to turn the editor on
for a field, see [Settings and usage](../index.md#settings--the-ace-source-and-theme)
on the overview page. Grant the **Configure yaml_editor** permission to any role that
should change those settings.
