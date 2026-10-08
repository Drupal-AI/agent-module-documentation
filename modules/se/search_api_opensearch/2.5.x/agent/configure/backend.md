<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the OpenSearch backend

There is no module settings page. You configure everything on a **Search API server** entity
(`search_api.server.<id>`) at `/admin/config/search/search-api/add-server`, choosing backend
**"OpenSearch"** (plugin id `opensearch`).

## Backend config schema

`plugin.plugin_configuration.search_api_backend.opensearch`:

```yaml
connector: standard          # connector plugin id: standard | basicauth | aws_signature
connector_config: {}         # shape depends on the connector (see below)
advanced:
  fuzziness: auto            # default query fuzziness (self::FUZZINESS_AUTO = 'auto')
  prefix: ''                 # prefix prepended to index names on this server
  synonyms: []               # list of synonym strings applied at query time
  max_ngram_diff: 1          # (optional) max ngram difference
```

Backend `defaultConfiguration()`: `connector = standard`, `connector_config = []`,
`advanced.fuzziness = auto`, `advanced.prefix = NULL`, `advanced.synonyms = []`.

## Connectors (`connector` + `connector_config`)

| Connector id | Provided by | connector_config keys |
|---|---|---|
| `standard` | this module | `url`, `ssl_verification` (bool) |
| `basicauth` | this module | `url`, `ssl_verification`, `username`, `password` |
| `aws_signature` | `search_api_aws_signature_connector` submodule | `url`, `ssl_verification`, `api_key`, `api_secret`, `aws_region` |

`url` is the full URL to the OpenSearch cluster (e.g. `https://os.example.com:9200`).

## Create a server with drush (config only, no live cluster needed)

```php
use Drupal\search_api\Entity\Server;
Server::create([
  'id' => 'opensearch', 'name' => 'OpenSearch', 'status' => TRUE,
  'backend' => 'opensearch',
  'backend_config' => [
    'connector' => 'standard',
    'connector_config' => ['url' => 'https://os.example.com:9200', 'ssl_verification' => TRUE],
    'advanced' => ['fuzziness' => 'auto', 'prefix' => '', 'synonyms' => []],
  ],
])->save();
```

Read it back: `drush cget search_api.server.opensearch backend_config`.

You then create a Search API **index**, point it at this server, add fields, and index. The
server must be able to reach a running OpenSearch cluster for indexing/queries to work.

## Provided Search API data types & processor

Beyond the standard types, the backend adds these data types (Plugin/search_api/data_type):
`search_api_opensearch_ngram`, `search_api_opensearch_edge_ngram`,
`search_api_opensearch_search_as_you_type`, `search_api_opensearch_rank_feature`,
`search_api_opensearch_date_range`, `object`, `search_api_opensearch_text_spellcheck`. A
`DateRange` processor supports indexing date-range fields. (The `location`/geo_point type is
added by the location submodule.)

## Store credentials per environment

For the AWS connector, `aws_region` (and keys) can be supplied via `settings.php`:
`$config['search_api.server.<id>']['backend_config']['connector_config']['aws_region'] = '…';`
Similarly override `url`/credentials per environment rather than committing them.
