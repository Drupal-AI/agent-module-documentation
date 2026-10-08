# Installation

> **Before you install:** this is a **demo** module marked *Unsupported / Obsolete*
> on drupal.org. Use it to evaluate the store locator, then uninstall it — it is not
> intended for production.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- [**Mapsemble Store Locator**](../../../mapsemble_store_locator/1.0.x/human-docs/index.md)
  (`mapsemble_store_locator`) — the locator this content populates (which in turn
  brings in Mapsemble and Geofield Map).
- [**Default Content**](https://www.drupal.org/project/default_content)
  (`default_content`) — used to import the sample stores.

Composer pulls these dependencies in automatically when you require this module.

## Install with Composer

From the project root:

```bash
composer require drupal/mapsemble_store_locator_demo_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Mapsemble Store
Locator, Default Content, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mapsemble_store_locator_demo_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapsemble_store_locator_demo_content -y
```

Enabling the module imports the sample store locations through Default Content, and
Drupal enables the Store Locator and Default Content dependencies at the same time.

## Verify it worked

Visit **`/mapsemble-store-locator`** — you should see the map and list populated
with the demo stores. You can also find them under **Content**
(`/admin/content`) as **Store** items. When you have finished evaluating, uninstall
this module to remove the demo footprint before adding your own stores.
