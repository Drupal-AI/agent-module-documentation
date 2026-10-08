# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Datetime** module (`datetime`) — Drupal enables it automatically as a
  dependency when you turn on Date time day. (Datetime in turn relies on core's
  Field module.)

There are no third‑party Composer packages, PHP extensions, or JavaScript
libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/date_time_day -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_time_day -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_time_day -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**.
In the field-type list you should now see **Date time day**. Add one, and on the
node edit form you will get a single date input followed by a start-time and an
end-time input.

> **Uninstalling later:** remove every field that uses the Date time day type
> first — otherwise Drupal will not let you uninstall the module. Once no fields
> depend on it, uninstall it like any other module.
