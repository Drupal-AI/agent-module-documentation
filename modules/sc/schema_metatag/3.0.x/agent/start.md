# schema_metatag — agent start

Base framework layering Schema.org JSON-LD onto the Metatag module. No UI of its own:
enable per-type submodules (schema_article, schema_event, schema_product, …) and configure
their tags under **Metatag** settings. On page render it collects schema tags and emits one
`<script type="application/ld+json">` in the head.

- How JSON-LD is collected & rendered; `SchemaMetatagManager` service → [api/manager.md](api/manager.md)
- Add a new Schema.org type (Group + Tag + PropertyType plugins) → [plugins/schema-types.md](plugins/schema-types.md)
- Alter tags / property types via hooks → [hooks/hooks.md](hooks/hooks.md)
