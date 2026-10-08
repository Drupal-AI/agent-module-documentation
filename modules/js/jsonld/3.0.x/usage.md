<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON-LD registers a `jsonld` serializer format that turns Drupal content entities into JSON-LD (Linked Data) documents, mapping fields to RDF properties via the core RDF module. It was built for the Islandora Project so Drupal content can round-trip as LDP/Fedora resources, but it works for any site that wants standards-compliant JSON-LD output.

---

Enabling the module adds a set of tagged serializer normalizers (priority 10–20) plus an encoder for the `jsonld` format; it does **not**, by itself, expose your entities at a URL. You get JSON-LD either by requesting an entity route that negotiates `?_format=jsonld` (via a REST/serialization-aware route) or by calling `\Drupal::service('serializer')->serialize($entity, 'jsonld')`. Output is driven **entirely by the core RDF module's mappings**: the normalizer walks each field, skips any field that has no `rdf_mapping` on its bundle, enforces `view` access on the rest, and emits an `@graph` whose node `@id` is the entity URI and whose `@type` comes from the bundle's `rdf:type`. Field types are mapped to XSD/`@id` datatypes through `hook_jsonld_field_mappings` (the module ships defaults for datetime, integer, file/image as `@id`, etc.). Two config options exist at `/admin/config/search/jsonld`: strip the default `?_format=jsonld` suffix from generated `@id`s, and register additional RDF namespace prefixes (merged into core RDF namespaces via `hook_rdf_namespaces`). A separate context endpoint, `/jsonld/context/{entity_type}/{bundle}`, returns the JSON-LD `@context` for a bundle. You customize the output with `hook_jsonld_alter_normalized_array` (mutate the normalized array before encoding) and `hook_jsonld_field_mappings` (add/override field-type datatypes). The module depends on `hal` (for entity/type URIs) and `rdf` (for mappings and namespaces).

---

- Serialize a node to JSON-LD in code with `serializer->serialize($node, 'jsonld')` for an export or indexing job.
- Expose entities as JSON-LD over HTTP by enabling a REST resource and requesting `?_format=jsonld`.
- Publish Drupal content as LDP/Fedora resources for an Islandora repository.
- Emit `schema.org`-typed Linked Data for a bundle by configuring its RDF mapping (types + field predicates).
- Feed a triplestore or SPARQL pipeline with RDF derived from Drupal entities.
- Provide machine-readable, semantically-typed metadata for search engines and Linked Data consumers.
- Fetch the JSON-LD `@context` for an entity bundle from `/jsonld/context/{entity_type}/{bundle}`.
- Control which fields appear in the output by adding or removing RDF field mappings (unmapped fields are omitted).
- Map a custom field type to an XSD datatype (e.g. `xsd:dateTime`, `xsd:anyURI`) with `hook_jsonld_field_mappings`.
- Register custom RDF namespace prefixes site-wide via the settings form (or `hook_rdf_namespaces`).
- Strip the `?_format=jsonld` suffix from `@id` values so URIs match your canonical resource URLs.
- Inject extra triples (e.g. an author `schema:Person` node) into an entity's `@graph` with `hook_jsonld_alter_normalized_array`.
- Embed referenced entities as `@id` links so consumers can crawl the Linked Data graph.
- Represent file/image fields as dereferenceable `@id` URIs pointing at the file resource.
- Limit output to a subset of fields (e.g. an LDP/fcrepo-compatible view) using the `included_fields` normalization context.
- Deserialize incoming JSON-LD/HAL back into a Drupal entity for write operations (the normalizer implements `denormalize()`).
- Produce a compacted document with an inline `@context` by passing `needs_jsonldcontext` in the normalization context.
- Localize literal values: string fields are emitted with `@language` tags from the entity's langcode.
- Attach correct cache metadata to the context endpoint response so it invalidates when the RDF mapping changes.
- Integrate Drupal into a Linked Data Platform (LDP) client that expects `application/ld+json`.
- Migrate an Islandora 7 → Islandora (Drupal) metadata model while keeping JSON-LD as the interchange format.
