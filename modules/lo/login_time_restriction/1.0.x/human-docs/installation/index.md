# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **[Time Range](https://www.drupal.org/project/time_range)** module
  (`time_range`), which supplies the date/time‑range field type used for each
  user's window. Composer pulls it in automatically as a dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/login_time_restriction -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Time Range and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/login_time_restriction -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_time_restriction -y
```

Drupal enables the Time Range dependency at the same time.

## Verify it worked

Log in as an administrator and open **`/admin/login_time_restriction/settings`** —
you should see the Login Time Restriction settings form. Then edit a test user
account: once you have granted that account's role the **Allow access time
modification** permission, an access‑time date/time‑range field appears on the
user edit form. Set a window in the past for the test user and confirm they can
no longer sign in outside it.
