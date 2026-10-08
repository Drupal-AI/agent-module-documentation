# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: ^8.1`).
- Core's **Node** module (`node`), which is part of standard Drupal.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/prevent_homepage_deletion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prevent_homepage_deletion -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prevent_homepage_deletion -y
```

As soon as it is enabled, the nodes set as your **front page**, **404**, and
**403** pages are protected against deletion and unpublishing — with no further
configuration.

## Grant the permission

By default, *nobody* (except users with core's *Bypass content access control*
permission, and user 1) can delete a protected page. If a trusted role should be
able to, grant them the **Delete homepage node** permission:

```bash
drush role:perm:add site_owner delete_homepage_node
```

Or in the UI, go to **People → Permissions** (`/admin/people/permissions`), find
**Delete homepage node**, tick it for the role that should keep the ability, and
save. Grant it sparingly — usually to just one "site owner" role.

## Next steps

To protect additional pages beyond the front/404/403 nodes, add them on the
settings form — see [Configuration](../configuration/index.md).
