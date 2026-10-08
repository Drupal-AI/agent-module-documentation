# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Entity Construction Kit** module (`eck`) — the only dependency.

Drupal will enable ECK automatically as a dependency. There are no third‑party
PHP library requirements, and the module has no configuration to set.

## Install with Composer

From the project root:

```bash
composer require drupal/eck_bundle_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eck_bundle_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eck_bundle_permissions -y
```

This also enables `eck` if it is not already on.

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`) and look for the
per‑bundle ECK permissions — create/edit/delete/view (and the "own" variants for
entity types with an author field) for each of your ECK bundles. If they're
listed, the module is working; grant them to your roles as needed. Remember that
until you grant them, no role can act on those bundles.
