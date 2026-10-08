# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third-party Composer or PHP
  libraries.
- A field of type **Text (formatted, long, with summary)** (`text_with_summary`)
  to apply the limit to — the standard **Body** field is one.

## Install with Composer

From the project root:

```bash
composer require drupal/summary_word_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/summary_word_limit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en summary_word_limit -y
```

Enabling the module alone changes nothing — the limit is empty by default. See the
[main guide](../index.md) for how to set the limit on a field.

## Verify it worked

Edit a *Text (formatted, long, with summary)* field (for example a content type's
**Body** field) under **Manage fields**. With the module enabled, the field
settings should now include a **Summary word limit count** option.
