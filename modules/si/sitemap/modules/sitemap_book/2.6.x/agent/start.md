# sitemap_book — agent start

Submodule of `sitemap`. Adds a **`book`** Sitemap plugin
(`src/Plugin/Sitemap/Book.php`, derived per book via `BookSitemapDeriver`) that lists
book outlines on the `/sitemap` page. Requires core `book` + `sitemap`.

- No UI of its own: enable/configure the book section (title, `show_expanded`, weight)
  in the base module's settings form → see
  [../../sitemap/2.6.x/agent/configure/settings.md](../../../sitemap/2.6.x/agent/configure/settings.md).
- Plugin type reference (how the section works / build your own) →
  [../../sitemap/2.6.x/agent/plugins/sitemap.md](../../../sitemap/2.6.x/agent/plugins/sitemap.md).
- Uses core `BookManagerInterface` to build the outline; config schema in
  `config/schema/sitemap_book.schema.yml`.
