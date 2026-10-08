<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — endpoint, graphs, field mappings

## 1. SPARQL endpoint connection (settings.php)
No admin form for the connection — declare it as a database connection named `sparql_default`:

```php
$databases['sparql_default']['sparql'] = [
  'prefix' => '',
  'host' => '127.0.0.1',
  'port' => '8890',
  'namespace' => 'Drupal\\Driver\\Database\\sparql',
  'driver' => 'sparql',
  'database' => 'data/endpoint', // optional endpoint path, defaults to 'sparql'
  'https' => FALSE,              // TRUE to use HTTPS
];
```
The `sparql.endpoint` service (`Connection`, classmap-autoloaded from
`src/Driver/Database/sparql/Connection.php`) wraps EasyRDF and speaks the SPARQL 1.1 Graph Store HTTP Protocol.
IRIs cannot contain `{ } < " | \ ^ `` `(space)` (documented limitation).

## 2. SPARQL graphs (`sparql_graph` config entity)
Named graphs allow storing versions/states (draft, sync, …) of the same entity.
- Admin UI: `/admin/config/sparql` and `/admin/config/sparql/graph` (list, add, edit, enable/disable, delete)
  — all under `administer site configuration` (graph add/edit/delete use entity access).
- Config: `sparql_entity_storage.graph.<id>` — `id`, `name`, `description`, `weight`, `entity_types`
  (null = all). Shipped `default` graph cannot be deleted or restricted, only renamed.
- **Weight = priority**: the lowest-weight enabled graph is the "topmost" (default read/write target). Only
  enabled graphs are consulted.
- Managed programmatically via the `sparql.graph_handler` service.

## 3. Field → RDF predicate mapping
- Per-bundle mapping is the `sparql_mapping` config entity (`sparql_entity_storage.mapping.*`) — maps the
  entity's base fields and bundle to RDF types/predicates and the graph set.
- Per-field column mapping lives in field storage third-party settings
  (`field.storage.*.*.third_party.sparql_entity_storage`): each column has a `predicate` and a value `format`
  (RDF datatype / `resource` / literal / translatable literal).
- `SparqlEntityStorageFieldHandler` (`sparql.field_handler`) converts between Drupal columns and typed RDF
  values; inbound/outbound datetime and translatable-literal conversions are done by event subscribers.

There is no single "settings" config object; configuration is the connection + these config entities + field
third-party settings.
