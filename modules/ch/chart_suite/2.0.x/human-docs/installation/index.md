# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- **PHP 8.x.**
- Core/contrib modules: **Field** (`field`), **File** (`file`), **System**
  (`system`, 8.7+), **jQuery UI Dialog** (`jquery_ui_dialog`), and **jQuery UI
  Menu** (`jquery_ui_menu`). Drupal enables these as dependencies.
- The module **bundles** the SDSC Structured Data parsing library (in its own
  folder) — you do not install it separately.
- **Google Charts is used for rendering.** Its JavaScript is served from Google
  and pulls further libraries on demand; it **cannot be served locally**. If your
  site must avoid third‑party scripts or egress to Google, weigh this before
  installing.

## Install with Composer

From the project root:

```bash
composer require drupal/chart_suite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chart_suite -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chart_suite -y
```

The required jQuery UI and file/field modules are enabled at the same time as
dependencies.

## Verify it worked

Add a file field to a content type, then open that type's **Manage display** tab.
The file field's formatter list should now include the **Chart Suite** formatter.
Upload a supported file (CSV, TSV, HTML table, or JSON) to a piece of content and
view it — you should see an interactive chart rendered from the file's data.
