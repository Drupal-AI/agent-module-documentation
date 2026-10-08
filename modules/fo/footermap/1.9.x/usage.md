Footermap provides a configurable block that renders a recursive HTML sitemap of your menus' non-hidden links, intended for the page footer as a "quick links" map.

---

The module ships one block plugin, `footermap_block` (category *Sitemap*), that you place and
configure like any block. Its settings choose which menus to include (`footermap_avail_menus`),
an optional recursion depth limit (`footermap_recurse_limit`, 0 = unlimited), whether to show each
menu's name as a column heading (`footermap_display_heading`), and an optional top-level menu-link
plugin id to root the tree at a sub-branch (`footermap_top_menu`). It loads each selected menu via
the core `menu.link_tree` service with `onlyEnabledLinks()` + `excludeRoot()`, then renders it
through three theme hooks (`footermap`, `footermap_header`, `footermap_item`) with matching Twig
templates. Crucially, access is checked as the **anonymous** user: the module supplies its own
`AnonymousMenuLinkTreeManipulator` (a backwards-compatible copy of core's
`DefaultMenuLinkTreeManipulators`) wired with an `AnonymousUserSession`, so the sitemap always
shows only links a visitor without an account could reach — this keeps the block cacheable and
avoids leaking access-restricted links, at the cost of not showing per-user links. Inaccessible
links are replaced with `InaccessibleMenuLink` and dropped. The block's own `access()` returns
allowed (visibility is controlled by normal block placement/visibility settings). There is no
global config page, no permissions, and no Drush; everything lives in block configuration. The
help text warns against generating a full sitemap in the footer without caching.

---

- Add a footer "quick links" sitemap block listing your main menu links.
- Show multiple menus (Main, Footer, Account) side by side as columns in the footer.
- Limit the sitemap depth so only top-level items appear.
- Render an unlimited-depth recursive map of a menu hierarchy.
- Display each menu's name as a heading above its column.
- Hide column headings for a compact link list.
- Root the map at a deep menu branch using a specific menu-link plugin id.
- Provide a consistent public sitemap that only shows links anonymous visitors can access.
- Avoid leaking access-restricted menu links into the footer (anonymous access check).
- Place the sitemap block in any region, not just the footer, via block layout.
- Restrict the block's visibility with standard block visibility conditions (pages, roles).
- Give a large site a lightweight, cacheable footer navigation aid.
- Show a secondary/utility menu as a footer link map.
- Combine several small menus into a single footer sitemap block.
- Style the sitemap with the provided `footermap` CSS library and BEM-style classes.
- Override the `footermap`, `footermap_header`, or `footermap_item` templates for custom markup.
- Present menu items sorted by weight within each column.
- Build a "browse everything" footer for a documentation or marketing site.
- Reuse the block on multiple pages via block layout placement.
- Offer keyboard/screen-reader-friendly footer navigation from menu structure.
- Keep the footer map in sync automatically as menu links change (built at render time).
- Limit a deep menu to two levels in the footer while the full menu shows elsewhere.
