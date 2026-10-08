# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). There is no
  Drupal 11 release of this module.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_notification -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_notification -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_notification -y
```

## After enabling

1. Go to **People → Permissions** (`/admin/people/permissions`) and grant
   **administer admin notification** to a trusted role.
2. Open the settings form at **Configuration → System → Admin notification**
   (`/admin/config/system/admin_notification`) and set up your message — see
   [Configuration](../configuration/index.md).
