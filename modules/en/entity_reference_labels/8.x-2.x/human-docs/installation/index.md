# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **entity reference** support must be present (part of core).
- No third‑party Composer packages or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_labels -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_labels -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_labels -y
```

## Verify it worked

Edit an entity-reference field and open its settings. The **reference method**
(selection method) list should now offer **Default (Descriptive)**. Select it,
ensure the field uses an autocomplete widget on **Manage form display**, then
try the field on an edit form — the suggestions should read "Entity Label
[machine_name]". See the "How to use it" section of the [guide](../index.md) for
the full steps.
