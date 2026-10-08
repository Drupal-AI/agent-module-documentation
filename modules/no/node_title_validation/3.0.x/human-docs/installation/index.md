# Installation

## Requirements

- **Drupal 10.4+, 11, or 12** (`core_version_requirement: ^10.4 || ^11 || ^12`).
- Core's **Node** module (`node`) — this is the module's one dependency, and it is
  present on any site with content types.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_title_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/node_title_validation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_title_validation -y
```

## Grant the permission

The settings form is gated by the module's own permission, **Node title validation
admin control** (not the general "Administer content" permission). Grant it at
**People → Permissions** (`/admin/people/permissions`) to the roles that should
manage title rules — this lets you delegate rule management to content managers
without broader admin rights.

## Verify it worked

Log in as a user with the permission and open **Configuration → Content authoring →
Node Title Validation** (`/admin/config/content/node-title-validation`). If the
form loads, showing a section per content type, the module is ready. See
[Configuration](../configuration/index.md) to set your rules.
