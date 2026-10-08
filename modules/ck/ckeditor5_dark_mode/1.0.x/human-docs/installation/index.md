# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_dark_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_dark_mode -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_dark_mode -y
```

After enabling, add the Dark Mode button to your CKEditor 5 text formats — see
[Configuration](../configuration/index.md).

## Verify it worked

Once you have added the **Dark Mode** button to a CKEditor 5 text format (see
Configuration), open a content edit form using that format. Clicking the button
should flip the editor between its light and dark themes.
