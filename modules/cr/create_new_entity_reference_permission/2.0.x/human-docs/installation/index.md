# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's entity-reference functionality (part of core's Field module) — no contributed
  module dependencies.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/create_new_entity_reference_permission -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/create_new_entity_reference_permission -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en create_new_entity_reference_permission -y
```

## Verify it worked

1. Take an entity-reference field whose handler is set to **"Create referenced
   entities if they don't already exist"**.
2. On that bundle's **Manage form display**, confirm the widget **"Autocomplete (with
   new entity permission)"** is available and select it.
3. At **People → Permissions**, confirm the **"Create new autocomplete referenced
   entity"** permission is present.
4. Log in as a role **without** that permission and confirm the field's autocomplete
   only offers existing entities (no new one is created); then grant the permission to
   a trusted role and confirm inline creation works. See the [overview](../index.md)
   for the full setup.
