# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Admin Toolbar** module (`admin_toolbar`) — this is a dependency, because the
  module adds its flush link to the admin toolbar. Composer will pull it in
  automatically.

There are no third‑party Composer or PHP library requirements. Note the project is
*minimally maintained* and not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/clearphpcaches -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Admin Toolbar if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clearphpcaches -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en clearphpcaches -y
```

## Grant the permission

The flush action is gated by the **`clear php caches`** permission. Assign it only
to trusted administrator roles under **People → Permissions** — clearing OPcache
briefly affects performance while PHP recompiles, so it should not be widely
available.

## Verify it worked

Log in as a user with the `clear php caches` permission and look for the flush link
the module adds to the admin toolbar. Clicking it (which calls
`/admin/flush/phpcaches`) should clear PHP's OPcache/APC and return you with a
confirmation.
