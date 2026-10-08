# Configure the Fusion connector

Search API Fusion has **no admin page of its own** (`configure` is null). You configure it while adding a
Search API server:

1. `/admin/config/search/search-api/add-server`
2. Backend = **Solr**, Solr connector = **Fusion**.
3. Fill the Fusion-specific fields below, then build an index on this server as usual.

The connector is `Drupal\search_api_fusion\Plugin\SolrConnector\FusionConnector` (plugin id `fusion`), which
extends `search_api_solr`'s `BasicAuthSolrCloudConnector` — so it inherits all the Solr Cloud + HTTP
basic-auth fields (scheme, path, timeouts, **username/password**) and relabels three of them for Fusion.

## Server form fields

| Form field | Config key | Notes |
|---|---|---|
| Fusion host | `host` | inherited, relabeled. Host/IP of the Fusion server. |
| Fusion port | `port` | inherited; **default `8764`** (Fusion's standard port). |
| Fusion app | `core` | inherited; the Fusion **app** name (used as the Solr core / URL segment). |
| (hidden) | `context` | forced to `/api/solr` via a `#type => value` element — Fusion's Solr API base. |
| Fusion search query profile | `fusion_qprofile_search` | **required** textfield; the query profile `search()` routes to. |
| Send click signals to Fusion | `fusion_click_signals` | checkbox, default `FALSE`. Enables the per-result ping URLs (see api/signals.md). |
| Username / Password | `username` / `password` | inherited basic-auth credentials; reused when POSTing signals. |

The autocomplete query profile is **not** on this form — `fusion_qprofile_autocomplete` is set on the
autocomplete suggester instead (see plugins/plugins.md), even though the schema declares it under the
connector config too.

## Config schema & storage

`config/schema/search_api_solr.connector.fusion.schema.yml` declares type
`plugin.plugin_configuration.search_api_solr_connector.fusion`, extending
`plugin.plugin_configuration.search_api_solr_connector.solr_cloud_basic_auth`, and adds:

| Key | Type | Meaning |
|---|---|---|
| `context` | string | Solr-API context (`/api/solr`). |
| `fusion_qprofile_search` | string | Search query profile. |
| `fusion_qprofile_autocomplete` | string | Autocomplete query profile (set by the suggester). |
| `fusion_click_signals` | bool | Send click signals. |

Stored inside the server config entity `search_api.server.<id>` under `backend_config.connector` (= `fusion`)
and `backend_config.connector_config`. `defaultConfiguration()` seeds `port => '8764'`,
`fusion_qprofile_search => ''`, `fusion_click_signals => FALSE` (plus the parent defaults).

### Set via PHP

```php
$server = \Drupal::entityTypeManager()->getStorage('search_api_server')->load('my_fusion');
$config = $server->getBackendConfig();
$config['connector'] = 'fusion';
$config['connector_config']['host'] = 'fusion.example.com';
$config['connector_config']['port'] = '8764';
$config['connector_config']['core'] = 'my_app';                  // Fusion app name
$config['connector_config']['fusion_qprofile_search'] = 'my_search_profile';
$config['connector_config']['fusion_click_signals'] = TRUE;
$server->setBackendConfig($config);
$server->save();
```

Or with Drush:
`drush config:set search_api.server.my_fusion backend_config.connector_config.fusion_click_signals true`.

## Request routing (what the connector overrides)

- `search()` → `queryProfile()`: search/autocomplete queries go to `/api/apps/<app>/query/<fusion_qprofile_*>`
  (context switched to `api/apps`, handler `query/<profile>`) instead of the default `/api/solr/<app>/select`.
- All other Solr operations use the inherited `/api/solr` context.
- `pingServer()` → `pingCore()` (Fusion has no `admin/info/system`); `reloadCore()` is a no-op returning TRUE.
- When `fusion_click_signals` is on, `queryProfile()` swaps Solarium's adapter to `Http` so the
  `x-fusion-query-id` response header is available (needed to correlate click signals).
