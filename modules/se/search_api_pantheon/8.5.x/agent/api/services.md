<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — connector, service & internals

The module adds no public hooks or `*.api.php`. It works by extending Search API Solr
plugins/services. Reference for agents integrating or debugging it.

## `pantheon` SolrConnector plugin
`Drupal\search_api_pantheon\Plugin\SolrConnector\PantheonSolrConnector`
(`@SolrConnector(id = "pantheon")`) extends Search API Solr's `StandardSolrConnector`. It is
not a new plugin *type* — it is one connector plugin of the `search_api_solr_connector` type.

- In `__construct()` it calls `getEnvironmentVariables()` and, if they exist, force-overrides
  the stored connector configuration (`scheme`/`host`/`port`/`path`/`core`). This override is
  deliberately read from global env state (not `create()`) because forcing the Pantheon
  connection is the whole point.
- On non-`lando` Pantheon environments it also sets `context = ''` (Pantheon's endpoint has
  no `/solr/` path segment).
- `getEnvironmentVariables(): array` returns `[]` when `PANTHEON_ENVIRONMENT` is unset — that
  is why the module is inert off Pantheon.
- `create()` swaps in the `logger.channel.search_api_pantheon` channel.

## Service: `search_api_pantheon.schema_poster`
`Drupal\search_api_pantheon\Services\SchemaPoster` — posts generated Solr config files to the
Pantheon Solr container (backs the `postSchema`/`view-schema` Drush commands). Public methods:

| Method | Purpose |
|---|---|
| `postSchema(string $server_id = '', array $files = []): array` | Upload schema/config files to the server; returns the parsed response messages. |
| `getSolrFiles(ServerInterface $server): array` | Generate the Solr config files for a server. |
| `getSolrFilesAsZip(ServerInterface $server): string` | Same, packaged as a zip. |
| `viewSchema(string $filename = 'schema.xml'): ?string` | Fetch a schema file's contents from the server. |
| `processResponse(Response $response): array` | Normalize a Solarium response into messages. |

## Event subscriber (schema generation alter)
`search_api_pantheon.event_subscriber` →
`EventSubscriber\SearchApiPantheonSolrConfigFilesAlter` listens to Search API Solr's
`PostConfigFilesGenerationEvent`. Before files are posted it:
- drops `solrcore.properties` from the upload (it caused core-restart issues) and strips
  `solr.install.dir` from it, and
- rewrites `solr.install.dir:../../../..` in `solrconfig.xml` to the real install dir
  (`$_ENV['PANTHEON_SOLR_INSTALL_DIR']`, default `/opt/solr/`).

## Helpers
- `GetPantheonSolrServerTrait` — `getPantheonSolrServer(?string $server_id)` and
  `getPantheonSolrConnector(?ServerInterface $server)` resolve the active Pantheon server /
  connector (used by the Drush commands).
- `Solarium\PantheonSolrCurl` extends Solarium's `Curl` adapter, overriding `createHandle()`
  for Pantheon's endpoint.

## Config entities installed
`search_api.server.pantheon_search` and `search_api.index.primary` — see
[../configure/setup.md](../configure/setup.md).
