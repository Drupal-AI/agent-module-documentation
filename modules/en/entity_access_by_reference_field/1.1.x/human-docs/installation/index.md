# Installation

## Requirements

- **Drupal 10.2 or newer** (`core_version_requirement: >=10.2`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

The module relies on entity-reference fields, which core provides, so you just need
an entity type with (or ready to receive) a reference field to attach the check to.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_access_by_reference_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_access_by_reference_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_access_by_reference_field -y
```

## Verify it worked

Enabling the module alone changes nothing on your site — it only adds settings to
entity-reference fields. To confirm it is active, edit an entity-reference field
(**Structure → (entity type) → Manage fields → (a reference field) → Edit**) and
look for the module's access settings on the field configuration form. Remember
that you must set the field's fallback to **Forbidden** for the check to actually
restrict access; see the [overview](../index.md) for the full explanation.
