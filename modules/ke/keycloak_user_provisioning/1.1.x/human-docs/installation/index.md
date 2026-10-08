# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **User Provisioning** module (`user_provisioning`) — this module is a Keycloak
  provisioning method for it and enables it as a dependency.
- A **Keycloak server** and **admin API credentials** (a client that can manage
  users in your realm).

## Install with Composer

From the project root:

```bash
composer require drupal/keycloak_user_provisioning -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the User
Provisioning module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/keycloak_user_provisioning -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en keycloak_user_provisioning -y
```

Or enable **miniOrange Keycloak User Provisioning** on the **Extend** page
(`/admin/modules`). The User Provisioning module is enabled as a dependency.

## Verify it worked

Go to the **User Provisioning** configuration under **Configuration → People**. With
this module enabled, **Keycloak** should be available as a provisioning target/
method. See [Configuration](../configuration/index.md) to connect it. Once
connected, create a test user in Drupal and confirm it appears in your Keycloak
realm.
