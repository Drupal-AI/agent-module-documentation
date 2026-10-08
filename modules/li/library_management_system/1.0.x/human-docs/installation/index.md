# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Views Bulk Operations** (`views_bulk_operations`) — the admin list screens use
  it for bulk actions. Composer pulls it in for you.
- No third‑party PHP libraries are required.

> **Note on maintenance:** this project is *seeking co‑maintainers* and is **not**
> covered by Drupal's security advisory policy. Review it before using it on a
> high‑exposure production site.

## Install with Composer

From the project root:

```bash
composer require drupal/library_management_system -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Views Bulk Operations.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/library_management_system -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en library_management_system -y
```

Drupal will enable Views Bulk Operations at the same time. There are no
submodules.

## Verify it worked

1. Confirm **Library Management System** is enabled on **Extend**
   (`/admin/modules`).
2. As an administrator, confirm you can reach the admin list screens for books,
   publications, and authors and can add a record.
3. Create a test book, request it as another user, then issue it as staff — this
   exercises the request → issue circulation flow end to end.

Next, set up permissions, fines, and imports in
[Configuration](../configuration/index.md).
