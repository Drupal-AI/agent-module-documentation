# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9||^10||^11||^12`).
- Core's **Field** module (enabled by default) so you can add the field.
- A database that supports the **JSON** column type. The field is designed for
  MySQL's JSON data type; other databases (for example PostgreSQL's `jsonb`) are
  not specifically tested.
- No third‑party Composer or PHP library requirements for the base module. The
  optional display/edit add‑ons (DataTables, Chart.js, Google Charts,
  x‑spreadsheet, and so on) are loaded as needed.

## Install with Composer

From the project root:

```bash
composer require drupal/json_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/json_table -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_table -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click **Add
field** — the **Json table** field type should appear. Add it, choose the Json
table widget on Manage form display and the Json table formatter on Manage display
(see "How to use it" in the [overview](../index.md)), then create content: you
should get a spreadsheet‑like editing grid and, on the rendered entity, a table or
chart.
