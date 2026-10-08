# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- **PHP 8.1 or higher.**
- No third-party Composer or PHP libraries, and no other contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/role_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_classes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_classes -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Role Classes**
(`/admin/config/system/role-classes`). Enter a class name next to a role, save, and
clear caches. Then view a page as a user in that role and inspect the `<body>` tag —
your class should be present. See *How to configure it* on the
[overview page](../index.md) for the details.
