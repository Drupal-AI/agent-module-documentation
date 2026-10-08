# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core only — there are no other module dependencies and no third‑party
  Composer or PHP library requirements.
- Your source data must be exportable to a **UTF‑8 CSV** file.

## Install with Composer

From the project root:

```bash
composer require drupal/csv_importer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/csv_importer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en csv_importer -y
```

Or enable **CSV Importer** from **Extend** (`/admin/modules`).

## Grant the permission

CSV Importer defines a single, restricted permission — **Access CSV Importer**
(`access csv importer`) — that gates the import form, the history page, and the
revert action. Grant it only to trusted users at **People → Permissions**, since
importing can create or overwrite content and download remote files.

## Next steps

There is no settings form. Prepare a UTF‑8 CSV and run an import from **Content →
Import CSV** — see [How to use it](../index.md#how-to-use-it) on the overview page
for the CSV format and column‑mapping syntax.
