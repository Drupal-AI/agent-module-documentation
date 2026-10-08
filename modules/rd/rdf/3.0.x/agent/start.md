# rdf — agent start

Adds RDFa semantic metadata to Drupal's HTML by mapping entity bundles/fields to RDF
vocabularies (Schema.org, SIOC, Dublin Core, FOAF). Mappings are `rdf.mapping.*` config
entities; no admin UI, no permissions. Formerly Drupal core, now contrib.

- Manage `rdf_mapping` config entities (per entity-type/bundle) → [configure/rdf.md](configure/rdf.md)
- Read/write mappings in code (`rdf_get_mapping`, `RdfMapping` entity, namespaces) → [api/rdf.md](api/rdf.md)
- Define namespace prefixes via `hook_rdf_namespaces()` → [hooks/rdf.md](hooks/rdf.md)
- RDFa preprocessing, `rdf_metadata` theme hook, templates → [theming/rdf.md](theming/rdf.md)
