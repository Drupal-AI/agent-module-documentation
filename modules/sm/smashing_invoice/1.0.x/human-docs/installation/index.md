# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`). It does
  not declare Drupal 11 support.
- The **TCPDF** PHP library (`tecnickcom/tcpdf`) — required to render the invoice
  PDFs. Install it with Composer (below).
- No dependent Drupal modules.

Please also note the project is marked **unsupported/obsolete** and is **not**
covered by Drupal's security advisory policy — see the caution in the
[main guide](../index.md).

## Install with Composer

From the project root, install both the module and the TCPDF library:

```bash
composer require drupal/smashing_invoice -W
composer require tecnickcom/tcpdf
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smashing_invoice -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smashing_invoice -y
drush cr
```

Clearing the cache is important here — the **Invoice service** toolbar item only
appears after a cache rebuild.

## Set up permissions

Grant the single **administer smashing_invoice** permission at **Administration →
People → Permissions** to the roles that should manage invoicing. This one
permission gates every page in the module, including reading and downloading all
clients' invoices and financial data, so keep it tightly scoped to trusted staff.

## Verify it worked

Log in as a user with the permission, clear the cache if you have not already, and
look for the **Invoice service** item in the admin toolbar (or visit `invoice/links`
directly). From there, continue to [Configuration](../configuration/index.md) to set
up your organization details.
