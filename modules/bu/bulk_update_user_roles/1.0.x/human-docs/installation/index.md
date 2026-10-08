# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **User** module (always present in a standard install).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_update_user_roles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bulk_update_user_roles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_update_user_roles -y
```

After enabling, use the form at `/admin/config/people/bulk-update`. Grant the
`administer users` permission only to trusted staff who should be able to change
role membership in bulk.
