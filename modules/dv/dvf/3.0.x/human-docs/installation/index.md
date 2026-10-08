# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No mandatory third‑party PHP libraries for the base module. The charting and table
  JavaScript libraries (billboard.js, DataTables) ship with DVF.
- **For the CKAN source only:** the **DVF CKAN** submodule requires the **CKAN
  Connector** module (`ckan_connect`) to connect to and retrieve data from CKAN
  sources. Install it alongside DVF if you plan to use CKAN.

## Install with Composer

From the project root:

```bash
composer require drupal/dvf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

If you will use CKAN data sources, also require the connector:

```bash
composer require drupal/ckan_connect -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dvf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base framework plus the **source submodule(s)** for the kinds of data you
work with:

```bash
drush en dvf dvf_csv dvf_json -y
```

Add `dvf_ckan` if you need CKAN (and make sure `ckan_connect` is installed):

```bash
drush en dvf_ckan -y
```

## Submodules

DVF ships three data‑source submodules — enable only the ones you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **DVF CSV** | `dvf_csv` | Use uploaded or linked **CSV** files as a data source. |
| **DVF JSON** | `dvf_json` | Use **JSON** files or endpoints as a data source. |
| **DVF CKAN** | `dvf_ckan` | Use **CKAN** open‑data datasets as a source. Requires the **CKAN Connector** (`ckan_connect`) module; also includes migrate plugins for importing CKAN datasets. |

## Verify it worked

After enabling, run `drush cr` so DVF discovers the new source and style plugins.
Then go to a content type's **Manage fields**, click **Add field**, and confirm you
can add a **Visualisation (File)** or **Visualisation (URL)** field. Add one, enter a
small data source on a node, pick a chart style, and check that the visualisation
renders on the saved node.
