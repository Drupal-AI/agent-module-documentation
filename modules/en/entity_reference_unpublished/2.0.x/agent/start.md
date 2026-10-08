# Entity Reference Unpublished — agent index

Adds entity-reference **selection handlers** that allow referencing *unpublished* content
(nodes, media, taxonomy terms), which core's default handlers hide. No settings page
(`configure: null`), no permissions.

- **Switch a reference field to an unpublished handler (UI + field config), the handler ids** →
  [configure/handler.md](configure/handler.md)
- **The three selection plugins and how they bypass the published-only filter** →
  [plugins/selection.md](plugins/selection.md)

Key facts: handler ids are **`unpublished`** (node), **`unpublished_media`** (media),
**`unpublished_taxonomy_term`** (taxonomy_term). To use one, set a field's
`settings.handler` to the id (UI: the field's **Reference method** = "Unpublished Default"
etc.). They extend the generic `DefaultSelection`, so the "published only" query condition is
never applied.
