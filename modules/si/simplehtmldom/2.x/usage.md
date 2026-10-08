<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A thin bridge that makes the third-party PHP Simple HTML DOM Parser library available to Drupal modules, with no configuration of its own.

---

The module does nothing at runtime beyond pulling in the `simplehtmldom/simplehtmldom` Composer library (installed at 2.0-RC2 here) so its parsing API — `str_get_html()`, `file_get_html()` and the DOM traversal/selector helpers — can be called directly from any custom module. The library is tolerant of broken markup, which is its main appeal over strict DOM parsers.

There is no admin UI, no route, no permission and no service; it is a dependency other code declares. A developer requires it, enables it, and then parses HTML with jQuery-like selectors to extract or rewrite content (for scraping, importing, cleaning up user HTML, or transforming remote pages). Security responsibility sits with the caller: anything fetched from a remote URL and parsed should be treated as untrusted, and the library should not be used to parse attacker-controlled markup and echo it back without sanitization.

---
- Enable so custom code can call the Simple HTML DOM Parser functions
- Parse an HTML string with `str_get_html($html)`
- Load and parse a remote/local page with `file_get_html($url)`
- Select nodes with CSS-style selectors (`$dom->find('a')`)
- Extract link `href` and text from a page
- Scrape structured data out of a third-party page during an import
- Clean up or normalise broken/malformed HTML markup
- Rewrite or strip specific tags before storing content
- Extract image sources from remote HTML
- Pull table rows into a structured array for migration
- Build a Feeds/Migrate fetcher that needs DOM traversal
- Extract meta tags or Open Graph data from a fetched page
- Convert scraped HTML fragments into render arrays
- Declare it as a dependency of a custom scraping module
- Use it as a lenient alternative to core DOMDocument for messy input
- Keep the library managed by Composer rather than hand-installing it
