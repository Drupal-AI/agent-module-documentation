# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.1 or newer**.
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency, and Drupal enables it automatically as a dependency when you turn on
  this module. (CKEditor 5 is the default rich-text editor in Drupal core.)

There are no third-party Composer or JavaScript library requirements — the
compiled plugin ships with the module and loads locally.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_findandreplace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_findandreplace -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_findandreplace -y
```

Enabling the module does not turn the feature on by itself — you add the **Find
and replace** button to each text format's CKEditor 5 toolbar. See the
[overview](../index.md#how-to-use-it) for the steps.
