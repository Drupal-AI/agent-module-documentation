# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other modules and no third‑party PHP libraries are required.
- Because it reads Composer‑installed dependency information, the module is most
  useful on a project managed with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/licenses -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/licenses -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en licenses -y
```

There are no submodules and no settings form to configure.

## Grant the permission

Under **People → Permissions** (`/admin/people/permissions`), grant the module's
licence‑information permission to the roles that should be able to view the
overview — usually an administrator or compliance role.

## Verify it worked

1. Confirm **Licenses** is enabled on **Extend** (`/admin/modules`).
2. As a user with the permission, open the Licenses overview page from the admin
   area — you should see the licences for your Composer dependencies, modules, and
   themes.

There is no configuration step; the module works as soon as it is enabled and the
permission is granted. See the module's [main page](../index.md).
