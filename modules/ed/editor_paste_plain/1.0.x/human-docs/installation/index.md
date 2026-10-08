# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — it's the only dependency,
  and Drupal enables it automatically when you turn on Editor Paste Plain.

There are no third-party libraries and nothing else to download.

## Install with Composer

From the project root:

```bash
composer require drupal/editor_paste_plain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/editor_paste_plain -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editor_paste_plain -y
```

## After enabling

Nothing happens until you switch the plugin on for a text format. See
[How to use it](../index.md#how-to-use-it) on the overview page for the per-format
checkbox.
