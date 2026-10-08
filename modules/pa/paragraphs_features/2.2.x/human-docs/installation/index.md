# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The contrib **Paragraphs** module (`drupal/paragraphs` `^1.13`), which Composer
  brings in for you.
- Core's **Field** (`field`) and **CKEditor 5** (`ckeditor5`) modules — the latter
  is needed for the Split paragraph tool.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_features -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Paragraphs if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_features -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_features -y
```

Enabling the module makes the per-field widget options and the global setting
available; nothing changes for editors until you switch a feature on. See
[Configuration](../configuration/index.md).

There are no submodules. For the smoothest drag-and-drop experience the feature
relies on core's `sortable` library, which Drupal provides.
