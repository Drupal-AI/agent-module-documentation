# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP library
  requirements. (The reference scanning relies only on core's entity and field system.)

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_integrity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_integrity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_integrity -y
```

On its own, the base module only provides the dependency-inspection API — it changes no
behaviour and has no configuration or admin UI.

## Enable deletion protection (the Enforce submodule)

If you want the practical "you can't delete this, it's still referenced" behaviour, also enable
the bundled submodule, which consumes the base module's handler and blocks such deletions:

```bash
drush en entity_reference_integrity_enforce -y
```

With the Enforce submodule on, attempting to delete an entity that is still the target of an
entity-reference field is prevented, with a message explaining it is in use. See the Enforce
submodule's own documentation for how to choose which entity types it protects.
