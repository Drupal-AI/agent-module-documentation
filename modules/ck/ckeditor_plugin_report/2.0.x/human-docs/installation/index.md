# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party Composer or PHP library requirements, and no other module
  dependencies. To see any results, you naturally need CKEditor 5 in use (it ships
  with Drupal core), but the module installs and runs even without it.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_plugin_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_plugin_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_plugin_report -y
```

Once enabled, grant the **View ckeditor plugin report** permission and open
**Reports → CKEditor plugins**, as described in the *How to use it* section on the
[overview page](../index.md). There is no configuration and no submodules.
