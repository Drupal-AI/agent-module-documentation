# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core only — no other module dependencies and no third-party PHP libraries.
- A valid **assistant ID** from **Neuraflow GmbH**, which requires an active
  contract with them. The neurabot integration will not run without it.

## Install with Composer

From the project root:

```bash
composer require drupal/neuraflow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/neuraflow -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en neuraflow -y
```

## Grant the permission

Assign the **`administer neuraflow`** permission to trusted administrators at
**People → Permissions** (`/admin/people/permissions`) so they can configure the
integration.

## Verify it worked

Visit **Configuration → Web services → Neuraflow**
(`/admin/config/services/neuraflow`). If the settings form loads, the module is
installed. The assistant does not appear to visitors until you enter your assistant
ID and display settings — see [Configuration](../configuration/index.md).
