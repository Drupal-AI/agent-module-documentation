# Installation

## Requirements

Activities needs Views plus two contributed export libraries:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), enabled.
- The contributed **Views Data Export** (`drupal/views_data_export`, `^1.8`) and **XLS
  Serialization** (`drupal/xls_serialization`, `^2.0`) modules — Composer pulls these in
  automatically; they power the CSV/XLS export.
- A working **cron** if you want automatic purging of old log entries.

> **Note:** Activities is published under the `sprintive/activities` Composer namespace
> (not `drupal/...`). Use the exact package name shown below.

## Install with Composer

From the project root:

```bash
composer require sprintive/activities -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required export
modules and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require sprintive/activities -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en activities -y
```

Or enable **Activities** from **Extend** (`/admin/modules`).

## Submodule — Activity Data Export

Activities ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Activity Data Export** | `activities_data_export` | A Views page listing the activity log with **CSV / XLS export**, built on the Views Data Export and XLS Serialization libraries. |

```bash
drush en activities_data_export -y
```

## Next steps

Activities logs **nothing** until you enable operations on the settings form. Continue to
[Configuration](../configuration/index.md).
