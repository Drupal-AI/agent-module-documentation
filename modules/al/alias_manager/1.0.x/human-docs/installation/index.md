# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No third-party Composer or PHP libraries, and no other contrib modules are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/alias_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alias_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alias_manager -y
```

## Grant the permission

Alias Manager provides its own permission that controls who can see an entity's
alias list. Visit **People → Permissions** (`/admin/people/permissions`), find
the Alias Manager permission, and assign it to the roles that manage URLs (for
example editors or administrators). After that, the alias list appears on
entities for those users.
