# Installation

## Requirements

Atoms needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/atoms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/atoms -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en atoms -y
```

Enabling the module makes the **Content → Atoms** overview and the settings form
available, and picks up any atom definitions shipped by modules on your site.

## Optional submodule — Atoms Media Library

If you want a **media** atom type (referencing media entities), enable the bundled
submodule:

```bash
drush en atoms_media_library -y
```

It requires the base Atoms module, which is already present once you have installed
it above. See the [overview guide](../index.md#how-to-use-it) for declaring atoms in
code and rendering them in Twig.
