# Installation

## Requirements

- **Drupal 10.2+ or Drupal 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.2 or newer.**
- Core's **User** module (`user`) — part of every standard Drupal install, and
  enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements, and no billing
system is required — Membership Manager is payment-agnostic.

## Install with Composer

From the project root:

```bash
composer require drupal/membership_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/membership_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en membership_manager -y
```

## Verify it worked

Log in as an administrator and visit **`/admin/membership`**. You should be able
to create your first membership plan there. If you can reach that page and add a
plan, the module is installed and ready — continue to
[Configuration](../configuration/index.md) to set up plans, permissions, and
route protection.
