Custom Entity Pager adds a Twig function that renders a lightweight previous/next pager between published nodes of a content type without using Views.

---

The module registers a single Twig function, `custom_entity_pager_insert()`, backed by the `custom_entity_pager.main_service` service. When called from a template rendered on a node canonical page, it runs one direct `SELECT` against `node_field_data` for all published nodes of the requested content type in the current language, sorts them (by a chosen field's `*_value` column, or by node id when no field is given), locates the current node in that ordered list, and returns render arrays for the previous and next neighbours. Two themeable templates ship: `paginate` (bare prev/next links) and `paginate_with_titles` (links labelled with node titles). There is no admin UI, no configuration, no block, and no CSS — the site's theme supplies markup styling. It is aimed at developers who want a fast pager and are willing to place the function call in a template themselves.

---

- Add a "previous / next article" pager to the bottom of an article node template.
- Let readers step sequentially through all published nodes of one content type.
- Build a pager without installing or configuring Views, for performance.
- Order the pager by a custom date field (e.g. `field_date`) instead of node id.
- Order the pager by any single-value node field's `*_value` column.
- Fall back to node-id ordering by omitting the field argument.
- Show plain "prev" / "next" links using the `paginate` template.
- Show links labelled with the neighbouring node titles using `paginate_with_titles`.
- Insert custom separator text between the previous and next links (4th argument).
- Toggle title display on or off per call via the boolean 3rd argument.
- Restrict a pager to a single content type by passing its machine name.
- Render different pagers for different content types on their respective templates.
- Keep unpublished nodes out of the pager sequence automatically.
- Keep the pager language-aware by only listing nodes in the current interface language.
- Provide next/prev navigation for a blog, news, portfolio, or recipe listing.
- Override `paginate.html.twig` / `paginate-with-titles.html.twig` in your theme to customise markup.
- Wrap the pager output in your own container and CSS classes in the template.
- Call the function only on node pages (it returns FALSE when there is no node in the route).
- Chain the pager onto an existing single-column content layout with minimal overhead.
- Replace a heavier Views-based pager (Entity Pager) with a query-only alternative.
- Use it as a developer-friendly alternative to block-based pagers like Flippy or Previous/Next API.
