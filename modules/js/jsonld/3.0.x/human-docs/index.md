# JSON-LD — manual setup guide

**JSON-LD** (`jsonld`) teaches Drupal to output your content entities as
[JSON‑LD](https://json-ld.org/) — a standard, machine‑readable "Linked Data"
format. It registers a new serializer format called `jsonld` that turns a node
(or any content entity) into a JSON‑LD `@graph` document. It was originally
built for the **Islandora** project so Drupal content can travel back and forth
as LDP/Fedora resources, but it works for any site that wants standards‑compliant
Linked Data output.

This is a **developer / back‑end module**, not a click‑and‑go feature. Enabling
it does *not*, on its own, publish your entities at any URL. Instead it plugs a
new format into Drupal's serialization system. You get JSON‑LD in one of two
ways: by calling the serializer service in code
(`\Drupal::service('serializer')->serialize($node, 'jsonld')`), or by enabling a
REST/serialization‑aware route and requesting an entity with `?_format=jsonld`.

What actually appears in the output is controlled by **core's RDF module**, not
by JSON‑LD itself. The normalizer walks each field, skips any field that has no
RDF mapping on its bundle, enforces `view` access on the rest, and uses the
bundle's `rdf:type` as the document's `@type`. In other words: to shape your
JSON‑LD, you configure RDF mappings on your content types. Developers can go
further with two hooks — `hook_jsonld_alter_normalized_array` (change the output
array before it is encoded) and `hook_jsonld_field_mappings` (map custom field
types to XSD datatypes).

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — including the serializer service,
normalization‑context keys, the context endpoint, and the hooks — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — the small settings form (strip the
   `?_format=jsonld` suffix, register RDF namespaces).

## Where it lives in the admin menu

The module's only settings form is at **Configuration → Search and Metadata →
JsonLD** (`/admin/config/search/jsonld`). Because there is no "Configure" link on
the modules page, reach it from that menu path. It also exposes a read‑only
`@context` endpoint at `/jsonld/context/{entity_type}/{bundle}` (for example
`/jsonld/context/node/article`), which returns the JSON‑LD `@context` for a
bundle.

## How to use it

1. Install and enable the module (below).
2. On the content types you want to expose, configure their **RDF mappings** —
   the field predicates and the bundle's RDF type. Only mapped fields appear in
   the JSON‑LD output.
3. Produce JSON‑LD either from code with the `serializer` service, or over HTTP
   by enabling a REST resource and requesting the entity with `?_format=jsonld`.
4. Optionally adjust the two settings and, for developers, use the alter/field
   hooks to fine‑tune the output.
