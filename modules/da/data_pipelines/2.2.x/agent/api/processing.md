<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity, routes, permissions, processing, Drush & API

## Install / enable

`drush en data_pipelines`. Requires core `link`, `file`, `entity` (contrib) and `options`, plus
composer libs `drupal/entity` and `softcreatr/jsonpath`. Composer floor is PHP `>=8.3`
(`.info.yml` still declares `php: 8.0`). No module settings form (`configure` is null);
destinations are the only UI config.

## The Dataset entity (`src/Entity/Dataset.php`)

- Content entity `data_pipelines`, base table `data_pipelines`, publishable
  (`EntityPublishedTrait`), **bundle = source plugin**. Storage
  `EntityHandlers/DatasetStorage.php`; list builder `DatasetListBuilder`; views data enabled.
- Base fields: `name` (label), `machine_name` (regex `^[a-z0-9_]+$`, unique — used for the queue,
  cache id and output filename), `pipeline` (list_string from `getPipelines()`), `published`
  (unpublishing purges destination data), `destinations` (entity_reference, unlimited),
  `batch_size` (10–100000, default 1000), `invalid_values` (`retain`/`remove`). Source plugins add
  their own resource field(s). `status` tracks the processing state machine
  (`pending_validation` → `pending_processing` → `processed`, plus `pending_deletion`).

## Routes & permissions

- Entity routes (via `EntityHandlers/DatasetRouteProvider` extending `AdminHtmlRouteProvider`):
  - `/admin/content/datasets` (collection, perm `data_pipelines list`)
  - `/admin/content/datasets/add`, `/add/{source}` (create, `data_pipelines create`)
  - `/admin/content/datasets/manage/{data_pipelines}` canonical + `/edit` (`data_pipelines edit`)
  - `/data_pipelines/{data_pipelines}/delete` (`data_pipelines delete`)
  - `/data_pipelines/{data_pipelines}/process` — the **Process** form; route requirement
    `_entity_access: data_pipelines.update` (i.e. `data_pipelines edit`).
- Access handler `EntityHandlers/DatasetAccessHandler`: delete→`data_pipelines delete`,
  update→`data_pipelines edit`, view/label→`data_pipelines list`, create→`data_pipelines create`.
- Permissions (`data_pipelines.permissions.yml`): `data_pipelines create|edit|delete|list` and
  `administer data_pipelines` (`restrict access: true`), the latter being the entity admin
  permission and the `dataset_destination` admin permission.
- The **Process** form (`Form/DatasetProcessForm`) is a `ContentEntityConfirmFormBase` (POST +
  confirm, so CSRF-protected); on confirm it `batch_set`s `DatasetBatchOperations::batchForDataset`
  for a published dataset (unpublished → warning, no processing).

## Processing flow (Batch + Queue)

- On save, `DatasetForm` (action `saveAndProcess`) saves the entity then triggers a batch. Deletes
  are handled in the background. Status moves pending_validation → validate → pending_processing →
  index → processed (see README "Processing flow").
- Each dataset has its **own** queue, worker id `data_pipelines_process` derived per dataset by
  `Plugin/Derivative/DatasetQueueWorkerDeriver` (queries all datasets with `accessCheck(FALSE)`;
  internal maintenance query, not a user-facing listing). Worker
  `Plugin/QueueWorker/DestinationWorker::processItem()` loads the dataset + destination, merges
  pipeline destination settings, and runs a `ProcessingOperation` (save/delete) against the
  destination plugin.
- `TransformValidDataIterator` yields only transformed, valid records; `TransformSkipRecordException`
  and validation violations drop records.

## API

- `$dataset->getDataIterator($seek_from = 0)` → `TransformValidDataIterator` of transformed valid
  `DatasetData` (preferred over materialising all rows — large datasets may not fit one request).
- `$dataset->data()` — raw generator from the source plugin.
- `Dataset::loadByMachineName($name)`, `getPipeline()`, `getDestinations()`, `getBatchSize()`,
  `getProcessingQueueId()`, `getInvalidValuesHandling()`, `addLogMessage()`/`getLogs()`.

## Drush (`src/Drush/Commands/DataPipelinesCommands.php`)

- `data-pipelines:reindex <machine_names>` — comma list (interactive picker if omitted); deletes
  each dataset's destination data then re-runs the batch.
- `data-pipelines:list` — table of id/machine_name/pipeline/destination; `--pipeline`,
  `--destination` filters, `--pipe` for reindex-compatible output. (Uses `accessCheck(FALSE)` — a
  CLI/admin listing.)

## Update hooks

`data_pipelines.install` ships `hook_update_8001`–`8017` (plugin-id/deriver migrations, field
storage installs for `machine_name`, `csv_delimiter`, `destinations`, `batch_size`,
`invalid_values`, `published`, and the `dataset_destination` entity). `8011` installs the
`data_pipelines_elasticsearch` sub-project if present.
