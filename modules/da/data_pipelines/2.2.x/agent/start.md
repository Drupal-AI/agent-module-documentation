<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Pipelines (data_pipelines) — agent index

An ETL framework: a `data_pipelines` **Dataset** content entity pairs a **source** (CSV/JSON from
File, URL or Text) with a code-defined **pipeline** (validation + transform plugins declared in
YAML) and one or more **destination** config entities (JSON/CSV file by default). Processing runs
through the Batch + Queue APIs. Package `Data Pipelines`. Core `^10.3 || ^11`; composer requires
PHP `>=8.3` (`.info.yml` declares `php: 8.0`) plus `drupal/entity:^1.0` and `softcreatr/jsonpath`.
Module deps: `link`, `file`, `entity`, `options`. License GPL-2.0-or-later. Version 2.2.0.

## Solution docs

- **Sources, resources & the Dataset bundle** → [plugins/sources.md](plugins/sources.md)
- **Pipelines, transforms & validation (YAML)** → [plugins/transforms.md](plugins/transforms.md)
- **Destinations config entity + file destinations** → [config/destinations.md](config/destinations.md)
- **Entity, routes, permissions, processing, Drush & API** → [api/processing.md](api/processing.md)

## What it provides (from source)

- **Content entity** `data_pipelines` (`src/Entity/Dataset.php`), base table `data_pipelines`,
  `bundle_plugin_type = data_pipelines_source` (bundles ARE the source plugins), publishable,
  admin permission `administer data_pipelines`. Route provider adds a **Process** form.
- **Config entity** `dataset_destination` (`src/Entity/Destination.php`) managed at
  `/admin/config/content/dataset_destinations`.
- **Four plugin types** (managers in `data_pipelines.services.yml`):
  - `data_pipelines_source` — attribute `#[DatasetSource]`; ships `csv` and `json`, each derived
    per source **resource** (`file`, `uri`, `text`) by `SourceDeriver`.
  - `data_pipelines_pipeline` — YAML discovery from `{module}.data_pipelines.yml`;
    `DatasetPipelineBase` runs validation + transforms.
  - `data_pipelines_transform` — attribute `#[DatasetTransform]`; ships `map`, `concat`,
    `remove`, `skip`.
  - `data_pipelines_destination` — attribute `#[DatasetDestination]`; ships `file_json`
    (JsonDestination) and a CSV file base; `null` in tests.
- **Source resources** (tagged `data_pipelines_source_resource`): `File`, `Uri` (Guzzle GET,
  cached 24h), `Text` — see [plugins/sources.md](plugins/sources.md).
- **Queue worker** `data_pipelines_process` (derived per dataset by `DatasetQueueWorkerDeriver`).
- **Permissions** (`data_pipelines.permissions.yml`): `data_pipelines create|edit|delete|list`,
  `administer data_pipelines` (restricted).
- **Drush** (`src/Drush/Commands/DataPipelinesCommands.php`): `data-pipelines:reindex`,
  `data-pipelines:list`.
- **Config schema** (`config/schema/data_pipelines.schema.yml`) for the destination entity and
  `file_json` settings. Bundled constraints: `ItemCount`, `JsonPath`.
- No submodules ship in this project. Elasticsearch/OpenSearch/SFTP support are separate
  drupal.org projects.
