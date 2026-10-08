# Installation

## Requirements

Term ID to Name has essentially no requirements beyond Drupal itself:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module at runtime (that's what provides the terms the
  function looks up).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tid_to_name -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tid_to_name -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tid_to_name -y
```

Once enabled, the `tn()` function is available in every Twig template
immediately — see [How to use it](../index.md#how-to-use-it). There is no
configuration to do and no submodules.
