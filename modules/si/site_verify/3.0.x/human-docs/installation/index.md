# Installation

## Requirements

Site Verification is self-contained:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third-party Composer or PHP libraries.
- No other contrib modules. If you want to use the **upload a verification file**
  shortcut on the add form, core's **File** module needs to be enabled (it usually is
  on a standard install).

## Install with Composer

From the project root:

```bash
composer require drupal/site_verify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_verify -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_verify -y
```

The module adds the verifications listing at
**Configuration → Search and metadata → Verifications**
(`/admin/config/search/verifications`) and two permissions.

## Grant permissions

Two permissions gate the module — decide who gets which:

- **Administer site verify** (`administer site verify`) — manage meta-tag
  verifications and view the listing.
- **Manage file based site verifications** (`manage file based site verifications`) —
  additionally manage the file type, which serves content at a root-relative path.
  Grant this only to trusted roles, since a file verification can serve arbitrary
  text at the site root.

Set these at **People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Log in as a user with the permission and visit
`/admin/config/search/verifications`. You should see the (initially empty)
verifications listing with an **Add site verification** button. From here, follow the
[Configuration](../configuration/index.md) guide to create your first verification.
