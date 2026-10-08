# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Module dependencies (Composer and Drupal pull these in):
  - Core **Layout Discovery** (`layout_discovery`).
  - **Twig Real Content** (`twig_real_content`) — used for realistic section
    previews.
  - **Layout Options** (`layout_options`) — adds the per‑section option controls.
- To render the layouts as intended, use a **Bootstrap 5** based theme (DROWL
  designs these against its own DROWL Base / Radix theme, but standard Bootstrap 5
  classes should work with any Bootstrap 5 theme).

There are no third‑party PHP library requirements.

> **Note:** This module does not currently have Drupal security‑advisory coverage.

## Install with Composer

From the project root:

```bash
composer require drupal/drowl_layouts_bs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drowl_layouts_bs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drowl_layouts_bs -y
```

## Verify it worked

Add a section in Layout Builder or Layout Paragraphs — the DROWL Bootstrap layouts
should now appear in the list of available layouts, each with its grid and column
options.
