# External Hreflang — agent index

Adds a Metatag tag (`hreflang_external`) for declaring `rel="alternate" hreflang` links that
point at **other domains**. No admin page of its own — you configure it inside Metatag. Requires
the Metatag module.

- **Where/how to set the external hreflang value, its `langcode|url` syntax, storage** →
  [configure/metatag.md](configure/metatag.md)
- **The Metatag Tag plugin, its `output()`, parsing, and the Simple Sitemap hook** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Metatag tag id `hreflang_external`, label "External Hreflang", group `advanced`, `multiple = TRUE`.
- Value: one alternate per line, `langcode|url` (e.g. `en-US|https://us.example.com`); tokens
  such as `[current-page:url:relative:en]` are supported.
- Stored where Metatag stores tags: `metatag_defaults` config entities (`global`, `front`,
  `node`, `node__article`, …) under `tags.hreflang_external`, or on an entity's metatag field.
- Renders `<link rel="alternate" hreflang="…" href="…">` per line; also feeds
  `hook_simple_sitemap_links_alter()` when Simple XML Sitemap is present.
- No configure route, permissions, config schema, Drush or plugin types of its own.
