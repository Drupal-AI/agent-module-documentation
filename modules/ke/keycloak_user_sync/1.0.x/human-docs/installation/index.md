# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or higher.**
- Core's **User** module (`user`) — always present.
- A **Keycloak server** (tested with version 26.x) and a **client with credentials**
  that can manage users in your realm.
- *Optional:* the **Profile** module, if you want to map profile fields as well as
  user account fields.

## Install with Composer

From the project root:

```bash
composer require drupal/keycloak_user_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/keycloak_user_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en keycloak_user_sync -y
```

Or enable **Keycloak User Sync** on the **Extend** page (`/admin/modules`).

## Verify it worked

Go to **Configuration → People → Keycloak User Sync**
(`/admin/config/people/keycloak-user-sync`). If the field‑mapping form loads, the
module is installed. Next, add the connection and credentials to `settings.php` and
configure the mappings as described in [Configuration](../configuration/index.md),
then create a test user in Drupal and confirm it appears in your Keycloak realm.
