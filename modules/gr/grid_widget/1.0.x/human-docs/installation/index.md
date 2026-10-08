# Installation

## Requirements

- **Drupal 8.7.7, 9, or 10** (`core_version_requirement: ^8.7.7 || ^9 || ^10`).
- Core's **Field** (`field`) and **Text** (`text`) modules — both are part of
  standard Drupal installs and are the module's only dependencies.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/grid_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/grid_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en grid_widget -y
```

## Verify it worked

There is no settings page. Go to a bundle's **Manage form display** (for example
**Structure → Content types → *(your type)* → Manage form display**), find an
options field, and confirm **Grid Widget** appears as a choice in the **Widget**
column. Select it, save, and check that the field renders as a grid of
checkboxes or radios on the entity edit form.
