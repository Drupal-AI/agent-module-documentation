# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The contributed **[Ajax Link](https://www.drupal.org/project/ajax_link)** module
  (`ajax_link`), which powers the automatic "load next" behaviour. Composer pulls
  it in automatically when you require this module with the `-W` flag below.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_pagination_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and download the
**Ajax Link** dependency along with the formatter.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_pagination_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_pagination_formatter -y
```

Drupal will enable the **Ajax Link** dependency at the same time.

## Verify it worked

Go to **Structure → Content types → *(any type with a reference field)* → Manage
display**. Open the **Format** dropdown for that field — the Entity reference
pagination formatter should now appear as an option. Selecting it, setting a page
size, and saving confirms the module is working.
