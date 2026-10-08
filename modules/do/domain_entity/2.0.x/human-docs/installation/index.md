# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Domain** module (`drupal/domain`, `^2.0@beta || ^3`) and its **Domain
  Access** submodule (`domain_access`) — this module builds directly on Domain's
  per-domain model. Composer installs Domain for you, and Drupal enables
  `domain` and `domain_access` as dependencies.
- No third-party PHP libraries are required.

You should already have a working multi-domain setup (your affiliate domains
configured under the Domain module) before enabling this.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Domain module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_entity -y
```

Drupal enables the required Domain modules automatically.

## Submodule — enable if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Domain Menu Access** | `domain_menu_access` | Applies the same per-domain access to **menu links**, so a menu item can be scoped to specific domains. |

Enable it only if you need per-domain menu links:

```bash
drush en domain_menu_access -y
```

Once enabled, configure which entity types become domain-aware — see
[Configuration](../configuration/index.md).
