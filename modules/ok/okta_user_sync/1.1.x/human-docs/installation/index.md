# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **User Provisioning** module (`user_provisioning`) — required; it provides the
  provisioning layer this module drives from Drupal's user CRUD hooks.
- An **Okta org** and an **Okta API token** (created in your Okta admin console) so
  Drupal can call the Okta API.

## Install with Composer

From the project root:

```bash
composer require drupal/okta_user_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the User Provisioning module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/okta_user_sync -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en okta_user_sync -y
```

This also enables User Provisioning if it isn't already on.

## Verify it worked

Go to **Configuration → People → Okta User Sync**
(`/admin/config/people/okta_user_sync`) and confirm the admin area loads with its
overview and tabs. From there, enter your Okta connection details and test the
connection, as described in [Configuration](../configuration/index.md).
