# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required — it depends only on Drupal core. The **Field UI**
  core module is what you use to select the formatter on *Manage display*.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_crud_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_crud_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_crud_display -y
```

## Verify it worked

Go to the **Manage display** page of a bundle with an entity reference field (for
example **Structure → Content types → Article → Manage display**). Open the
**Format** dropdown for that field — **Entity Reference CRUD Display** should now
be selectable. Choose it and save, then grant the module's permissions on
**People → Permissions** and view the host entity: authorized users should be
able to create, edit, and delete referenced entities inline via AJAX.
