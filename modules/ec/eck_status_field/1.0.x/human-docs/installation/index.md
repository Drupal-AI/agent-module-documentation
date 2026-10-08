# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The **Entity Construction Kit** module (`eck`) — the only dependency.

Drupal will enable ECK automatically as a dependency. There are no third‑party
PHP library requirements.

> **On ECK 2.0**, this functionality is already built into ECK, so the module is
> not strictly necessary. If you're on or moving to ECK 2.0, see the upgrade note
> on the [overview page](../index.md) before installing or removing it — the steps
> matter to avoid data loss.

## Install with Composer

From the project root:

```bash
composer require drupal/eck_status_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eck_status_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eck_status_field -y
```

This also enables `eck` if it is not already on.

## Verify it worked

Go to **Structure → ECK entity types**, edit one of your entity types, and confirm
a **Published field** checkbox is now available. Tick it, save, and check that
entities of that type carry a published/unpublished status. If so, the module is
working.
