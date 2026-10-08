# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Monitoring** module (`monitoring ^1.11`) — required; the health endpoint
  publishes its sensor results.
- Third‑party Composer libraries, pulled in automatically:
  - `ohdearapp/ohdear-php-sdk ^4.4.0` (the Oh Dear PHP SDK),
  - `ohdearapp/health-check-results ^1.0`.

Because these are real Composer dependencies, install this module **with Composer** —
don't just drop it in the modules folder.

## Install with Composer

From the project root:

```bash
composer require drupal/ohdear_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Monitoring module and the Oh Dear SDK.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ohdear_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ohdear_integration -y
```

This also enables the Monitoring module if it isn't already on.

## Verify it worked

Confirm the settings page loads at **Configuration → System → Oh Dear settings**
(`/admin/config/system/ohdear-settings`). Once you've set a health‑check secret (see
[Configuration](../configuration/index.md)), the endpoint at
`/json/oh-dear-health-check-results` should return `403` *"Access denied!"* to an
anonymous request without the secret — that's the expected, secure behavior.
