# Feeds Extensible Parsers XML Mapping — agent index

Glue module for [feeds_ex](https://www.drupal.org/project/feeds_ex): lets the XML parser's XPath
mappings be overridden **per Feed entity** instead of only on the shared Feed type. No permissions,
no Drush, no routes, no config UI (`configure` null). Depends on `feeds_ex`. Only config schema is the
two boolean third-party settings on the feed type.

- **How to turn on per-feed override, the two third-party settings, and where overrides are stored /
  injected at import** → [configure/per-feed-override.md](configure/per-feed-override.md)
- **The internals for custom code — the altered feed form class, the helper, and the InitEvent
  subscriber that re-injects mappings before parsing** → [api/internals.md](api/internals.md)

Key facts:
- Enabled per feed type on `admin/structure/feeds/manage/{type}/mapping` → *Override mapping per feed*.
- Third-party settings `source` and `source_configuration` on `feeds.feed_type.*` under key
  `feeds_ex_xml_mapping`.
- Overrides stored on the Feed entity's `config[0]['xml_parser']` (`context`, `mappings`,
  `custom_sources`); injected onto the feed type in-memory by `UpdateMappingsSubscriber` on
  `FeedsEvents::INIT_IMPORT`.
