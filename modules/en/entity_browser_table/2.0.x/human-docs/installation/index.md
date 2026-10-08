# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **[Entity Browser](https://www.drupal.org/project/entity_browser)** module
  (`drupal/entity_browser ^2.15`) enabled. You also need at least one entity
  browser configured before the widget is useful — this module presents an
  existing browser's results as a table, it does not create a browser.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_browser_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Entity Browser
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_browser_table -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_browser_table -y
```

Drupal enables Entity Browser at the same time if it is not already on. There is
no configuration step for the module itself — it simply makes the **Entity
Browser - Table** widget available to select on any entity‑reference field's
*Manage form display* page.

## Verify it worked

Open a bundle's **Manage form display** page (for example
`/admin/structure/types/manage/article/form-display`) for a content type that has
an entity‑reference field. In that field's **Widget** select list you should now
see **Entity Browser - Table** as an option.
