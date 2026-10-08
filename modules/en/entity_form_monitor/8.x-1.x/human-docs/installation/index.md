# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No module dependencies and no third-party library requirements. Its JavaScript
  builds on core libraries you already have (jQuery, `drupal.message`, and
  `drupal.dialog`).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_form_monitor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_form_monitor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_form_monitor -y
```

## Verify it worked

Go to **Configuration → Content authoring → Entity Form Monitor**
(`/admin/config/content/entity-form-monitor`) and confirm the settings form loads.
Then open an edit form for a monitored piece of content in one browser, save a
change to the same entity from another browser or account, and the first form
should warn you that it's out of date. Head to
[Configuration](../configuration/index.md) to choose what gets monitored.
