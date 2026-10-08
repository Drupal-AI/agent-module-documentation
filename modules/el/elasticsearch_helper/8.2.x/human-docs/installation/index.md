# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Serialization** module (`serialization`) — the only module dependency,
  enabled automatically.
- A running **Elasticsearch cluster** to connect to.
- The **Elasticsearch PHP library**, whose version must match your cluster and the
  module series:
  - The **8.x** series (this `8.2.x`) requires the Elasticsearch PHP library
    version **8.x** and is compatible with Elasticsearch 8.
  - The `8.x-7.x` series requires the PHP library version **7.x** (Elasticsearch 7).

  Composer pulls in the appropriate PHP library as a dependency of the module, but
  it's worth confirming the library major version lines up with the Elasticsearch
  version your cluster actually runs.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including the Elasticsearch PHP client library — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elasticsearch_helper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elasticsearch_helper -y
```

## Verify it worked

On its own, Elasticsearch Helper won't index anything until you define an
`ElasticsearchIndex` plugin or add a companion module. To confirm the base is in
place, open the settings form at **Configuration → Search and metadata →
Elasticsearch Helper**, enter your cluster connection details (see
[Configuration](../configuration/index.md)), and save. From there, define your own
index plugin or install one of the companion modules —
[Index Management](https://www.drupal.org/project/elasticsearch_helper_index_management),
[Content](https://www.drupal.org/project/elasticsearch_helper_content),
[Views](https://www.drupal.org/project/elasticsearch_helper_views), or
[Preview](https://www.drupal.org/project/elasticsearch_helper_preview) — to do
something with it.
