# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements.
- **Before you enable it:** ensure at least one *named* account (not user 1) already
  holds the administrator role and you can log in with it. This module removes
  password login for user 1, so this step is what stops you locking yourself out.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_denied -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_denied -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_denied -y
```

There is no configuration form. On the next cron run, user 1's username and password
are randomized, disabling password login for that account. Make sure cron is running
on your site so the protection takes effect.
