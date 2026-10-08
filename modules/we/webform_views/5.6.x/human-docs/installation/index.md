# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) enabled.
- The contrib **Webform** module, **version 6.2 or newer** (`drupal/webform`
  `^6.2`). Composer pulls this in for you if it is not already present.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will bring in a compatible Webform release.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_views -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_views -y
```

Once enabled, the **Webform submissions** base table and its per-element handlers
are available in the Views UI. There is nothing else to configure — you build your
reports directly in Views.

## Submodule — example

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Webform Views Example** | `webform_views_example` | Ships a sample webform and a sample view that demonstrate the integration end to end. Handy as a reference; you can disable it once you have copied the pattern. |

Enable it if you want the worked example:

```bash
drush en webform_views_example -y
```
