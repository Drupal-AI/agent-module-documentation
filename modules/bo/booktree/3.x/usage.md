Booktree renders a core Book outline as a nested HTML navigation tree at `/booktree`, letting you show one or several book hierarchies as a linked table-of-contents page.

---

Booktree depends on core's Book module and adds a controller-driven page that walks the `{book}` outline of a chosen root node and prints its descendants as nested `<ul>`/`<li>` links. A settings form (`/admin/config/booktree`) fixes the default root node id, the maximum tree depth and a title-trim length; the same three values can be overridden per request through the `/booktree/{node}/{depth}/{trim}` path so a single site can display different book trees on different pages. It ships no blocks, entities, permissions, Drush commands or plugins of its own — just three routes, one config object (`booktree.settings`), a config form and a hook_help implementation.

---

- Publish a full table of contents for a documentation book as a single `/booktree` page.
- Give a handbook or wiki-style book a persistent, linkable outline separate from core's book navigation block.
- Set a fixed "home" book as the site-wide default tree via the Root Node ID setting.
- Show a sub-tree of a large book by pointing `/booktree/{node}` at an interior chapter node.
- Display several independent book trees on one site by using distinct `/booktree/{node}/...` URLs.
- Cap how deep the rendered outline goes with the Deep Max setting (default 5) to keep large books readable.
- Override the depth per page, e.g. `/booktree/42/2` to show only two levels beneath node 42.
- Trim long page titles to a fixed length (default 35 chars, "..." appended) so the outline stays compact.
- Force a different trim length per request, e.g. `/booktree/42/5/80` for longer titles on one page.
- Embed the tree page in a menu so editors reach a book's outline in one click.
- Link a book's landing node to its own generated outline for a quick "in this book" index.
- Provide a printable, link-rich sitemap of curated Book content.
- Surface the root node's body text above its child outline (the page prints the start node body, then the tree).
- Style the output with the shipped `booktree.css` classes (`li.booktree`, `ul.booktree`).
- Build a lightweight documentation portal on top of core Book without installing a heavier navigation module.
- Reconfigure the default root/depth/trim centrally at `/admin/config/booktree` without touching code.
- Reuse the same book content in multiple outline views by varying only the URL arguments.
- Give content teams a stable URL to reference a book's structure in editorial docs.
- Present onboarding or policy books as a single expandable-looking outline page.
- Order children exactly as authored: the tree follows each book link's stored weight.
