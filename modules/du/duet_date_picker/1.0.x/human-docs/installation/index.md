# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Date** or **Datetime** field to attach the widget to. Core's Datetime module
  provides these field types; enable it if you don't already use date fields.

There are no other Drupal module dependencies, and no separate PHP or third‑party
library to install — the Duet component ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/duet_date_picker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/duet_date_picker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en duet_date_picker -y
```

## Verify it worked

Go to a content type's **Manage form display**, pick **Duet Date Picker** as the
widget for a date field, and save. Then add or edit a node of that type — the date
field should now render with Duet's accessible picker instead of the default date
input.
