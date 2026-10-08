# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other modules are required, and there are no third-party Composer or PHP
  library requirements — the signature-pad drawing library is bundled with the
  module.

## Install with Composer

From the project root:

```bash
composer require drupal/signaturefield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/signaturefield -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en signaturefield -y
```

There is no settings form to visit afterwards. You add signature capture as a
**field** on the entity where you want it — see the main guide's
[How to use it](../index.md#how-to-use-it) section. Please review the module's
own README for any additional detail.
