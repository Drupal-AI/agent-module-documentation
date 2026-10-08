# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.
- **Outbound network access** from the server, since the module downloads library
  files from the internet in order to host them locally.

## Install with Composer

From the project root:

```bash
composer require drupal/assetfetcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/assetfetcher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en assetfetcher -y
```

After enabling, grant the module's permission (**People → Permissions**) to the
administrators who should manage it, then let it fetch and localise the external
libraries — see [How to use it](../index.md#how-to-use-it). Run the fetch on an
environment that is allowed to make outbound requests.

This module has no submodules.
