# Glossify Node — agent index

Provides the **`glossify_node`** text-format filter ("Glossify: Tooltips with nodes"), a subclass of
`GlossifyBase` that auto-links/tooltips published **node titles**. Enable it on a text format. No
settings form of its own (`configure` = core Text formats). Base engine details:
[../../../../3.1.x/agent/api/glossifybase.md](../../../../3.1.x/agent/api/glossifybase.md).

- **Enable & configure the filter: all settings keys, defaults, source query, synonyms** →
  [configure/filter.md](configure/filter.md)

Key facts:
- Term source: published nodes of the chosen **content types**, from `node_field_data` + `node__body`
  (body = tooltip text). Query tag: `glossify_node_tooltip`.
- Settings stored at `filter.format.<format>` → `filters.glossify_node.settings`. Selecting a content
  type is **required** when enabled. Default URL pattern `/node/[id]`.
