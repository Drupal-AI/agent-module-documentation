Pager metadata improves SEO on paginated pages by making the canonical `<link>` page-aware and by emitting `rel="prev"` / `rel="next"` head links for the previous and next pager pages.

---

The module is entirely automatic — there is no config UI (`configure` is null), no permissions, and no plugins. On every request it runs three hooks. `hook_page_attachments_alter()` rewrites the page's `canonical_url` head link so it carries the current `?page=N` query argument (so page 2 of a listing has its own canonical instead of pointing at page 1), adding the `url.query_args.pagers` cache context; this can be disabled with the `pager_metadata_alter_canonical` setting in `settings.php`. `hook_preprocess_pager()` and `hook_preprocess_views_infinite_scroll_pager()` inspect the rendered pager's `previous`/`next` items and inject `<link rel="prev">` / `<link rel="next">` into the HTML head (via `#attached['html_head_link']`), pointing at the current route with the appropriate `page` query argument (dropping `page=0` for the first page). A `hook_block_build_alter()` sets `#create_placeholder = FALSE` on `views_block` blocks so that the pager preprocess can still contribute to the `<head>` even when the view is rendered inside a block (placeholdered/lazy-built blocks would otherwise render too late to alter the head). The module sets its own weight to `1` on install so its preprocess runs after other modules'. It works with core pagers and with Views Infinite Scroll pagers.

---

- Give each paginated listing page (`?page=1`, `?page=2`, …) its own page-specific canonical URL instead of all pages sharing page 1's canonical.
- Emit `rel="prev"` and `rel="next"` head links across a multi-page listing to signal pagination to search engines.
- Improve crawlability of long Views listings that use a pager.
- Reduce duplicate-content signals on paginated content, glossary, or archive pages.
- Add pagination metadata to a blog or news index split across many pager pages.
- Support Views Infinite Scroll pagers with correct prev/next head links.
- Keep canonical tags correct when a View with a pager is rendered inside a block (`views_block`).
- Automatically drop the redundant `page=0` from the first page's prev link.
- Add pager SEO metadata site-wide with zero configuration after enabling the module.
- Disable the canonical rewriting behavior via `settings.php` (`pager_metadata_alter_canonical`) while keeping rel prev/next.
- Ensure the correct per-page cache variation using the `url.query_args.pagers` cache context.
- Provide search engines with sequential navigation hints for taxonomy term listing pages.
- Add rel prev/next to a product catalog or search results page that uses core pagination.
- Improve SEO of a comment thread paginated across multiple pages.
- Complement a metatag/SEO setup that does not itself handle pager-aware canonicals.
- Avoid hand-coding pager head links in a custom theme.
- Guarantee the module's hooks run last by relying on its install-time module weight of 1.
