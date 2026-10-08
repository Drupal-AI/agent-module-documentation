# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- This module requires no modules outside of Drupal core.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/json_resolver -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/json_resolver -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_resolver -y
```

## Grant the permission

Give the **Administer JSON Resolver** permission to the roles that should manage
templates and the token map, at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Go to **Configuration → System → JSON Resolver Settings**
(`/admin/config/system/json-resolver`). You should see the token map and template
management UI described in [Configuration](../configuration/index.md). Add a small
template, then have a custom module call the `json_resolver.resolver` service to
confirm placeholders are replaced as expected.
