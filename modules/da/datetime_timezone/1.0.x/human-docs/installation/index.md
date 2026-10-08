# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Datetime** module (`datetime`), whose field type this module extends.
  Drupal enables it automatically as a dependency.

There are no third‑party Composer packages, PHP extensions, or JavaScript
libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/datetime_timezone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datetime_timezone -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datetime_timezone -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**.
The timezone-aware date field type should appear in the list. Add one, and on the
content edit form the widget should include a **timezone selector** next to the
date and time inputs; the chosen timezone is stored with the value.

> **Planning note:** you cannot convert an existing core date field to this type in
> place. To move existing content onto it, add a new field of this type and migrate
> the values across.
