# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An **entity reference** field to apply the formatter to (entity reference is
  provided by Drupal core).

There are no third‑party Composer or PHP library requirements, and no contributed
module dependencies.

## Install with Composer

Note that the **project (Composer) name differs from the machine name**. The
Composer package is `drupal/reference_as_field` (singular), while the module you
enable is `reference_as_fields_formatter`.

From the project root:

```bash
composer require drupal/reference_as_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/reference_as_field -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reference_as_fields_formatter -y
```

## Verify it worked

Go to the **Manage display** tab of an entity type that has an **entity
reference** field (for example **Structure → Content types → *(your type)* →
Manage display**). The format dropdown for that field should now offer **Entity
Reference as fields**. Select it and view the host entity — the referenced
entity's fields should render inline among the host's own fields rather than as a
nested block.
