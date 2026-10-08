# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other modules are required, and there are no third-party Composer or PHP
  library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/fieldhelptext -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fieldhelptext -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fieldhelptext -y
```

## Grant the permission

The whole point of the module is its narrow permission. Go to **People →
Permissions** (`/admin/people/permissions`) and grant **`use fieldhelptext`** to the
roles that should edit field guidance — for example a content designer or technical
writer. This lets them improve help text without the broader field-administration
permissions that would also allow changing or deleting fields.

## Verify it worked

Log in as a user with `use fieldhelptext` and visit
`/admin/structure/fieldhelptext`. You should be able to choose an entity type and
bundle and land on the per-bundle help-text editor. See
[the overview](../index.md#how-to-use-it) for how to use the two editing screens.
