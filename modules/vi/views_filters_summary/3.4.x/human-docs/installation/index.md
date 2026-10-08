# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and it
  is on by default on most sites.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_filters_summary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_filters_summary -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_filters_summary -y
```

Once enabled, the **Views exposed filters summary** area becomes available to add
to any view — see [How to use it](../index.md#how-to-use-it). There is no
site-wide configuration step.

## Submodules — enable only what you need

The base module knows how to summarize core Views filters. Eleven optional
submodules teach it about filters provided by *other* modules, or add extra
behavior. Enable a submodule only if you use the corresponding module or feature:

| Submodule | What it adds |
|-----------|--------------|
| `views_filters_summary_a11y` | Accessible remove-link markup for screen readers. |
| `views_filters_summary_address` | Support for **Address** module administrative-area filters. |
| `views_filters_summary_bef` | Integration with **Better Exposed Filters** single-checkbox labels. |
| `views_filters_summary_commerce` | Support for **Commerce** entity-bundle filters. |
| `views_filters_summary_cvfb` | Support for the CVFB filter integration. |
| `views_filters_summary_eb` | Works inside an **Entity Browser** embed by adjusting the exposed form ID. |
| `views_filters_summary_eref` | Support for entity-reference filters. |
| `views_filters_summary_search_api` | Summarizes **Search API** fulltext and term/options facets. |
| `views_filters_summary_vcer` | Support for the VCER filter integration. |
| `views_filters_summary_verf` | Support for the VERF filter integration. |
| `views_filters_summary_vsf` | Support for the VSF filter integration. |

Enable one with `drush en`, for example:

```bash
drush en views_filters_summary_bef -y
```

Each submodule requires the base module, which is already present once you have
installed it above.
