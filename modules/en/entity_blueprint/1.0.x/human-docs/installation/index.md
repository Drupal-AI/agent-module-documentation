# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- No required module dependencies and no third‑party Composer or PHP library
  requirements for the base module.

The optional **Entity Blueprint AI** submodule integrates with the Drupal AI module,
so you would install/enable that ecosystem separately if you want the AI tooling.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_blueprint -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_blueprint -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_blueprint -y
```

## Submodules

The base module is the data layer; optional submodules — all currently
**experimental** — add AI tooling and config-entity support on top. The most notable
is **Entity Blueprint AI** (`entity_blueprint_ai`), which exposes the serialization
and CRUD operations as function-call tools (prefixed `eb_`) for the Drupal AI module
and adds an admin settings form to hide specific entity types and bundles from AI.
Enable a submodule only when you need it, for example:

```bash
drush en entity_blueprint_ai -y
```

Because these submodules are experimental, treat them accordingly on production
sites.

## Verify it worked

The base module is a developer-facing serialization layer, so there is no front-end
change to observe. Confirm it is enabled with `drush pm:list --status=enabled | grep
entity_blueprint`. From there, its services are available for code (and, if you
enabled Entity Blueprint AI, its tools become available to the Drupal AI module and
its settings form appears in the admin UI).
