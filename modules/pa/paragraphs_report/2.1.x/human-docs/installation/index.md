# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2.0 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`, version `^1.10`) — the module this
  one reports on.
- Core's **Path alias** module, enabled automatically as a dependency.

Composer pulls in Paragraphs automatically if it is not already present.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_report -y
```

You can also enable it from **Extend** (`/admin/modules`).

## What happens next

The report page appears under **Reports → Paragraphs Report**, but it is **empty until
you choose content types and build it**. Head to
[Configuration](../configuration/index.md) to select which content types to scan, then
run the update. Do not forget to grant the relevant permissions to the roles that
should see or rebuild the report.
