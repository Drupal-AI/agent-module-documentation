# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** (`views`) and **Path Alias** (`path_alias`) modules.
- Four **contrib** dependencies, which Composer will pull in for you:
  - **Better Exposed Filters** (`drupal/better_exposed_filters ^7.0`) — the
    filtering UI on the reports.
  - **Config Views** (`drupal/config_views ~2.1`) — the load-bearing dependency; it
    exposes configuration entities to Views so the model can be listed.
  - **Mermaid Diagram Field** (`drupal/mermaid_diagram_field ~1.0`) — renders the
    relationship and workflow diagrams.
  - **Views Data Export** (`drupal/views_data_export ^1.5`) — downloadable output of
    the reports.

This is a real dependency commitment for a documentation tool — four contrib
modules plus two core modules — so factor that in before installing.

## Install with Composer

From the project root:

```bash
composer require drupal/content_model_documentation -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it pulls in the four
contrib dependencies and updates any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_model_documentation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_model_documentation -y
```

This enables the module and its dependencies together.

## Verify it worked

Log in as an administrator and open **Reports → Content Model Reports**
(`/admin/reports/content-model/`). You should see the node-count, vocabulary-count,
field-search, and fields reports, plus entity-relationship diagrams. Then head to
[Configuration](../configuration/index.md) to choose which entity types you want to
document.
