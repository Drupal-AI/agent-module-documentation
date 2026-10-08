# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 7.3 or newer** (`php: >=7.3`).
- A **tawk.to account** with at least one property/widget set up — you select the
  widget during configuration.
- No contrib dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/tawk_to -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tawk_to -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tawk_to -y
```

## Grant the permission

All of the tawk.to admin screens require the **"administer tawk_to settings"**
permission (restrict-access). Assign it to trusted administrators at **People →
Permissions** (`/admin/people/permissions`).

## Verify it worked

Go to **Configuration → Web services → Tawk.to**
(`/admin/config/services/tawk_to`). You should reach the tawk.to settings area.
The widget won't appear on the site until you select one — see
[Configuration](../configuration/index.md).
