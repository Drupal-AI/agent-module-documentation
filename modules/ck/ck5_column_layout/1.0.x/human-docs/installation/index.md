# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal 10 and 11. No
  external JavaScript libraries are required — the widget is built natively for the
  CKEditor 5 framework.

There are no third-party Composer or PHP library requirements.

> **Note:** this module is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/ck5_column_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ck5_column_layout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ck5_column_layout -y
```

## Turn on the tool

Enabling the module does not change any text format by itself. Per format you must:
add the **Columns** toolbar button, enable the **CKEditor 5 Column Layout Asset
Loader & Cleaner** filter (ordered after *Limit allowed HTML tags*), and grant the
**`ck5 column layout settings`** permission. Those steps are in the
[guide](../index.md#how-to-enable-the-columns-tool-in-a-text-format).

## Verify it worked

Edit content using the configured format. The **Columns** icon should appear in the
CKEditor 5 toolbar; use it to wrap a selection in columns, save, and view the page as
a visitor — the columns should render responsively, with no editor-only UI leaking
onto the page.
