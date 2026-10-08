# RDF Sync — manual setup guide

**RDF Sync** (`rdf_sync`) synchronizes Drupal entities to an external RDF
backend (a triplestore) as **semantic triples**. When you map a field property to
an RDF predicate, RDF Sync serialises that value and pushes it to the configured
RDF store, so your entity data is published as linked data for external
semantic-web consumers.

Each synchronised entity is identified in the triplestore by an **Entity URI** —
a universally unique URI that acts as the *subject* of all the triples
representing that entity. For every field property you map, RDF Sync writes a
triple whose subject is the entity URI, whose predicate is the RDF predicate you
mapped the property to, and whose object is the property's value. By default this
happens **automatically** whenever an entity is created, updated, or deleted (only
mapped fields are synchronised); you can also switch to **manual** synchronization
and drive it from code or Drush.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — point RDF Sync at your triplestore
   and define which fields become triples.

## Where it lives in the admin menu

The main settings form is at **Configuration → System → RDF Sync**
(`/admin/config/system/rdf-sync`), where you set the RDF graph URI and endpoint.
Field mappings are defined on the individual bundle edit forms and field
configuration forms (see [Configuration](configuration/index.md)).

## How to use it

1. Configure the RDF graph URI and endpoint at `/admin/config/system/rdf-sync`.
2. Define **mappings** — which entity field properties map to which RDF
   predicates — either in the admin UI or in code.
3. Create, edit, or delete mapped entities and let automatic synchronization push
   the corresponding triples, or disable automatic sync and run it manually:

   ```bash
   # Disable automatic synchronization
   drush rdf_sync:disable

   # Synchronize all nodes with a mapped node type
   drush rdf_sync:synchronize node

   # Only page and article nodes
   drush rdf_sync:synchronize node --bundle=page,article

   # Re-enable automatic synchronization
   drush rdf_sync:enable
   ```

The same operations are available from PHP via the `rdf_sync.synchronizer`
service.
