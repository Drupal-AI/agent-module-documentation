# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) — the only dependency, enabled automatically as
  needed.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/profile_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/profile_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en profile_manager -y
```

Drupal enables `node` at the same time if it isn't already on.

## Grant the permission

At **People → Permissions**, grant the permission that lets a site maintainer
enable Optional Modules to the appropriate role. Because Profile Manager is a
distribution/developer tool, the real setup happens as you define Optional Modules
inside your installation profile (see the [overview page](../index.md)).

## Verify it worked

After enabling, confirm the module's permission appears on **People →
Permissions** and can be granted. From there, the module's value comes from how
your profile defines and manages Optional Modules rather than from an admin
settings screen.
