# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib module dependencies, third‑party Composer packages, or external
  libraries beyond Drupal core.

> **Security coverage:** this project is **not covered** by Drupal's security
> advisory policy at the time of writing. Because exports can contain sensitive
> configuration values, restrict the module's permission to trusted
> administrators.

## Install with Composer

From the project root:

```bash
composer require drupal/content_type_config_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_type_config_export -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_type_config_export -y
```

## Set the permission

The module provides its own permission for running exports. At **People →
Permissions** (`/admin/people/permissions`), grant it **only to trusted
administrator roles**, since an export can include sensitive configuration
values.

## Verify it worked

As a user with the export permission, open the module's **Content Export** page,
select a bundle (for example one of your content types), choose the fields to
include, and run an export. A successful run produces export output you can move
to another environment. Confirm your existing content types are unchanged — the
module only reads configuration, it does not modify it.
