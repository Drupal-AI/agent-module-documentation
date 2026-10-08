# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: ^8.1`).
- An **Acquia Cloud environment** with Varnish in front of it — that is what the
  module purges.

It has no Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_purge_varnish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_purge_varnish -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_purge_varnish -y
```

There is also an optional **`acquia_purge_varnish_test`** submodule for testing the
integration — enable it only when you are exercising the module in a test setup, not
on a live site.

## Grant the purge permission

The module adds one permission, **Administer Acquia Purge Varnish**, which is
access-restricted because a purge affects the live cache:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant *Administer Acquia Purge Varnish* to the roles that should be allowed to
   purge — for example a release-manager role that needs purge rights without full
   site administration.
3. Save.

## Point it at the right environment

Before you rely on it, open the purge form (`acquia_purge_varnish.form`) and set the
**per-environment details** so both the form and the Drush commands target the
intended Acquia environment. Getting this right is what prevents a purge meant for
staging from clearing production — see the [overview](../index.md) for why that
matters.

## Verify it worked

Log in as a user in a role that holds the purge permission, open the purge form,
confirm the environment it is pointed at, and run a purge. On Acquia Cloud the
targeted Varnish cache should clear.
