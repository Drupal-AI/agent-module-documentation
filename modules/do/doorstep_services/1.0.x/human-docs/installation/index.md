# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules **Node** (`node`), **User** (`user`), and **Views** (`views`) —
  enabled in a standard install.
- The contributed **SMTP** module
  ([drupal.org/project/smtp](https://www.drupal.org/project/smtp)) — required so
  the module's notification and PDF‑bill emails can be sent.
- The **TCPDF** PHP library
  ([tecnickcom/tcpdf](https://packagist.org/packages/tecnickcom/tcpdf)) —
  required for generating PDF bills.

## Install with Composer

From the project root:

```bash
composer require drupal/doorstep_services -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Also make sure the SMTP module and the TCPDF library are
installed; you can add TCPDF explicitly if it is not already present:

```bash
composer require drupal/smtp tecnickcom/tcpdf -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/doorstep_services -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en doorstep_services -y
```

Enable and configure the **SMTP** module as well, so outgoing mail works.

## Verify it worked

Visit **`/doorstep-services/register`** and confirm the registration form loads.
Submit a test request and check that a notification email is sent (this confirms
SMTP is wired up). As an administrator, open **`/admin/service-requests`**,
confirm the request appears, update its status, and generate a PDF bill to confirm
TCPDF is available.
