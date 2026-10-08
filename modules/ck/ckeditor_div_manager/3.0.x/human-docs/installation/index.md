# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the editor the plugin
  extends, and Drupal enables it automatically as a dependency.
- A Composer library dependency on `drupal-ckeditor-libraries-group/div` (`^4.10`).
  Composer pulls this in for you; note it is a legacy CKEditor 4 library that the
  CKEditor 5 build in 3.0.x does not actually use at runtime.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_div_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the CKEditor library dependency listed above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_div_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_div_manager -y
```

Enabling the module makes the **Div Manager** button available in the CKEditor 5
toolbar configuration. It does nothing until you add that button to a text format —
see [How to use it](../index.md#how-to-use-it) on the main page.
