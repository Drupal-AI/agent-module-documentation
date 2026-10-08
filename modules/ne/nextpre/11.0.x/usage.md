Next And Previous Link provides a configurable block that shows "next" and "previous" links on a node's detail page, letting visitors move between nodes of a chosen content type without returning to a listing.

---

The module ships one block plugin, `next_previous_block` ("Next Previous link", category *Blocks*), that you place through *Structure → Block layout*. Its configuration form lets you pick a single node **content type** (required) and set the button **labels** ("previous text", "next text", both required) plus optional CSS **classes** for each link ("previouslink_class", "nextlink_class", default `btn`). When rendered on a node canonical page whose type matches the configured bundle, the block runs two entity queries: the "previous" link finds the highest `nid` **less than** the current node's id, and the "next" link finds the lowest `nid` **greater than** it — both filtered to the same content type, `status = 1` (published), and the current node's `langcode`, ordered by `nid` and limited to one result, with `accessCheck(TRUE)`. Each result becomes a themed link (`Link::fromTextAndUrl` to the node's internal path) carrying classes `nextpre__btn` plus your custom class. Ordering is strictly by node id (creation order), not by a date field or menu weight. The block declares a `route` cache context and merges `node:*` cache tags so it invalidates as content changes. There is no global settings page and no permissions — all configuration lives on the block instance, so you can place several instances with different content types or labels in different regions.

---

- Add Previous/Next navigation buttons to blog post detail pages.
- Let readers page through articles sequentially without going back to the listing.
- Provide next/previous links scoped to a single content type (e.g. only "News").
- Place separate next/previous blocks for different bundles in different regions.
- Customize the button text (e.g. "← Older", "Newer →") per block instance.
- Add Bootstrap or custom CSS classes to the prev/next links for styling.
- Show navigation only on published nodes of the selected type.
- Keep navigation within the visitor's current language (langcode-filtered).
- Navigate a portfolio or case-study section item by item.
- Add sequential navigation to a documentation or knowledge-base content type.
- Give an events or press-release type simple prev/next browsing.
- Build a "read next" style flow between tutorial nodes.
- Restrict the navigation to the node canonical page only (it renders nowhere else).
- Use the default `btn` class for instant themed buttons if no class is provided.
- Place the block in a sidebar, footer, or content region via Block layout.
- Provide chronological (by node id) browsing through a large set of posts.
- Offer multiple language-aware navigation blocks on a multilingual site.
- Style prev and next links independently with different classes.
- Add lightweight post-to-post navigation without a custom View or template.
- Ensure the navigation cache-invalidates when nodes are added or changed (node:* cache tags).
