# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9||^10||^11||^12`).
- Core's **Field** module (`field`) — a dependency Drupal enables automatically.
- No third‑party Composer packages or PHP libraries.
- Field support is limited to **node**, **taxonomy term**, and **media**
  reference fields.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_field_create_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_field_create_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_field_create_link -y
```

## Verify it worked

Go to a node, taxonomy term, or media reference field's **Manage form display**.
The **Widget** dropdown should now include the create-link autocomplete widget.
Select it, save, then open an edit form for that bundle — the reference field
should show a link to the referenced entity type's creation page.
