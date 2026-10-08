<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings, default server, read-only, pinning a core

Acquia Search has **no `configure` route / admin form of its own**. You operate it through:
1. the **Search API** UI/config for its server (`/admin/config/search/search-api`), and
2. the `acquia_search.settings` config object (edit with `drush cset` or config import).

## `acquia_search.settings`

Schema: `config/schema/acquia_search_solr.schema.yml`. Install defaults from
`config/install/acquia_search.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `api_host` | `https://api.sr-prod02.acquia.com` | Acquia Search API endpoint (domain or URL, no trailing slash) used to discover cores |
| `extract_query_handler_option` | `update/extract` | Solr handler used for file/attachment content extraction |
| `read_only` | `false` | When `true`, the Acquia server is forced read-only (no writes/indexing) |
| `override_search_core` | `null` | Pin a specific Solr core id (e.g. `WXYZ-12345.prod.mysite`) instead of auto-detecting |

Set a value:

```bash
drush cset acquia_search.settings read_only true -y
drush cset acquia_search.settings override_search_core 'WXYZ-12345.prod.mysite' -y
drush cr
```

Read current values:

```bash
drush cget acquia_search.settings
```

> Legacy note: older versions used an `acquia_search_solr.settings` object with the same
> `override_search_core` key. `acquia_search.install` raises a requirements warning if either
> legacy override is set; migrate the value to `acquia_search.settings`.

## The default Search API server

Installed from `config/install/search_api.server.acquia_search_server.yml` as the config
entity **`acquia_search_server`** (`search_api.server.acquia_search_server`). Key fields:

- `backend: search_api_solr` with `backend_config.connector: solr_acquia_connector`
- `connector_config`: `scheme: https`, `timeout: 10`, `index_timeout: 10`,
  `optimize_timeout: 10`, `finalize_timeout: 30`, `commit_within: 1000`,
  `http_method: AUTO`, `jmx: false`, `skip_schema_check: true`
- `site_hash: true`, `domain: generic`

The module also defines its own `acquia_search_solr` backend plugin; a post_update
(`acquia_search_post_update_acquia_search_solr_backend`) and a `hook_search_api_server_load`
migrate/repair the server to that backend at runtime. **The default server and index cannot
be deleted from the UI** — `acquia_search_entity_operation_alter()` removes the delete
operation for `acquia_search_server` and `acquia_search_index`.

> The server config install has hard config dependencies on two `search_api_solr` Solr
> field-type entities (`text_und_6_0_0`, `text_phonetic_und_7_0_0`); if those are absent when
> the module is enabled, Drupal skips creating `acquia_search_server` and you create it yourself.

## Read-only mode (protecting shared cores)

Acquia Search enforces **read-only** on environments where writing could clobber a shared
production index (non-prod, or when the preferred core can't be resolved). While read-only,
the backend reports `overridden_by_acquia_search = READ_ONLY` and the server is prevented from
indexing. Turn it on explicitly with `read_only: true`; force it in code via
`hook_acquia_search_should_enforce_read_only_alter()` (see [../hooks/alters.md](../hooks/alters.md)).
If the preferred core is unavailable, `hook_search_api_server_load` disables the server.

## Per-index eDisMax parser

Each Search API index carries an Acquia third-party setting
(`search_api.index.*.third_party.acquia_search`) with a boolean `use_edismax`. When true the
`acquia_search.prequery.edismax` event subscriber switches the query to Solr's eDisMax parser.
Set it in the index config:

```yaml
third_party_settings:
  acquia_search:
    use_edismax: true
```

## Which core gets used

The module discovers **possible** cores for your subscription and picks a **preferred** one
per environment; `override_search_core` forces a specific id. Inspect this with the Drush
commands in [../drush/commands.md](../drush/commands.md).
