# Installation

## Requirements

- **Drupal core 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- The base **Charts** module (`charts`), enabled and configured with a default
  charting library.
- Drupal core's **CKEditor 5** (`ckeditor5`), **Editor** (`editor`), and
  **Filter** (`filter`) modules, enabled (core enables these as needed).

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/charts_text_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_text_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charts_text_filter -y
```

## Set it up

The module has no settings page of its own — you enable it per text format:

1. Confirm **Charts** is configured with a default library at
   `/admin/config/content/charts`.
2. Edit a CKEditor 5 text format at `/admin/config/content/formats`, drag the
   **Drupal Charts** button into the active toolbar, and tick the box to enable
   **Charts Text Filter**. Save.

Enable the filter only on text formats that **trusted editors** use, since it turns
authored content into rendered charts.

## Verify it worked

Open the WYSIWYG editor on a field that uses the format you configured. The
**Drupal Charts** icon should appear in the toolbar; clicking it should open the
chart configuration form. Build a small chart, insert it, and confirm it renders
when you view the content.
