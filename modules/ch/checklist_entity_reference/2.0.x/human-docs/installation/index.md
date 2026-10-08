# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's entity reference and field system, which ships with Drupal.

There are no additional module dependencies, and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/checklist_entity_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/checklist_entity_reference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en checklist_entity_reference -y
```

## Verify it worked

Open a bundle's **Manage form display** tab. The checklist (checkboxes) widget
should now be available for entity-reference fields, and a **Checklist Progress**
pseudo-field should appear in the list of elements you can drag into the form.
Add an entity-reference field, set that widget, and the referenced items will
render as a tickable checklist on the add/edit form.
