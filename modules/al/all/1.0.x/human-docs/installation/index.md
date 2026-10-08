# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third-party Composer or PHP libraries, and no other contrib modules are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/all -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/all -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en all -y
```

## Assign the permission

All provides a single **Administer all** permission that governs access to its
bulk content-type editing page. Go to **People → Permissions**
(`/admin/people/permissions`) and grant it only to trusted site builders, because
it can change settings across many content types at once.
