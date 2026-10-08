# select2 — agent start

Integrates the Select2 JS library. Provides two field widgets — `select2` (list fields) and
`select2_entity_reference` (entity reference, with autocomplete + autocreate/tags) — and a
`#type => 'select2'` render element. External JS lib lives at `/libraries/select2`; loaded via
the `select2/select2` asset library. AJAX autocomplete uses the `select2.entity_autocomplete`
route. No admin settings form (`configure` is null); config lives on each field widget.

- Enable the Select2 widgets on select / entity reference fields; autocomplete + create-new → [configure/select2.md](configure/select2.md)
- The `#type => 'select2'` render element, autocomplete route, matcher service + alter hook → [api/select2.md](api/select2.md)
- Select2 JS asset library, per-theme skinning (`select2.theme`), Claro/Gin/Seven CSS → [theming/select2.md](theming/select2.md)
- Override Select2 options (`#select2`), custom autocomplete callbacks, subclass the widget → [extend/select2.md](extend/select2.md)
- Submodules: [select2_facets](../../modules/select2_facets/2.0.x/agent/start.md) · [select2_publish](../../modules/select2_publish/2.0.x/agent/start.md)
