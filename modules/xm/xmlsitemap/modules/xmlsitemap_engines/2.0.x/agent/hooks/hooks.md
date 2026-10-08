# XML Sitemap Engines hooks

From `xmlsitemap_engines.api.php`:

- `hook_xmlsitemap_engine_info()` — register a search engine destination. Return an array
  keyed by engine id with a `name`, the `url` template used to ping/submit the sitemap, and
  optional metadata.
- `hook_xmlsitemap_engine_info_alter(&$engines)` — alter engines declared by other modules
  (change URLs, remove an engine, etc.).

Registered engines then appear as selectable options on the settings form
([configure/settings.md](../configure/settings.md)).
