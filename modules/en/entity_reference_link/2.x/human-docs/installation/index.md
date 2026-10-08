# Installation

## Requirements

Entity Reference Link is lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install
  and enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_link -y
```

## Verify it worked

Go to the *Manage display* page of any entity bundle that has an entity-reference
field (for example **Structure → Content types → Article → Manage display**). Open
the **Format** dropdown for that field — you should now see **Entity Reference
Custom Link** among the options. Selecting it and configuring the link, then
saving, confirms the module is working.
