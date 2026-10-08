# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Token** module (`drupal/token:^1.0`) — Custom breadcrumbs uses it for the
  Token replacements in crumb links and titles. Composer installs it for you.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_breadcrumbs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Token and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_breadcrumbs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_breadcrumbs -y
```

Drush enables the Token dependency automatically. There are no submodules.

## Grant the permission

Assign the *Administer custom breadcrumbs* permission to a trusted role at
**People → Permissions** (`/admin/people/permissions`) so someone can create and
manage trails:

```bash
drush role:perm:add site_builder 'administer custom_breadcrumbs'
```

## Verify it worked

Visit **Structure → Custom breadcrumbs**
(`/admin/structure/custom-breadcrumbs`). You should see the (initially empty) list
of breadcrumb definitions with an **Add** button. See
[Configuration](../configuration/index.md) to build your first trail.
