<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Destinations (config entity + file writers)

A **destination** is where processed records are written. It is a `dataset_destination` config
entity (`src/Entity/Destination.php`) wrapping a destination plugin; a dataset references one or
more destinations (unlimited cardinality field `destinations`).

## The `dataset_destination` config entity

- Managed at `/admin/config/content/dataset_destinations` (collection, add, edit, delete). Admin
  permission `administer data_pipelines`. Form `Form/DestinationForm.php`.
- `config_export` / schema keys: `id`, `label`, `destination` (the plugin id), `destinationSettings`
  (a nested `config_object`, typed per plugin via
  `data_pipelines.dataset_destination.destinationSettings.[%parent.destination]` in
  `config/schema/data_pipelines.schema.yml`).
- The form (`DestinationForm`) shows a radios list of destination plugins and AJAX-swaps in the
  selected plugin's own configuration subform (`buildConfigurationForm`), validated and saved via
  `SubformState`. Plugin config lives in a `DefaultSingleLazyPluginCollection`
  (`Destination::getDestinationPlugin()`).

## Destination plugin type (`data_pipelines_destination`)

- Attribute `#[DatasetDestination(id, label, description)]`
  (`src/Attribute/DatasetDestination.php`); manager
  `Destination\DatasetDestinationPluginManager`. Base
  `Destination\DatasetDestinationPluginBase` (implements
  `MergeableConfigurationPluginInterface`) with lifecycle hooks `beginProcessing`,
  `processChunk`, `endProcessing`, `processCleanup`, `deleteDataSet`, `getProcessingChunkSize`,
  `getLastDelta`.

## Shipped destinations

- **`file_json`** — `Plugin/DatasetDestination/JsonDestination.php`, extending
  `FileDestinationBase`. Writes the dataset to `{scheme}://{dir}/{machine_name}.json`.
- **`FileDestinationBase`** (`Plugin/DatasetDestination/FileDestinationBase.php`) — base for file
  writers. `defaultConfiguration()` = `scheme: public`, `dir: ''`. Config form offers a **file
  scheme** radios (from writable stream wrappers) and a **sub-directory** textfield;
  `validateConfigurationForm()` requires the directory be creatable/writable
  (`FileSystemInterface::prepareDirectory`) and the basename valid UTF-8. `beginProcessing()`
  prepares the dir and truncates the target file; `processChunk()` appends the serialized chunk;
  `deleteDataSet()` removes the file. `NullDestination` (test module) discards everything.
- **CSV file** and search-index destinations: CSV writing is provided by a file-destination
  subclass; **Elasticsearch, OpenSearch and SFTP** destinations are separate drupal.org
  sub-projects, not shipped here.

## Schema (`config/schema/data_pipelines.schema.yml`)

```yml
data_pipelines.dataset_destination.*:            # the config entity
  id, label, destination(label), destinationSettings(typed by [%parent.destination])
data_pipelines.dataset_destination.destinationSettings.file_json:
  scheme: string
  dir: string
```

Per-pipeline `destinationSettings` in the pipeline YAML are merged over the entity's stored
settings at processing time via `DestinationWorker` →
`DatasetDestinationPluginBase::mergeConfiguration()`.
