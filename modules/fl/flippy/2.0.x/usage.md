Flippy adds a per-content-type Previous / Next (and optional First, Last, Random) pager to node pages, letting visitors flip through all published nodes of a given type in a chosen order.

---

Flippy is enabled per content type on the node-type edit form (a "Flippy settings" tab), where every option is stored as a per-type key inside the `flippy.settings` config object (e.g. `flippy_article`, `flippy_head_article`, `flippy_prev_label_article`, `flippy_custom_sorting_article`, `flippy_sort_article`, `flippy_order_article`). There is no central admin/configure page — it has no `configure` route. When enabled for a type, Flippy exposes a `flippy_pager` pseudo-field on that bundle's *Manage display*, so you can position the pager among the node's fields, and it also provides a "Flippy Block" plugin you can place in any region. The links are computed at view time by the `flippy.pager` service (`FlippyPager`), which runs entity queries against published nodes of the same type — by default ordered by creation date ascending, or by any base field / configured field with an ASC/DESC direction. Labels support tokens (with the Token module's browser offered when present), can be truncated with an ellipsis, and can optionally add semantic `rel="prev"`/`rel="next"` `<link>` tags to the document head. A `buildFlippyQuery` event (`FlippyEvent`) lets other modules alter the first/prev/next/last queries. Rendering goes through the themeable `flippy` template with per-bundle and per-node template suggestions, and optional keyboard/swipe navigation when the `hammerjs` module is installed.

---

- Add Previous / Next links to every Article so visitors can browse articles one by one.
- Let users flip through blog posts in reverse-chronological (newest-first) order.
- Show First and Last links so readers can jump to the newest or oldest node of a type.
- Add a "Random" link that sends the visitor to a random node of the same type.
- Loop the pager so "Next" on the last node wraps around to the first.
- Position the pager above or below the node body via *Manage display*.
- Place the Flippy pager anywhere on the page as a block ("Flippy Block").
- Use node tokens in the link labels, e.g. show the target node's title as the label.
- Truncate long token-based labels to a maximum length with a custom ellipsis.
- Add semantic `rel="prev"` / `rel="next"` `<link>` tags to the page head for SEO.
- Sort the pager by a custom date field instead of the post date.
- Sort the pager by a numeric or text field ascending or descending.
- Show "empty" labels (with no link) when there is no next/previous node.
- Give each content type its own independent pager sequence.
- Provide keyboard arrow-key and touch-swipe navigation via the `hammerjs` integration.
- Override the pager markup per content type with a `flippy--article.html.twig` template.
- Override the pager markup for a single node with `flippy--article--123.html.twig`.
- Build a "photo of the day" style walk-through of a media/gallery content type.
- Let editors page through a moderated content type while reviewing entries.
- Alter which node counts as next/previous from another module via the `buildFlippyQuery` event.
- Provide multilingual-aware navigation (queries are constrained to the current language).
- Call the `flippy.pager` service directly to build prev/next links in custom code.
- Offer a documentation/manual reading experience where chapters are nodes you flip through.
- Keep navigation scoped to one content type (Flippy never pages across all node types at once).
