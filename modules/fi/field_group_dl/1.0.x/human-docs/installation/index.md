# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contrib **Field Group** module (`field_group`) — a hard dependency, since
  this module contributes a formatter to it. Composer installs it automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_dl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Field Group and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group_dl -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_dl -y
```

Drupal will enable Field Group at the same time if it is not already on.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage display**, add a field
group, and confirm that **Definition list** appears in the list of available
group formats. Add a couple of fields to that group, save, and view a piece of
content — the grouped fields should render as a `<dl>` with label/value pairs.
