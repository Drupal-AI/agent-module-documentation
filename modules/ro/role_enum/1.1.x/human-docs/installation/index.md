# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- Core's **User** module (`user`), part of a standard Drupal install.
- No third-party Composer or PHP libraries.
- A custom module of your own to hold the role enums — this is a developer tool you
  consume from code.

## Install with Composer

From the project root:

```bash
composer require drupal/role_enum -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_enum -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_enum -y
```

## Verify it worked

Add a role enum to your custom module (implementing the module's
`ConfigBackedRoleInterface`), then run `drush deploy` or `drush cim`. Check
**People → Roles** and confirm the roles from your enum now appear. See *How to use
it* on the [overview page](../index.md) and the module's `README.md` for the enum and
attribute syntax.
