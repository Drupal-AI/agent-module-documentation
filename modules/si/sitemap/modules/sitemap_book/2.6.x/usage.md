A Sitemap submodule that adds a Book section to the human-readable sitemap page, listing each book's outline (optionally expanded) alongside the module's other sections.

---

sitemap_book registers a `book` Sitemap plugin (derived per book via `BookSitemapDeriver`) so that each book outline on the site can be shown on the `/sitemap` page. It depends on both core's Book module and the base Sitemap module. Each derived book section is configured through the standard Sitemap settings UI, where you enable it, set its weight, optionally override the displayed title, and choose whether the outline is shown fully expanded (`show_expanded`) or collapsed. The plugin uses core's `BookManagerInterface` to build the outline tree, reusing Sitemap's rendering and theming. It ships config schema for its settings but no permissions, services, or Drush commands of its own. It is a small convenience module for sites that organize content into books and want that hierarchy surfaced on the site overview page.

---

- Show a book's full outline on the `/sitemap` page.
- List multiple books, each as its own sitemap section.
- Display a book outline expanded to all levels.
- Show a book collapsed to top-level pages only.
- Override the heading shown for a book section.
- Order the book section relative to menus and vocabularies via weight.
- Give visitors a hierarchical overview of documentation books.
- Surface a knowledge-base book structure for navigation.
- Include a book outline in the human-readable site index.
- Reuse Sitemap's theming/templates for book output.
- Enable book listing only for selected books.
- Combine book outlines with menu and taxonomy sections on one page.
- Provide an accessible text overview of a book's chapters.
- Help users find deep book pages from a single index.
- Present a table-of-contents style view of a book.
- Keep book navigation visible outside the book block.
- Add book structure to the sitemap without custom code.
- Support multi-book sites with per-book configuration.
