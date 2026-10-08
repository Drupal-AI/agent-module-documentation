# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies beyond core, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_number_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_number_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_number_widget -y
```

## Verify it worked

Go to **Structure → Content types → *(any type with a reference field)* → Manage
form display**. Open the **Widget** dropdown for that field — the module's
entity-reference number/ID widget should now appear as an option. Selecting it and
saving confirms the module is working.
