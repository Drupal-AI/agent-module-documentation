# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4||^10||^11`).
- No required contrib dependencies.
- **Optional:** the [Diff](https://www.drupal.org/project/diff) module, if you
  want to compare EcoIndex scores between content revisions.

There are no third‑party PHP library requirements. (The scoring uses the
open‑source EcoIndex/GreenIT‑Analysis algorithm.)

> **Note:** this is an unofficial module from the Green IT association and this
> release is a **beta**. Test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/ecoindex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add revision comparison, also require the Diff module:

```bash
composer require drupal/diff -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ecoindex -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ecoindex -y
```

If you installed Diff for revision comparison, enable it too:

```bash
drush en diff -y
```

## Verify it worked

Visit the EcoIndex settings page under **Configuration** (the `ecoindex.settings`
route) to confirm the module is installed, then add an **ecoindex** field to a
content type and check that the **Refresh EcoIndex score** action appears on the
content edit form. If it does, the module is working — continue to
[Configuration](../configuration/index.md).
