# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Link** module (`link`) enabled — this is the only dependency, and it is
  part of Drupal core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/external_link_a11y -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_link_a11y -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_link_a11y -y
```

## Verify it worked

The module provides a field formatter and a text-format filter. To confirm it is
available, either open a Link field's **Manage display** and look for the External
Link a11y formatter, or go to **Configuration → Content authoring → Text formats
and editors** and confirm the External Link a11y filter appears in the filter list
for a format.

Next, see the "How to use it" section of the [overview](../index.md) to wire it up
for fields and/or text formats.
