# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no module
dependencies. Note the project is *minimally maintained* and not covered by
Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/clean_maintenance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clean_maintenance -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en clean_maintenance -y
```

That is the entire setup — there is no settings form. The maintenance message and
mode come from Drupal's core Maintenance mode settings at
`/admin/config/development/maintenance`.

## Verify it worked

Put the site into maintenance mode (Configuration → Development → Maintenance mode)
and view it as an anonymous visitor — for example in a private/incognito browser
window. You should see the module's cleaner maintenance page showing your site name
and the configured message, rather than the plain default screen.
