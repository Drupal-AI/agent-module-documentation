# Installation

## Requirements

- **Drupal 10.1 or newer** (`core_version_requirement: >=10.1`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_fe_color -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_fe_color -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_fe_color -y
```

Then add the **FeColor** button to your CKEditor 5 text formats (see the "How to
use it" section of the [overview](../index.md)).

## Submodules

- **`ckeditor5_fe_color_config_example`** — an example configuration submodule that
  demonstrates how to define a colour palette. Because palettes are configured in
  code, this is the easiest starting point for building your own. Enable it to see
  a working example:

  ```bash
  drush en ckeditor5_fe_color_config_example -y
  ```

  For production, copy its approach into your own custom module rather than relying
  on the example directly.

## Verify it worked

Add the **FeColor** button to a CKEditor 5 text format and save. Open a content
edit form using that format — selecting text and clicking the FeColor button should
offer your palette of colours to apply.
