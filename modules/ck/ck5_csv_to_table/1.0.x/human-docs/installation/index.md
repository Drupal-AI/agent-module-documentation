# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal 10 and 11.

There are no third-party Composer or PHP library requirements.

> **Note:** this module is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/ck5_csv_to_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ck5_csv_to_table -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ck5_csv_to_table -y
```

## Turn on the button

Enabling the module does not change any text format by itself. Per format, add the
**CSV** toolbar button, and grant the **Use CSV Importer** permission to the roles
that should be able to import CSV files. Those steps are in the
[guide](../index.md#how-to-enable-the-button-in-a-text-format).

## Verify it worked

Edit content using the configured format as a user who has the **Use CSV Importer**
permission. The CSV icon should appear in the CKEditor 5 toolbar; click it, pick a
small CSV file, and confirm a table is generated with the first row as its header.
