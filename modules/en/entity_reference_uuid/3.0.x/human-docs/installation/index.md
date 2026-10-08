# Installation

## Requirements

- **Drupal 11.1 or later** (`core_version_requirement: ^11.1`) — this is a tight
  requirement, so make sure your site is on Drupal 11.1+ before installing.
- No module dependencies beyond core, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_uuid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_uuid -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_uuid -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click **Add
field**. The **Entity Reference UUID** field type should now appear among the
available field types. Its presence confirms the module is installed and working.
