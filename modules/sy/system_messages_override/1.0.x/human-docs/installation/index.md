# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No dependent Drupal modules are required.
- The core **Database Logging** (dblog) module is optional but recommended if you
  want to use the module's **Debug** feature to capture exact message strings.
- No PHP extensions or external Composer libraries are listed as required.

## Install with Composer

From the project root:

```bash
composer require drupal/system_messages_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/system_messages_override -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en system_messages_override -y
```

## Grant the permission

The module provides its own restricted-access permission for managing the overrides.
At **People → Permissions** (`/admin/people/permissions`), grant it only to trusted
administrator roles.

## Verify it worked

Visit **Configuration → System → Messages override**
(`/admin/config/system/messages-override`) and confirm the form loads. See
[Configuration](../configuration/index.md) to add your first message override.
