# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No modules outside Drupal core.

There are no third‑party Composer or PHP library requirements.

> **Before you enforce anything:** because a wrong IP rule can lock every admin
> out, make sure you know how to recover — for example by editing configuration
> via `drush config:edit` or the database — before you save restrictive rules.

## Install with Composer

From the project root:

```bash
composer require drupal/control_admin_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/control_admin_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en control_admin_access -y
```

## Verify it worked

Go to **Configuration → System → Control admin access**
(`/admin/config/system/control-admin-access`). You should see the settings form
with two fields — one for allowlisted IPs and one for the URLs to block. Leave the
fields empty until you have read [Configuration](../configuration/index.md), since
saving the wrong values can restrict your own access.
