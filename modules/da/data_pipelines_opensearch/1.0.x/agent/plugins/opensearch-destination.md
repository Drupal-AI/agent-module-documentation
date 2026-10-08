<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `opensearch` dataset destination plugin

`src/Plugin/DatasetDestination/OpenSearch.php` — class `OpenSearch`, attribute
`#[DatasetDestination('opensearch', new TranslatableMarkup('OpenSearch'))]`, extends
`Drupal\data_pipelines\Destination\DatasetDestinationPluginBase` and implements
`ContainerFactoryPluginInterface`.

## Install & enable

1. `composer require drupal/data_pipelines_opensearch` (pulls `drupal/data_pipelines ^2.1.0` and
   `opensearch-project/opensearch-php ^2.4`).
2. `drush en data_pipelines_opensearch`.
3. In Data Pipelines, add a destination of type **OpenSearch** to a pipeline. There is **no
   module-level settings form** (`configure` is null); all settings are per-destination.

## Configuration form (`buildConfigurationForm`)

Four fields, stored in `$this->configuration` and schema-typed as strings under
`data_pipelines.dataset_destination.destinationSettings.opensearch`:

- `url` — **required** textfield, "URL of the OpenSearch cluster."
- `username` — textfield (optional). Used for HTTP basic auth.
- `password` — password field (optional).
- `prefix` — textfield, index prefix.

`validateConfigurationForm()` rejects a `url` that fails `UrlHelper::isValid($url, TRUE)`
(absolute URL required). Accessors: `getUrl()`, `getUsername()`, `getPassword()`, `getPrefix()`.

Beyond these four form fields, a pipeline may declare extra keys under
`destinationSettings.opensearch` (e.g. `mappings`) — see the test fixture
`tests/modules/…/data_pipelines_opensearch_test.data_pipelines.yml`, which sets
`mappings.properties.firstname.{type: keyword, index: false}`. Those settings are passed as the
index creation body (below).

## Index naming

`getIndexName($dataset)` = `getPrefix() . $dataset->getMachineName()`. One index per dataset.

## Lifecycle methods (all obtain a client via `getClient()`; return FALSE if the client is null)

- **`beginProcessing($dataset)`** — calls parent, then `IndexRequest::exists()`. If the index is
  missing, builds `new Index($name, $settings)` where `$settings =
  $dataset->getPipeline()->getDestinationSettings($this->getPluginId())`, and calls
  `IndexRequest::create()` (i.e. `indices()->create(['index'=>id,'body'=>settings])`). Exceptions
  are logged and it returns FALSE.
- **`processChunk($dataset, $chunk)`** — for each `$delta => $item`, builds
  `new Document("<machine>:<delta>", $index, $item->getArrayCopy(), $delta)` and
  `DocumentsRequest::create()` bulk-indexes them. Document body = the row array + `@delta` (see
  `Document::getData()`), so `@delta` is stored on every document for ordering/resume.
- **`processCleanup($dataset, $invalidDeltas)`** — bulk-**deletes** documents with ids
  `<machine>:<delta>` for each invalid delta via `DocumentsRequest::delete()`.
- **`getLastDelta($dataset)`** — if the index exists, `DocumentsRequest::last()` runs a `search`
  sorted `@delta desc size 1` and returns that document's delta; `BadRequestHttpException` is
  logged as a warning; returns `0` otherwise (fresh start).
- **`deleteDataSet($dataset, $destination)`** — deletes the index if it exists
  (`IndexRequest::delete()`); returns TRUE if already absent.

## `viewSettings()`

Returns a render array whose `#markup` is a `TranslatableMarkup` showing `%url`, a `%ok` status
(`client && client->ping()` → "✅ OK" else "❌ Failed"), and `%prefix`. All values pass through
`TranslatableMarkup` placeholders (auto-escaped).

## Dependencies injected (`create()`)

`plugin.manager.data_pipelines_pipeline` (`DatasetPipelinePluginManager`),
`logger.channel.data_pipelines_opensearch`, `data_pipelines_opensearch.client_factory`
(`ClientFactoryInterface`), and `entity_type.manager`.
