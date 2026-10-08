# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- **[Data Pipelines](https://www.drupal.org/project/data_pipelines)**
  (`data_pipelines`) — this is a connector for it and cannot be used without it.
- A reachable **OpenSearch cluster** and credentials to authenticate with it.

> This release is an alpha (1.0.0‑alpha3) and is not covered by Drupal's security
> advisory policy — weigh that before using it on production.

## Install with Composer

From the project root:

```bash
composer require drupal/data_pipelines_opensearch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Data Pipelines module if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/data_pipelines_opensearch -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en data_pipelines_opensearch -y
```

Data Pipelines is enabled automatically as a dependency if it was not already on.

## Verify it worked

Go to **Content → Datasets** (`/admin/content/datasets`) and start configuring a
dataset's destination. The OpenSearch destination type should now appear as an
option. Setting up the connection details is covered in
[Configuration](../configuration/index.md).
