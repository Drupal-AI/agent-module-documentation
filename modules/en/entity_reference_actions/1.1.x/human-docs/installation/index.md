# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's entity‑reference and action systems, which are part of standard Drupal —
  the module builds on the reference field widgets and the action plugins already
  in core (and any provided by contrib modules you have).

There are no other module dependencies, and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_actions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_actions -y
```

There are no submodules and no global configuration. The feature stays dormant
until you switch it on for a specific entity‑reference field widget on its
*Manage form display* tab — see the **How to use it** section of the
[overview](../index.md).
