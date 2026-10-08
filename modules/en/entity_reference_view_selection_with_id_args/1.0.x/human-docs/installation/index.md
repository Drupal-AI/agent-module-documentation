# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Field** (`field`) and **Views** (`views`) modules — both part of a
  standard Drupal install and enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_view_selection_with_id_args -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine —
> `ddev composer require drupal/entity_reference_view_selection_with_id_args -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_view_selection_with_id_args -y
```

## Verify it worked

Go to **Structure → Content types → *(any type with a reference field)* → Manage
fields → *(the field)*** and open its field settings. In the **Reference method**
(selection handler) dropdown you should now see the Views selection that passes ID
arguments. Its presence confirms the module is installed and working.
