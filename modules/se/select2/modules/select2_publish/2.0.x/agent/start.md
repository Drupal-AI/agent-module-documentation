# select2_publish — agent start

Submodule of **select2**. Marks referenced entities in a Select2 entity-reference widget with
their published/unpublished status (only for entity types implementing `EntityPublishedInterface`).
Zero configuration — enable it and Select2 reference widgets gain status indicators. Depends on
`select2` and `form_options_attributes`.

- How it decorates options (element pre-render) and autocomplete matches (alter hook); the `select2.publish` library → [api/select2_publish.md](api/select2_publish.md)
- Parent module: [select2](../../../../2.0.x/agent/start.md)
