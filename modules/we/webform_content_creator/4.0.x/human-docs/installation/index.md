# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Webform** module (`webform`) enabled — this is the one required dependency,
  and Drupal enables it automatically when you turn on Webform Content Creator.

Two features are optional and only needed if you use them:

- The **Encrypt** module — required only if you want to encrypt mapped values with
  an encryption profile.
- The **Token** module is handy for browsing available tokens, though token
  replacement itself works with core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_content_creator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/webform_content_creator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_content_creator -y
```

This also enables Webform if it isn't already on. After enabling, grant the
**Access Webform Content Creator configuration** permission to the roles that should
manage mappings, then head to
[Configuration](../configuration/index.md) to create your first one.

This module ships no submodules.
