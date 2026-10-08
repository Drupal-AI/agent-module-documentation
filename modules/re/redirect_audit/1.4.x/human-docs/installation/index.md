# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contrib **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect ^1.0`) — Redirect Audit works on the redirects Redirect manages, so
  it is required. Composer pulls it in with the `-W` flag below.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Redirect
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect_audit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_audit -y
```

Drupal enables the Redirect module automatically as a dependency if it is not
already on.

## Grant the audit permission

Redirect Audit adds its own **administer redirect audit** permission, separate
from Redirect's own permissions. Grant it on **People → Permissions**
(`/admin/people/permissions`) to the roles that should run audits — you can give
this to an SEO role without also granting them the ability to edit redirects.

## Verify it worked

Visit the dashboard at `/admin/config/search/redirect/audit`. It should load and
show summary statistics (initially empty until you run a scan). Review the audit
[Configuration](../configuration/index.md) before running your first scan on a
large redirect table.
