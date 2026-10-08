# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`). The module is designed for Drupal 10.
- No third‑party Composer or PHP library requirements, and no module dependencies.

## Install with Composer — as a development dependency

Because caches can hold sensitive data, install Cache browser as a **development
dependency** rather than a production one:

```bash
composer require --dev drupal/cache_browser
```

Installing with `--dev` keeps it out of your production dependency set. If you understand
the risks and genuinely need it elsewhere, the ordinary `composer require
drupal/cache_browser -W` also works — but the maintainers recommend against putting it on
a production site at all.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/cache_browser`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_browser -y
```

## Grant the permission carefully

Cache browser adds one permission, **Access cache browser**, which is marked as
restricted. Treat it as equivalent to granting access to user 1, because the tool can
reveal sensitive and personally identifiable data stored in caches. Grant it only to fully
trusted administrators, at **People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Go to **Reports → Cache** (`/admin/reports/cache`). You should see a summary listing the
site's cache bins. Click into a bin to browse its entries, open an entry by its CID to
inspect its contents, or clear a bin. If you cannot reach the page, confirm your account
has the *Access cache browser* permission.
