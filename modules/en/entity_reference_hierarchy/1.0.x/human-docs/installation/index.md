# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer packages or PHP libraries, and no module dependencies.
- Optional but complementary: **Entity Reference Revisions**, **Inline Entity
  Form**, and **Paragraphs**, all of which this module works with.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_hierarchy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_hierarchy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_hierarchy -y
```

## Verify it worked

Go to a bundle's **Manage fields** and add a new field. The field-type list
should now include the hierarchical entity-reference field this module provides.
Add it, then open an entity edit form — you should see a drag-and-drop interface
for nesting and ordering references, like the one core uses for taxonomy terms
and menu links.
