# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9.0`).
- Core's **Migrate** module (`migrate`).
- The **Organic Groups** module (`og`).

Both dependencies are required. There are no third‑party Composer libraries or
special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/og_migrate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will pull in Organic Groups if it isn't present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/og_migrate -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en og_migrate -y
```

This also enables core Migrate and Organic Groups if they aren't already on. You'll
usually enable the **Migrate Drupal** module too, as part of the wider upgrade
workflow.

## Verify it worked

The module has no page of its own; success is simply that its migration process
plugins become available to the Migrate framework. Run your OG migration on a copy
of the site and confirm that groups and memberships arrive intact. See the
[guide overview](../index.md) for the workflow.
