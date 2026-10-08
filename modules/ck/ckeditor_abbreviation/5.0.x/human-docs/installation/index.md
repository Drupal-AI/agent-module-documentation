# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the module adds a button to
  the CKEditor 5 toolbar, so this is required and Drupal enables it as a dependency.

There are no third-party Composer or PHP library requirements; the plugin ships a
prebuilt JavaScript bundle.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_abbreviation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/ckeditor_abbreviation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_abbreviation -y
```

## Verify it worked

Edit a CKEditor 5 text format at **Configuration → Content authoring → Text formats
and editors** and check that an **Abbreviation** button is available in the list of
buttons you can drag into the toolbar. Add it, allow `<abbr title>` in the format's
HTML filter, and save — see the [overview](../index.md#how-to-use-it) for the full
steps and editor usage.
