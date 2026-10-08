Adds a Schema.org `ItemList` group to Metatag, outputting JSON-LD list/carousel structured data — designed to work with Views via Metatag Views.

---

A companion submodule of Schema.org Metatag. It provides a Metatag group `schema_item_list` with Tag plugins for ItemList properties, extending `SchemaNameBase`; list members are expressed as nested `itemListElement` entries. Because carousels are usually built from listings, it depends on `metatag_views` so you can attach the tags to a View's page/feed display. Enable it and configure the tags with tokens; on render, Schema.org Metatag emits the list in the page's `application/ld+json` script. Ideal for building Google carousels of recipes, articles, products or courses. Requires `schema_metatag` and `metatag_views`.

---

- Add `ItemList` JSON-LD to listing pages.
- Build a search carousel from a View.
- Populate `itemListElement` entries from Views rows.
- Reference each list item by URL.
- Order items via `ListItem` positions.
- Set the list `@type` (ItemList).
- Point `mainEntityOfPage` at the list page.
- Provide a stable `@id`.
- Create carousels of articles or blog posts.
- Create carousels of recipes.
- Create carousels of products or courses.
- Attach structured data to Views displays via metatag_views.
- Improve eligibility for host/summary carousels in search.
- Configure per View display with tokens.
- Combine with per-item schema types on the target pages.
- Validate output in Google's Rich Results Test.
