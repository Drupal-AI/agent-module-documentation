# RDF mappings — configuration

RDF has **no admin UI**. Mappings are `rdf_mapping` config entities, one per
entity-type + bundle, config prefix `rdf.mapping.<entity_type>.<bundle>`
(e.g. `rdf.mapping.node.article`). Managed via code/config only (`admin_permission`
on the entity is `administer site configuration`).

Config entity keys (`config_export`): `id`, `targetEntityType`, `bundle`, `types`
(array of RDF classes for the bundle, e.g. `['schema:Article', 'sioc:Post']`),
`fieldMappings` (per-field: `properties`, optional `datatype`, `datatype_callback`,
`mapping_type`).

Example `rdf.mapping.node.article.yml` (config/optional):
```yaml
id: node.article
targetEntityType: node
bundle: article
types:
  - 'schema:Article'
fieldMappings:
  title:
    properties: [ 'schema:name' ]
  created:
    properties: [ 'schema:dateCreated' ]
    datatype: 'xsd:dateTime'
    datatype_callback: { callable: 'Drupal\rdf\CommonDataConverter::dateIso8601Value' }
```

- Ship defaults for your bundle by placing such a file in your module's
  `config/optional/`. Core ships mappings for article, page, forum, user, tags, comment.
- Config schema lives in `config/schema/rdf.schema.yml`; do not hand-edit unless you
  are extending the schema.
- To edit at runtime use the API rather than the UI → [../api/rdf.md](../api/rdf.md).
