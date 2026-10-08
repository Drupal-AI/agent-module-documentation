# RDF Meta Entity — manual setup guide

**RDF Meta Entity** (`rdf_meta_entity`) is an extension of the
[Meta Entity](https://www.drupal.org/project/meta_entity) module for
semantic-web / RDF-published Drupal sites. Meta Entity lets you attach "side-car"
metadata entities to any host entity — things like view counts, ratings, or
computed values — without changing the host entity's own schema. RDF Meta Entity
provides a variant of that whose storage is a **SPARQL triplestore** instead of
Drupal's database, so the metadata lives as RDF triples.

Concretely, it defines an `rdf_meta_entity` content entity type plus an
`rdf_meta_entity_type` bundle configuration entity, both stored through the
**SPARQL Entity Storage** backend, and it registers a `meta_entity.repository`
service for the new meta-entity type. This is aimed at sites already invested in
the SPARQL entity-storage ecosystem that want to keep derived metadata as triples
alongside their published data.

This is a developer/architecture-level module: there is no anonymous or
public-facing feature, and entity CRUD goes through Drupal's standard entity
system and access handlers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   SPARQL dependencies, and enable it.

There is **no simple settings form** for this module. It adds one administrative
listing page and relies on you defining meta-entity types; see "How to use it"
below.

## Where it lives in the admin menu

The module adds a single administration page at
**`/admin/structure/rdf-meta-entity`**, gated by the **Administer RDF meta
entity** permission (which is access-restricted). Per-bundle permissions are also
generated automatically for the meta-entity types you define.

## How to use it

1. Make sure the **Meta Entity** and **SPARQL Entity Storage** modules are
   installed and that you have a working **SPARQL endpoint** configured (see
   [Installation](installation/index.md)).
2. Define one or more `rdf_meta_entity` types from
   `/admin/structure/rdf-meta-entity`, mapping their fields to the SPARQL
   backend. (The project's test module includes a `visit_count` example that
   shows the mapping pattern.)
3. Grant the appropriate per-bundle and **Administer RDF meta entity**
   permissions to the roles that should manage these meta-entities.
4. Your metadata is now stored and queried as RDF triples through the SPARQL
   store, keeping the host entities' own schemas untouched.
