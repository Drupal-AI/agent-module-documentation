# Installation

## Requirements

- **Drupal 10.5 or newer, or Drupal 11.2+** (`core_version_requirement:
  ^10.5 || ^11.2`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — Drupal enables it
  automatically as a dependency.
- *(Optional, suggested)* the **Editor Advanced Link** module
  (`drupal/editor_advanced_link`), which lets you add title, id, class, and other
  attributes to the inserted link.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/editor_file -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/editor_file -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editor_file -y
```

The File button is not active until you add it to a text format's toolbar and turn
on uploads — see [Configuration](../configuration/index.md). There are no
submodules.
