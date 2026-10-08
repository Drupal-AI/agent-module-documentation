# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php_requirement: 8.1`).

There are no third-party Composer library requirements. Note this project has
**no security advisory coverage**, so review it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/permission_turbo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/permission_turbo -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permission_turbo -y
```

## Verify it worked

Log in as a user with the **Administer permissions** permission and go to
**Administration → People → Permissions (Turbo)**
(`/admin/people/permissions-turbo`). The page should load quickly, with
permissions grouped into collapsible per-module sections and a search box at the
top. As a sanity check the first time, make a small permission change here, save,
and confirm on the core permissions page (`/admin/people/permissions`) that the
grant or revoke landed exactly as expected.
