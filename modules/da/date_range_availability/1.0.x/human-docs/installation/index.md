# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Datetime Range** module (`datetime_range`) — provides the date‑range
  field type the module reads.
- Core's **Views** module (`views`) — for the Availability Views field.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/date_range_availability -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_range_availability -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_range_availability -y
```

If Datetime Range or Views are not yet enabled, enable them too
(`drush en datetime_range views -y`).

## Verify it worked

Make sure the entity you want to track has a date‑range field. Then edit a View,
add a field, and confirm **Availability** is offered — configure it with your
date‑range field's machine name and you should see the availability state per row.
Alternatively, add the `node_availability()` Twig call to a template. See
["How to use it"](../index.md#how-to-use-it) for both approaches.
