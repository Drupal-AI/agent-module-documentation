# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Views**, **REST**, **Serialization**, **Comment**, **Path**, and
  **Basic Auth** modules. Views and REST are the primary dependencies; the module
  also builds on the others (for example it installs its own comment type for
  transaction discussion threads).
- The contributed **Views Bulk Operations**
  (`views_bulk_operations`) module — Composer installs this for you.

The module has **zero external PHP library dependencies**, so nothing extra needs
to be installed beyond the modules above.

## Install with Composer

From the project root:

```bash
composer require drupal/expense_tracker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Views Bulk
Operations and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/expense_tracker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en expense_tracker -y
```

This also enables its dependencies, creates the `et_transaction` entity's database
tables, and installs the transaction comment type.

## Set permissions

Because transactions hold sensitive financial data, configure access right away.
Go to **People → Permissions**, find the Expense Tracker permissions, and grant
them only to the roles that should view or manage financial records. If you plan to
use the REST API, make sure those endpoints are permission‑gated and served over
HTTPS.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep expense_tracker
```

Then visit **Content → Import Transactions** to confirm the import page (and its
downloadable sample files) is available, and add a test transaction through the add
form. See the "How to use it" section of the [overview](../index.md) for the full
workflow.
