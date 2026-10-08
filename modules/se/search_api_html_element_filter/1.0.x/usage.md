Search API HTML Element Filter adds a Search API field processor that strips HTML elements matching given CSS selectors out of field values before they are indexed (and, optionally, out of rendered search results).

---

The module ships a single Search API processor plugin, `html_element_filter` (class `HtmlElementFilter`, extending `FieldsProcessorPluginBase`). You add it to a Search API index and configure a textarea of **CSS selectors** — one per line — identifying the elements to remove (for example `.sidebar-filters`, `.advert`, `nav`). During indexing it parses each processed text field with Symfony's DomCrawler, finds every node matching a selector, and removes it from the DOM so that unwanted boilerplate (menus, filter widgets, adverts, "related content" blocks) never becomes searchable text. It runs at the `preprocess_index` stage; an optional **Enable post-process query** checkbox (`enable_postprocess_query`, on by default) also runs the same stripping over the field values of returned result items at `postprocess_query` so highlighted snippets are clean too. Invalid selectors are validated on the config form (via a DomCrawler test parse) and silently ignored at runtime, so a bad selector never breaks indexing. It has no admin page, permissions, Drush commands or config of its own — all settings live in the host index's `processor_settings`.

---

- Stop a page's navigation menu markup from being indexed as searchable body text.
- Remove sidebar filter/facet widgets (`.sidebar-filters`) from indexed content.
- Strip advertisement blocks (`.advert`, `.ad-slot`) out of indexed HTML.
- Exclude "related articles" or "you may also like" blocks from search text.
- Keep cookie-consent banners and other boilerplate out of the index.
- Clean rendered-entity/viewmode fields that include chrome you do not want searched.
- Prevent breadcrumb markup from polluting relevance scoring.
- Remove social-share button widgets from indexed content.
- Drop `<script>`/`<style>`-wrapped widgets by targeting their container class.
- Exclude a specific region (e.g. `.region-footer`) from index content.
- Also strip the same elements from result snippets by leaving post-process query on.
- Only clean the index (not results) by unchecking Enable post-process query.
- Improve search relevance by indexing only the meaningful article body.
- Reduce index size by removing repeated template markup across pages.
- Target elements by tag, class, id or any valid CSS selector.
- Apply several selectors at once, one per line, to a single index.
- Avoid indexing editor-only helper blocks embedded in body fields.
- Keep call-to-action banners out of full-text search.
- Sanitize third-party embedded markup before it reaches the index.
- Scope the filter to specific fields (via the processor's field selection) or all text fields.
- Prevent duplicate-looking results caused by shared boilerplate matching queries.
- Clean up a rendered_item field produced by the "Rendered HTML output" property.
- Remove print-only or screen-reader-only helper markup from indexed text.
- Safely ignore malformed selectors without breaking the indexing pipeline.
