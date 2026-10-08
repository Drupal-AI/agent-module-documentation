<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Source GraphQL (migrate_source_graphql) — agent index

Provides one Migrate **source plugin**, id `graphql`, that runs a **single configured query**
against a GraphQL endpoint and yields the returned objects as migration source rows. Depends on
core `migrate`; bundles the `gmostafa/php-graphql-client` library. Version **2.1.1**, core
`^8 || ^9 || ^10 || ^11`. No permissions, no routes, no config schema, no Drush commands, no UI —
it is configured entirely from a migration YAML's `source:` section.

## What it actually does
- `GraphQL` source plugin (`src/Plugin/migrate/source/GraphQL.php`) extends `SourcePluginBase`.
  Constructor requires `endpoint` and `query`; throws `\InvalidArgumentException` if either is empty.
- `initializeIterator()` → `getGenerator()`: builds a `GraphQL\Query` from the nested `query` array
  (`GraphQL/Client::buildQueryRecursive`), runs **one** POST request, then walks the response.
- Response navigation: `data_key` (default `data`) is split on `/` (`Row::PROPERTY_SEPARATOR`); a `%`
  segment maps over an indexed array and extracts the next-named sub-field from each element.
- Dispatches `ResultsEvent` (`src/Event/ResultsEvent.php`) so other modules can `getResults()` /
  `setResults()` to alter the result set before rows are yielded.
- Each result is `json_decode(json_encode($result), TRUE)` and `yield`ed as an assoc source row.
- `getIds()` returns the `ids` config (default `['id' => ['type' => 'string']]`). `fields()` derives
  field names from the query's `fields`.

## Config keys (migration `source:`)
- `endpoint` (required) — GraphQL API URL.
- `query` (required) — `{ <queryName>: { arguments: {...}, fields: [ { <dataKey>: [ ...fields ] } ] } }`.
- `auth_scheme` (optional) — e.g. `Basic`, `Bearer`, `Digest`; combined with `auth_parameters` into
  the `Authorization` header.
- `auth_parameters` (optional) — the credential/token. **Note the plural**: the plugin reads
  `auth_parameters`; some README examples wrongly show `auth_parameter` (singular), which yields an
  empty header value.
- `data_key` (optional, default `data`) — property path to the row array; `/`-separated, `%` = index map.
- `ids` (optional, default `{id: {type: string}}`) — source unique key(s).

## What it is NOT
- No automatic pagination / cursor-following. One run = one query = one page. Any paging, filtering,
  or search must be encoded in the query `arguments` yourself.
- No retry or rate-limit handling. On `QueryError` it adds the message via `\Drupal::messenger()`
  and stops, rather than failing the migration hard.

## Solution docs
- `agent/migrate/source-plugin.md` — full config reference, response navigation, event, gotchas.

## Transport / security notes
- The bundled client uses Guzzle with default options (TLS verification **on**); the module passes
  no HTTP options and does not disable verification.
- Endpoint, query, and auth credentials are migration configuration (developer/admin-supplied, CLI/UI
  run), not request input; migration config is exportable, so manage the source YAML like any other
  configuration that can carry connection settings.
