# Configuration

Configuration has three parts: the endpoint connection (in `settings.php`), the
SPARQL graphs (an admin UI), and the field-to-RDF mappings.

## 1. Connect to your SPARQL endpoint (`settings.php`)

There is no admin form for the connection — you declare it as a database connection
named `sparql_default` in your site's `settings.php`:

```php
$databases['sparql_default']['sparql'] = [
  'prefix' => '',
  'host' => '127.0.0.1',
  'port' => '8890',
  'namespace' => 'Drupal\\Driver\\Database\\sparql',
  'driver' => 'sparql',
  'database' => 'data/endpoint', // optional endpoint path; defaults to 'sparql'
  'https' => FALSE,              // set TRUE to use HTTPS
];
```

Set `host`, `port`, `database` (the endpoint path), and `https` to match your
triple-store. Behind the scenes the connection wraps the EasyRDF library and speaks
the SPARQL 1.1 Graph Store HTTP Protocol. Note a documented limitation: IRIs cannot
contain the characters `{ } < " | \ ^` or a space.

## 2. SPARQL graphs

Named graphs let you store different versions or states (for example draft, sync,
published) of the same entity. Manage them at **Configuration → SPARQL → Graphs**
(`/admin/config/sparql/graph`), where you can list, add, edit, enable/disable,
reorder, and delete graphs. This is gated by the **Administer site configuration**
permission (individual add/edit/delete use entity access).

Each graph has an id, name, description, weight, and an optional list of entity
types it applies to (empty means all). Two things to understand:

- **Weight is priority.** The lowest-weight *enabled* graph is the "topmost" one —
  the default target for reads and writes. Only enabled graphs are consulted, and
  the module can fall back through a candidate list of graphs when loading an entity.
- **The shipped `default` graph** cannot be deleted or restricted to certain entity
  types; it can only be renamed.

This is what lets you, for example, load an entity from a specific graph, or save a
draft into one graph and later move it to another.

## 3. Field-to-RDF mapping

For SPARQL-backed entity types, Drupal fields must be mapped to RDF predicates and
datatypes. There are two levels:

- **Per-bundle mapping** — stored as a `sparql_mapping` config entity, which maps the
  entity's base fields and bundle to RDF types/predicates and the set of graphs to
  use.
- **Per-field column mapping** — stored in each field's storage third-party settings.
  Every field column gets a `predicate` and a value `format` (an RDF datatype, a
  resource/URI, a literal, or a translatable literal). The module converts between
  Drupal field columns and typed RDF values automatically, including datetime and
  translatable-literal conversions.

In practice, a consumer module such as RDF Entity usually defines these mappings for
its entity types; you adjust them where needed.

## Note on where settings live

There is no single "settings" config object for this module. Its configuration is the
combination of the `settings.php` connection, the `sparql_graph` config entities, and
the field/bundle mappings described above. All SPARQL query values are escaped
centrally by the module (using EasyRDF's N-Triples serializer), so user-supplied
values are not concatenated raw into SPARQL statements.
