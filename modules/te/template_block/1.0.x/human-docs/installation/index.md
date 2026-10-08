# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  library requirements.

The **Twig Tweak** module is recommended (not required) — installing it lets your
Template Block templates embed views, blocks, fields, and entities.

## Install with Composer

From the project root:

```bash
composer require drupal/template_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/template_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en template_block -y
```

Enabling the module makes the **Template Block** block plugin available to place;
it does not render anything until you place a block and create its template. See
[Configuration](../configuration/index.md).

## Verify it worked

When placing a block (via Block Layout or Layout Builder), you should now find
**Template Block** in the list of available blocks.
