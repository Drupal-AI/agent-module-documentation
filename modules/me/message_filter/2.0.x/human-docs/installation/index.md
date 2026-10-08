# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **PHP 8.1 or higher**.
- Only Drupal core's **System** module — no other contrib modules and no external
  libraries are required.

This project is not covered by Drupal's security advisory policy, so review it before
relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/message_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_filter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_filter -y
```

## Grant the permission

Filtering configuration is protected by a permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant **Administer message filter** to the roles
that should manage the rules (typically administrators only).

## Verify it worked

Log in as a user with the permission and visit **Configuration → System → Message
Filter** (`/admin/config/system/message-filter`). If the settings form loads, the
module is installed. Remember that nothing is filtered yet — head to
[Configuration](../configuration/index.md) to enable filtering and add rules.
