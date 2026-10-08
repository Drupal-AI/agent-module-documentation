# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **PHP 8.0** or higher.
- **Module dependencies:**
  - core **Link** (`link`)
  - core **File** (`file`)
  - core **Options** (`options`)
  - contrib **Entity** (`entity`) — the
    [Entity API](https://www.drupal.org/project/entity) module. Composer pulls
    this in automatically with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/data_pipelines -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the contrib Entity module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/data_pipelines -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en data_pipelines -y
```

The core Link, File, and Options modules and the contrib Entity module are enabled
automatically as dependencies.

## Connector modules (optional)

Data Pipelines is designed to be extended with connectors for extra sources and
destinations. Enable whichever you need as separate modules:

- **[Data Pipelines SFTP](https://www.drupal.org/project/data_pipelines_sftp)**
  (`data_pipelines_sftp`) — adds an SFTP server as a data *source*.
- **[Data Pipelines OpenSearch](https://www.drupal.org/project/data_pipelines_opensearch)**
  (`data_pipelines_opensearch`) — adds an OpenSearch index as a *destination*.
- **Data Pipelines Elasticsearch** (`data_pipelines_elasticsearch`) — adds an
  Elasticsearch index as a *destination*.

## Verify it worked

Log in as an administrator and go to **Content → Datasets**
(`/admin/content/datasets`). If the datasets listing loads, the module is
installed. To actually run data through it you next define a pipeline in YAML and
grant the module's permissions — see [Configuration](../configuration/index.md).
