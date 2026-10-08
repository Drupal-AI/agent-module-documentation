# Configuration

RDF Sync is configured in two places: a **global settings form** that tells it
where your triplestore is, and **per-bundle / per-field mappings** that decide
which data actually becomes triples.

## The settings form

1. Log in as a user who can administer site configuration.
2. Go to **Configuration → System → RDF Sync**, or navigate directly to
   `/admin/config/system/rdf-sync`.

Here you configure how RDF Sync reaches your RDF store:

- **RDF graph URI** — the graph in the triplestore that RDF Sync writes to.
- **Endpoint** — the connection details for the SPARQL server: protocol, host,
  and port, together with the **query**, **update**, and **graph-store** paths.

> **Keep credentials out of your configuration export.** Because the endpoint may
> require authentication, store any secrets in environment variables rather than
> hard-coding them, following your site's usual secrets handling.

Save the form once the endpoint is correct.

## Defining mappings

A **mapping** links an entity field property to an RDF **predicate**. When an
entity is synchronised, each mapped property becomes a triple:

- **subject** — the entity's URI,
- **predicate** — the RDF predicate you mapped the property to,
- **object** — the property's value (a literal, or a URI pointing at another
  resource).

Mappings can be defined in configuration (for entity types whose bundles are
config entities, such as nodes and taxonomy terms) or in code. There are two
levels:

### Bundle-level mappings

Open the bundle's edit form — for article nodes, for example,
`/admin/structure/types/manage/article` — and fill in the values under the
**RDF sync** section. This is also where the bundle's **RDF type** is
established: the RDF resource URI that identifies the bundle in RDF. (Taxonomy
terms are a special case in the RDF world and provide a mapping for the bundle
field itself.)

### Configurable-field mappings

Open the field's configuration form — for the article body, for example, the
body field's settings under that content type — and set the RDF predicate for
that field there. Only fields you map are ever synchronised.

### Defining mappings in code

For entity types whose bundles are not config entities, or when you prefer to keep
mappings in code, you can implement `hook_entity_bundle_info_alter()` to declare
them. See the sibling [`agent/`](../agent/start.md) docs and the project's own
documentation for the exact structure.

## Automatic vs. manual synchronization

By default, synchronization is **automatic**: inserting, updating, or deleting a
mapped entity immediately updates its representation in the triplestore. If you
need to pause that — for a bulk import, say — you can disable it and run
synchronization on demand:

```bash
drush rdf_sync:disable                       # turn off automatic sync
drush rdf_sync:synchronize node              # sync all mapped nodes
drush rdf_sync:synchronize node --bundle=page,article
drush rdf_sync:enable                        # turn automatic sync back on
```

The same controls are available from PHP through the `rdf_sync.synchronizer`
service.
