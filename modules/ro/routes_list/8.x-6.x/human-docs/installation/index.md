# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/routes_list -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/routes_list -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en routes_list -y
```

## Permissions — don't skip this

The report is gated by a dedicated **access routes list** permission. Because the
report is a complete map of your site's URL surface — useful to attackers as well
as developers — grant this permission at **People → Permissions** only to trusted
developers and administrators. Don't leave it granted broadly, and consider
reviewing who has it periodically.

## Verify it worked

Log in as a user with the **access routes list** permission and go to **Reports →
Routes list** (`/admin/reports/routes-list`). You should see the full list of
registered routes with their paths, controllers, and access information.
