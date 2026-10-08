# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal 10 and 11.

There are no third-party Composer or PHP library requirements.

> **Note:** the current release is a beta (`1.0.0-beta2`) and is not covered by
> Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_alignment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_alignment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_alignment -y
```

## Add the buttons

Enabling the module does not change any text format by itself. Add the alignment
buttons per format as described in the
[guide](../index.md#how-to-add-the-buttons-to-a-text-format).

## Verify it worked

Edit content using the configured format. The individual alignment buttons (left,
center, right, justify) should appear in the CKEditor 5 toolbar and align the selected
text with a single click.
