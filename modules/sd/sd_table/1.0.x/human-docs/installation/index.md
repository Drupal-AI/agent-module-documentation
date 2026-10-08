# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`; the project also targets Drupal 12).
- Core modules: **Field** (`field`), **File** (`file`), **Filter** (`filter`),
  **Editor** (`editor`), and **CKEditor 5** (`ckeditor5`). Drupal enables these as
  dependencies when you turn on SD Table.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sd_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sd_table -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sd_table -y
```

## Verify it worked

Go to **Structure → Content types → (a content type) → Manage fields → Create a new
field**. If **SD Table** appears in the list of available field types, the module is
active and ready to use — see [How to use it](../index.md#how-to-use-it) in the main
guide.
