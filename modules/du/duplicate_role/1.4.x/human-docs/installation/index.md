# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- Core's **User** module (always present).
- No contrib dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/duplicate_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/duplicate_role -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en duplicate_role -y
```

## Grant the permission

The Duplicate operation and form only appear for users with the **"administer
duplicate role"** permission. This is a **restrict-access** permission (it lets a
user create roles), so grant it only to trusted administrators — typically the
same people you'd trust with role and permission administration. Assign it at
**People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Go to **People → Roles** (`/admin/people/roles`). Each role's operations dropdown
should now include **Duplicate**, and a **Duplicate role** action link should
appear on the page. See [Configuration](../configuration/index.md) for how to use
it.
