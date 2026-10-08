<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Backend Utils (butils) bundles frequently reused backend snippets into one autowired service and Twig extension for developers.

---

The `butils` service (`Drupal\butils\BUtils`) composes ~30 traits, each grouping helpers: Array (path lookups), Csv (load/write), DateTime (timezone-aware conversion), DomDocument, Entity (`toEntity`, `deref`, view-mode build/render, word counts), Field (definitions, empty, render), File, Image style, Json/JsonApi, Media, Menu, Paragraphs, Redirects, Sql query, State, String, Taxonomy, Truncate HTML, Uri, User, Views and Xml. A `ButilsTwigExtension` exposes helpers to templates, a `DebugLog` event subscriber logs debug info, and the module adds a JSON metadata field type/widget/formatter (`json_metadata`). `hook_node_insert/update` also invoke a custom `node_save` hook so other modules can react to node saves uniformly. `butils_page_entity()` returns the current page's main entity.

It has no routes, permissions or admin UI — it is a code-level dependency. No request-facing attack surface; helpers operate on data your own code passes in.

---
- Get a nested array value by dotted path (`arrayMap`)
- Load a CSV file into keyed rows (`loadCsv`)
- Write an array out to CSV (`writeCsv`)
- Convert a date string to a timestamp honoring timezone
- Format a datetime for a Drupal datetime field
- Get or create an entity matching given values (`toEntity`)
- Dereference an entity value by path incl. reference fields (`deref`)
- Build/render an entity in a given view mode
- Count words in a rendered entity
- List a bundle's field definitions and types
- Empty a field correctly by removing the instance
- Render a single field without wrappers/labels
- Read a field value by ids without loading the entity
- Truncate HTML safely to a length
- Extract inner HTML of a DOM node
- Work with taxonomy term helpers
- Manipulate paragraphs programmatically
- Generate/handle redirects in code
- Use butils helpers inside Twig templates
- React to all node saves via the `node_save` invoke-all hook
- Store/read arbitrary JSON on entities with the json_metadata field
- Get the current page's main entity (`butils_page_entity`)