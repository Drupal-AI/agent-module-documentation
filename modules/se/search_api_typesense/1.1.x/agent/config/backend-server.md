<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Server backend configuration

Configured on the Search API server form (backend = "Search API Typesense"). Built by
`SearchApiTypesenseBackend::buildConfigurationForm()` /`submitConfigurationForm()`
(`src/Plugin/search_api/backend/SearchApiTypesenseBackend.php`). Stored under the server config's
`backend_config`. Schema: `config/schema/search_api_typesense.schema.yml`
(`plugin.plugin_configuration.search_api_backend.search_api_typesense`).

## Fields

- `admin_api_key` — textfield (maxlength 128). Read-write Typesense API key used for indexing and all
  admin operations. The form description states it "must be kept secret and never transmitted to the
  client" and is ideally provided by an environment variable. It is stored in `backend_config`.
- `nodes[]` — one or more nodes, each `host` / `port` / `protocol` (`http`|`https`, default `https`).
  AJAX add/remove via `addOneNodeElement()` / `removeNodeElementCallback()`; state key `nodes_count`;
  wrapper id `typesense-individual-nodes`. At least one node required.
- `nearest_node_enable` (checkbox) + `nearest_node` (`host`/`port`/`protocol`) — optional geo
  load-balanced endpoint with automatic failover. If disabled, `submitConfigurationForm()` nulls
  `nearest_node`.
- `public_endpoint` (`host`/`port`/`protocol`) — the endpoint the browser/InstantSearch uses;
  distinct from the server-side node list. Consumed by
  `TypesenseSearchRenderService::retrievePublicNodes()`.
- `retry_interval_seconds` — number, default 2. Connection retry/timeout.

## Runtime

- `getClientConfiguration(array $configuration): ?Config` builds an `Api\Config` from
  `admin_api_key`, `nodes` (numeric keys only), `nearest_node`, `retry_interval_seconds`, and the
  Drupal `http_client` (Guzzle). Returns NULL if required keys are missing.
- `getTypesenseClient(): TypesenseClientInterface` — lazy-instantiates `Api\TypesenseClient`, calls
  `retrieveHealth()`, then `syncIndexesAndCollections()`. Throws `SearchApiTypesenseException` if not
  configured or invalid.
- `isConfigured()` reads the server config **with overrides** (`getOriginal('backend_config')`) and
  throws if the API key, nodes, nearest node (when enabled), or timeout are unset/non-numeric.
- `isAvailable()` returns TRUE only when configured and a client can be built.
- The client's HTTP transport is Drupal's `http_client` (Guzzle) — standard TLS verification applies;
  the module does not disable it.

## Collection naming & sync

- `getCollectionName(IndexInterface $index)` = the index id, alterable via the
  `TypesenseCollectionEvents::ALTER_NAME` event (`TypesenseCollectionNameEvent`).
- `syncIndexesAndCollections()` creates a Typesense collection for each index whose `typesense_schema`
  defines `fields` but has no collection yet.
