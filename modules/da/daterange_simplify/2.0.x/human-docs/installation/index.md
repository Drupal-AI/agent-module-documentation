# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Datetime** module (`datetime`), which provides the Datetime Range field
  this formatter renders. Drupal enables it automatically as a dependency.
- The **flack/ranger** PHP library, pulled in automatically by Composer when you
  require the module.
- For **non‑English locales**, the PHP **`intl`** extension must be enabled on the
  server. English output works without it.

## Install with Composer

From the project root:

```bash
composer require drupal/daterange_simplify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Ranger library
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/daterange_simplify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en daterange_simplify -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a Datetime Range field)* →
Manage display**. The field's **Format** dropdown should now offer the Date Range
Simplify formatter. Select it, save, and view a piece of content — a range whose
start and end share a month or year should now render in the collapsed form (for
example "1–30 June 2026").
