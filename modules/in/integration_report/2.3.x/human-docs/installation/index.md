# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no module
dependencies beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/integration_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/integration_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en integration_report -y
```

To explore the framework with a working example, you can also enable the bundled
example submodule:

```bash
drush en integration_report_example -y
```

## Grant the permission

The report page is gated by the restricted **access integration report**
permission. Go to **People → Permissions** and grant it to the roles that should
see the page.

## Verify it worked

Go to **Reports → Integrations** (`/admin/reports/integrations`). The page loads,
though it will be empty until a report class is registered (the example submodule
provides one). To add your own checks, see "How to use it" in the
[overview](../index.md#how-to-use-it).
