# Installation

## Requirements

- **Drupal 9.5, 10 or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Search API** module (`search_api`).
- A working **Acquia Site Studio** install (`cohesion` and `cohesion_elements`) —
  required at runtime, since this module reads Site Studio layout data. Site
  Studio is a licensed product you provide separately.

There are no additional third-party Composer packages or PHP library requirements
declared by the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_sitestudio_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_sitestudio_processor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_sitestudio_processor -y
```

## Verify it worked

The processor is hidden and locked, so you don't enable it directly — you activate
it by adding its field to an index. Go to your Search API index's **Fields** UI
and look for a property called **Sitestudio Components**. If you can add it as a
field, the module is installed correctly. The next step is on the
[Configuration](../configuration/index.md) page.
