# Installation

DKAN is large and infrastructural. Plan to build a site *around* it rather than
add it to an existing content site, and expect a substantial Composer dependency
tree to be pulled in on first install.

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- A number of core modules, enabled automatically as dependencies: **Config**,
  **Field**, **File**, **Link**, **Options** and **Path**.
- DKAN's own components, also pulled in as dependencies: **dkan_metastore**,
  **dkan_metastore_admin**, **dkan_metastore_search**, **dkan_common** and
  **dkan_data_dictionary_widget**.
- The contributed **JSON Form Widget** module (`json_form_widget`), which powers
  DKAN's metadata editing forms.

Because DKAN behaves like a distribution, using Composer (not manual downloads) is
strongly recommended so the whole dependency tree resolves correctly.

## Install with Composer

From the project root:

```bash
composer require drupal/dkan -W
```

The `-W` (`--with-all-dependencies`) flag is important here — DKAN shares
dependencies with many packages, and `-W` lets Composer update them together so
the install resolves cleanly.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dkan -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en dkan -y
```

## Submodules — enable the pipeline pieces you need

DKAN is organised into submodules, each owning one part of the portal. Enable them
individually with `drush en`:

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Metastore** | `dkan_metastore` | Stores dataset metadata as JSON and exposes the metadata API. (Enabled as a core dependency.) |
| **Datastore** | `dkan_datastore` | Imports tabular resources (CSVs) into queryable database tables and exposes the datastore query API. Enable this to make data queryable. |
| **Harvest** | `dkan_harvest` | Pulls dataset catalogs from other portals so you can aggregate external sources. |
| **Common** | `dkan_common` | Shared utilities and base API endpoints the other submodules build on. |
| **JS Frontend** | `dkan_js_frontend` | Wires a decoupled JavaScript front end to the DKAN APIs. |
| **Sample Content** | `dkan_sample_content` | Loads demo datasets so you can see the portal working right away. |

For example, to turn on the datastore and load some demo data:

```bash
drush en dkan_datastore dkan_sample_content -y
```

## Verify it worked

Log in as an administrator and confirm the DKAN administration areas are present —
for example the datastore settings at **`/admin/dkan/datastore`**. If you enabled
**dkan_sample_content**, browse to the dataset catalog and you should see the demo
datasets listed. From there, continue to [Configuration](../configuration/index.md)
to walk through the dataset/datastore workflow and set up API permissions.
