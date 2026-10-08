<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Pipelines - OpenSearch (data_pipelines_opensearch) — agent index

Adds one **`DatasetDestination` plugin (`opensearch`)** to the [Data Pipelines](https://www.drupal.org/project/data_pipelines)
framework, writing a dataset into an **OpenSearch** cluster via the official `opensearch-project/opensearch-php`
client. Package `Data Pipelines`. Core `^10.1 || ^11`, PHP `>=8.3`. License GPL-2.0-or-later.
Version 1.0.0-alpha3.

Composer deps (beyond core): `drupal/data_pipelines:^2.1.0`, `opensearch-project/opensearch-php:^2.4`.
Module dependency: `data_pipelines:data_pipelines`. **No routes, no permissions, no Drush, no hooks,
no install file.** Ships config schema only.

- **The `opensearch` destination plugin — config form, index/document lifecycle, settings** →
  [plugins/opensearch-destination.md](plugins/opensearch-destination.md)
- **Client factory service + request proxies and value objects** →
  [api/client-and-requests.md](api/client-and-requests.md)

## What it actually provides

- **Plugin** `Drupal\data_pipelines_opensearch\Plugin\DatasetDestination\OpenSearch` — attribute
  `#[DatasetDestination('opensearch', 'OpenSearch')]`, extends `DatasetDestinationPluginBase`.
- **Service** `data_pipelines_opensearch.client_factory` → `ClientFactory` (arg: the module's
  logger channel). Plus `logger.channel.data_pipelines_opensearch`.
- **Config schema** `data_pipelines.dataset_destination.destinationSettings.opensearch`
  (`config/schema/…`): `url`, `username`, `password`, `prefix` — all strings. No `config/install`;
  settings are stored on the pipeline's destination, entered via Data Pipelines' UI.
- **Value objects**: `Index` (id + settings), `Document` (id, Index, data, delta).
- **Request proxies** over `\OpenSearch\Client`: `IndexRequest` (create/delete/exists),
  `DocumentsRequest` (bulk create/delete, `last()`), `DocumentRequest` (single index) — all extend
  the abstract `Request`.

## Mechanism (from source)

- Index name = `getPrefix() . $dataset->getMachineName()`.
- `beginProcessing()` creates the index if missing, applying `destinationSettings.opensearch`
  (e.g. `mappings`) as index body. `processChunk()` builds `Document`s with id `<dataset>:<delta>`,
  body = row array + `@delta`, and bulk-indexes them. `processCleanup()` bulk-deletes invalid
  deltas. `deleteDataSet()` deletes the index. `getLastDelta()` searches sorted by `@delta desc`.
- `ClientFactory::create($url, $username, $password)` builds a memoized client with
  `(new OpenSearch\GuzzleClientFactory())->create(['base_uri' => $url, 'auth' => [$username, $password]])`;
  errors are logged, not thrown. `viewSettings()` shows the URL, prefix and a `ping()` status.
- URL is validated in `validateConfigurationForm()` with `UrlHelper::isValid($url, TRUE)`. The URL,
  username and password are **operator-entered configuration**, not request input.

Not covered by a security advisory policy (`security_advisory_coverage: not-covered`).
