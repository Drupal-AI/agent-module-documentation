# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.3 or newer**.
- Core's **Datetime Range** module (`datetime_range`) and **System** — Datetime
  Range is enabled automatically as a dependency.
- The **`rlanvin/php-rrule`** PHP library (`^2`), which Composer pulls in
  automatically when you require the module. This is what expands recurrence
  rules into concrete dates.

## Install with Composer

From the project root:

```bash
composer require drupal/date_recur -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the php-rrule library — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/date_recur -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_recur -y
```

Once enabled, **Recurring date** becomes available as a field type in the Field
UI.

## Optional submodule

- **`date_recur_subfield`** — a demonstration/extension submodule that subclasses
  the field type to add an extra stored column (for example a colour). Enable it
  only if you specifically need a subclassed recurring-date field:

```bash
drush en date_recur_subfield -y
```
