# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **Views** module (enabled with core).
- Several **contributed modules**, which Composer pulls in for you:
  - **Token** (`token`, ≥ 1.11)
  - **Diff** (`diff`, ≥ 1.0) — provides the change visualisation
  - **Views Data Export** (`views_data_export`, ≥ 1.1)
  - **Views Bulk Operations** (`views_bulk_operations`, ≥ 4.1)

## Install with Composer

From the project root:

```bash
composer require drupal/elogger -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
bring in and align the Token, Diff, Views Data Export, and Views Bulk Operations
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elogger -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elogger -y
```

This enables Events Logger along with its dependencies.

## Verify it worked

Go to **Reports → Events Logger** (`/admin/reports/elogger`) — the logs listing
should load (empty at first). Then head to
[Configuration](../configuration/index.md) to choose which events to track;
once configured, make a tracked change and confirm an entry appears here.
