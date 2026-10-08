# Installation

## Requirements

Error Level Permission is lightweight and has no third‑party requirements:

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement:
  ^8.7.7||^9||^10||^11`).
- No contrib module dependencies and no PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/errorlevelpermission -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/errorlevelpermission -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en errorlevelpermission -y
```

## Assign the permission

Enabling the module is not enough on its own — you also need to decide which roles
may see errors:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant the module's "see errors" permission only to trusted roles (an
   administrator or a dedicated developer role).
3. Click **Save permissions**.

## Verify it worked

Log in as a user in a permitted role and, on a development environment, trigger a
notice or warning — you should still see it. Then view the same page as an
anonymous or unprivileged visitor (an incognito window works): they should **not**
see the error output. If both behave as expected, the permission gate is working.
