# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 | ^11`). Note the
  project writes this with a single pipe; the practical requirement is Drupal
  10.3 or 11.

The base module has no other module dependencies. Individual submodules may pull
in their own (for example the Google Analytics submodule needs analytics
credentials to be useful).

## Install with Composer

From the project root:

```bash
composer require drupal/analyze -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/analyze -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en analyze -y
```

## Submodules — enable only what you need

Analyze ships several submodules that supply the actual information on the tab.
Enable the ones you want with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Basic content info** | `analyze_basic_content_info` | Basic per-entity content statistics. |
| **Page views** | `analyze_page_views` | Page-view counts for the entity. |
| **Google Analytics** | `analyze_google_analytics` | Google Analytics data for the entity. |
| **Plugin example** | `analyze_plugin_example` | A worked example that documents the plugin API — a reference for building your own plugin, not for production. |

For example:

```bash
drush en analyze_basic_content_info -y
```

Each submodule requires the base Analyze module, which is already present once you
have installed it above.
