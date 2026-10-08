# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working **DKAN** site with the **datastore** submodule (`dkan_datastore`)
  enabled — charts read from the datastore query API. Note that DKAN's datastore
  submodule is **not** enabled automatically, so enable it yourself.
- The **clipboardjs** module (`clipboardjs`), for copy‑to‑clipboard support.
- The **clipboard.js JavaScript library**, which the clipboardjs module expects
  you to install (see that module's README for the library location).

Chart.js and Choices.js are bundled with this module under its `dist/` directory,
so you don't need to install those separately.

## Install with Composer

From the project root:

```bash
composer require drupal/dkan_chart -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dkan_chart -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

First make sure DKAN's datastore is on, then enable this module:

```bash
drush en dkan_datastore -y
drush en dkan_chart -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **DKAN tables** | `dkan_tables` | Spreadsheet‑style output of a distribution's data on a **Tables** tab, using DataTables by default (sortable, searchable). RevoGrid is an optional but deprecated alternative. Adds its own `access table configuration` permission. |

Enable it if you want table output:

```bash
drush en dkan_tables -y
```

## Verify it worked

Open a dataset node that has a distribution imported into the datastore. You should
see a **Visualize** local tab (and, if you enabled the submodule, a **Tables**
tab). If the tab doesn't appear — common with the DKAN React front end — navigate
directly to `node/{ID}/visualize`. To let editors build charts, grant the chart
permissions described in [Configuration](../configuration/index.md).
