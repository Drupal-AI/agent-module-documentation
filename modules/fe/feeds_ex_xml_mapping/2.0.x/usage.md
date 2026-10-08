Extends the [Feeds Extensible Parsers](https://www.drupal.org/project/feeds_ex) XML parser so that the XPath mappings (and optionally their per-target configuration) can be overridden on each individual Feed entity instead of being fixed on the shared Feed type.

---

By default a Feeds XML feed type defines one set of XPath expressions (context + per-field XPaths) that every feed of that type uses. This module lets a site opt a feed type into per-feed overrides via two third-party-setting checkboxes added to the feed type's *Mapping* page: "Override source mapping" and "Override source mapping configuration". When "source" override is enabled, each Feed edit form gains a *Context* field and an *XPath Parser Settings* table where the editor re-enters the XPath query per mapped target for that one feed; enabling "source_configuration" additionally exposes each target's configuration subform (e.g. entity-reference settings) and the "Unique" checkbox per property. The overridden mappings are stored on the Feed entity's `config.xml_parser` value (context, mappings, custom_sources) rather than on the feed type. At import time an `InitEvent` subscriber (`UpdateMappingsSubscriber`, priority 1024) runs before parsing and injects the feed's stored mappings/custom sources/context back onto the (in-memory) feed type so the standard feeds_ex XPath parser uses them. The module is glue on top of feeds_ex: it adds no permissions, no Drush, no routes, and no config UI of its own (`configure` null) — it works purely by altering the feeds mapping form (`hook_form_feeds_mapping_form_alter`), swapping the XML parser's feed-form class (`hook_feeds_parser_plugins_alter`), and its event subscriber. Config schema defines only the two boolean third-party settings.

---

- Let each RSS/XML feed of one feed type point at a differently structured XML document.
- Override the XPath context (the base query that selects each item) per feed.
- Give one feed a different XPath for the title field than another feed of the same type.
- Import from multiple vendors whose XML uses different element/attribute names with a single feed type.
- Re-map fields per feed without cloning the feed type for every source.
- Keep the shared feed-type mappings as defaults while a specific feed diverges.
- Expose per-target configuration (e.g. entity-reference match settings) per feed.
- Set the "Unique" property per mapping target on an individual feed for de-duplication.
- Onboard a new XML supplier by adding a feed and its XPaths instead of a new feed type.
- Handle feeds where the same logical field lives at different XPaths across sources.
- Let non-developers adjust XPath expressions for their own feed via the feed edit form.
- Correct a single misbehaving feed's XPath without touching other feeds.
- Migrate legacy XML exports whose schema varies between files.
- Aggregate news from several XML endpoints with heterogeneous structures.
- Prefill a new feed's override form with the feed type's current mappings as a starting point.
- Preserve non-XPath sources (e.g. `parent:*`) untouched while overriding XPath ones.
- Store per-feed mappings on the feed entity so they travel with the feed, not the type.
- Support older feeds_ex `sources` layout for backward compatibility during import.
