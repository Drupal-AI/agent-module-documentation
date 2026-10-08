# Installation

## Requirements

- **Drupal 9.2+, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The contrib **Redirect** module (`drupal/redirect`) — Redirect Bulk creates
  standard Redirect entities, so it depends on this module. Composer pulls it in.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_bulk -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Redirect
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redirect_bulk -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_bulk -y
```

This enables the `redirect` dependency too if it is not already on.

## Grant the permission

Redirect Bulk adds one permission, **Administer bulk redirects**, which gates both
the bulk form and the CSV importer. Grant it at **People → Permissions**
(`/admin/people/permissions`) to the roles that should be able to mass-create
redirects.

Note this permission is **not** flagged as restricted, so it *can* be granted to a
non-superadmin role — but because bulk redirects can point to arbitrary external
URLs, treat it as an administrative capability and give it only to trusted roles.

## Verify it worked

Go to **Configuration → Search and metadata → URL redirects**
(`/admin/config/search/redirect`). You should see **Add Bulk redirects** and
**Import CSV** action links. See the [overview](../index.md) for how to use each
screen.
