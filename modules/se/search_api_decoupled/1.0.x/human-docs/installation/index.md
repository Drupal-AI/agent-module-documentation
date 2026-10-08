# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Search API** module (`drupal/search_api`, `^1.28`) — installed automatically
  as a Composer dependency. You will need a working Search API server and index before
  this module is useful.
- **Optional (suggested) integrations**, each enabling a matching submodule:
  - **Facets** (`drupal/facets`, `^2.0`) — for the facets submodule.
  - **Search API Autocomplete** (`drupal/search_api_autocomplete`, `^1.7`) — for the
    autocomplete submodule.
  - **Search API Exclude** (`drupal/search_api_exclude`, `^2.0`).

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_decoupled -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Composer merge plugin required.** This project pulls in front-end libraries via a
> `composer.libraries.json` file, which needs the
> `wikimedia/composer-merge-plugin` to be present and configured in your project's
> `composer.json`. If Composer reports missing libraries after installing, add and
> configure that plugin, then run the require again.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_decoupled -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_decoupled -y
```

## Submodules — enable only what you need

The project ships four optional submodules (none enabled by default):

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **UI** | `search_api_decoupled_ui` | A configurable, themeable front-end search UI builder (element plugins, layouts, templates). |
| **Facets** | `search_api_decoupled_facets` | Integrates the Facets module so endpoints return facet data. |
| **Autocomplete** | `search_api_decoupled_autocomplete` | Integrates Search API Autocomplete for typeahead. |
| **Demo** | `search_api_decoupled_demo` | Demo/install fixtures to see it working quickly. |

Enable a submodule with, for example:

```bash
drush en search_api_decoupled_facets -y
```

Then configure your endpoints — see [Configuration](../configuration/index.md).
