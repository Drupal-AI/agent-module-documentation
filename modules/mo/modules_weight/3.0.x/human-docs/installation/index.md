# Installation

## Requirements

Modules Weight needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

It has **no module dependencies** and needs no third‑party Composer libraries or
special PHP extensions.

## Install with Composer

From the project root:

```bash
composer require drupal/modules_weight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/modules_weight -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en modules_weight -y
```

Then grant the **Administer modules weight** permission to the administrators who
should use it.

## Submodules

This module ships no submodules — the base module is everything.

## Verify it worked

Go to **Configuration → System → Modules Weight**
(`/admin/config/system/modules-weight`). You should see a list of modules with
editable weight fields. See the [overview](../index.md#how-to-use-it) for how to
reorder them and for the Drush commands.
