# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Language** module (`language`) enabled — this is the dependency that
  makes the current‑language filtering meaningful, and Drupal will enable it as a
  dependency when you turn on this module.
- No third‑party Composer or PHP library requirements.

This module is most useful on a genuinely **multilingual** site, where content
exists in more than one language.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_current_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_current_language -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_current_language -y
```

## Verify it worked

Edit an entity reference field (via **Manage fields** on any bundle) and open its
**Reference method** / selection settings. The current‑language selection method
this module provides should now be available to choose. Select it, save, and
confirm that on a translated page the field only offers entities in the current
language.
