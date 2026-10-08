# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11`, and the
  project's own notes extend support to Drupal 12).
- No hard module dependencies and no third-party Composer or PHP libraries.

**Recommended companion modules** (optional):

- **Ajax Comments** — pairs well with AJAX paging of comment content.
- **Pagerer** — for richer pager styling.

## Install with Composer

From the project root:

```bash
composer require drupal/field_longtext_pager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_longtext_pager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_longtext_pager -y
```

## Allow the page-break placeholder in your editors

Paging can split on a page-break placeholder embedded in the text. Make sure your
**text formats and editors** permit that placeholder so it survives editing —
there are CKEditor plugins available for inserting page breaks manually. This step
only matters if you want to control break points by hand; the character/word/block
splitting modes work without it.

## Verify it worked

Go to any bundle's **Structure → Content types → *(type)* → Manage display**, find
a long-text field, and open its **Format** dropdown. If **Field pager** appears as
an option, the module is installed. Continue to
[Configuration](../configuration/index.md) to set the module defaults and turn on
paging for a field.
