# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — a hard dependency, always present on a
  standard Drupal install. Core's **Field UI** is needed to configure fields
  through the admin interface.

There are no third‑party Composer or PHP library requirements, and the module is
covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/formatter_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/formatter_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en formatter_field -y
```

## Verify it worked

There is no admin settings page. To confirm the module is available, go to a
content type's **Manage fields**, click **Add field**, and check that a
**Formatter field** field type is offered. Once you can add one and point it at
another field, the module is installed — see [the overview page](../index.md) for
the full setup walkthrough.
