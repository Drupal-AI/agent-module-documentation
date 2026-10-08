# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contributed **[Entity Reference Revisions](https://www.drupal.org/project/entity_reference_revisions)**
  module (`entity_reference_revisions`) — the field type this formatter works on
  (also the foundation of Paragraphs). Composer pulls it in automatically when you
  require this module with the `-W` flag below.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_revisions_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and download the
**Entity Reference Revisions** dependency along with this module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_revisions_context -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_revisions_context -y
```

Drupal will enable the **Entity Reference Revisions** dependency at the same time.

## Verify it worked

Go to **Structure → Content types → *(a type with a Paragraphs field)* → Manage
display**. Open the **Format** dropdown for that field — the Entity Reference
Revisions Context formatter should now appear as an option. Selecting it and
saving, then inspecting the rendered markup for `data-entity-context-*`
attributes, confirms the module is working.
