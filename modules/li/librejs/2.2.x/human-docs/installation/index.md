# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- No other modules and no third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/librejs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/librejs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en librejs -y
```

There are no submodules. On this core version LibreJS requires no configuration —
libraries carry their own licence metadata in `*.libraries.yml`.

## Grant the permission

Under **People → Permissions** (`/admin/people/permissions`), grant **Access
JavaScript license information** to the roles that should be able to view the
JavaScript licence list at `/librejs/jslicense`.

## Verify it worked

1. Confirm **LibreJS** is enabled on **Extend** (`/admin/modules`).
2. Browse a few pages of the site, then visit `/librejs/jslicense` as a user with
   the permission — you should see the JavaScript files detected so far, with their
   licences and source URLs.
3. Optionally, load a page with the GNU LibreJS browser extension installed and
   confirm your free JavaScript is accepted.

There is no configuration step beyond granting the permission — see the module's
[main page](../index.md).
