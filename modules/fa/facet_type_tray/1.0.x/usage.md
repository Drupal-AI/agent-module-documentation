<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exposes Type Tray content-type category groupings as a hierarchical Search API facet.

---

Facet Type Tray is a bridge module between Type Tray (which groups content types into named categories on the "Add content" screen), Search API and Facets. It lets a search or listing page offer a facet that filters by the Type Tray category a content type belongs to, instead of only by each raw content-type machine name. It ships four cooperating plugins: a Search API processor (`type_tray`) that indexes each node's category as a string field — storing both the parent category key (e.g. `resources`) and a compound `category.bundle` value (e.g. `resources.page`); a Facets build processor (`type_tray`, "Type Tray: Merge node types") that turns those indexed raw values back into readable labels; a Facets sort processor (`type_tray_category`, "Sort by Type Tray categories") that orders facet results to match the category order in `type_tray.settings`; and a Facets hierarchy plugin (`type_tray`, "Type Tray hierarchy") that makes categories the parent level and content types the child level for a two-level widget. Content types with no Type Tray category are indexed under their own machine name. The module has no settings form, routes, permissions, entities or config of its own — everything is configured on the Search API index and on the facet.

---

- Offer a search facet that filters by Type Tray content-type category rather than by raw content-type machine name.
- Group several content types under one facet entry using their shared Type Tray category.
- Build a two-level (category then content type) hierarchical facet on a Search API view.
- Index each node's Type Tray category into a Search API string field for faceting.
- Store both the parent category key and a compound `category.bundle` value for each node.
- Display human-readable labels (node-type labels and Type Tray category names) in the facet widget instead of raw indexed values.
- Order facet items to follow the category order defined in Type Tray configuration.
- Let visitors drill down from a category to the individual content types within it.
- Reuse an existing Type Tray taxonomy of content-type categories for site search.
- Show content types that have no Type Tray category under their own machine name.
- Add a Search API processor named "Type Tray" to an index to expose the category field.
- Enable the "Type Tray: Merge node types" build processor on a facet for readable labels.
- Enable the "Sort by Type Tray categories" sort processor to align facet order with Type Tray.
- Enable the "Type Tray hierarchy" plugin with a hierarchy-capable widget (e.g. core checkbox with hierarchy).
- Present grouped content types in a faceted search results page.
- Keep the facet display order consistent with the "Add content" screen's Type Tray order.
- Filter Search API results down to a single Type Tray category and then a single bundle.
- Provide category-based navigation over indexed nodes without a custom taxonomy vocabulary.
- Support both Drupal 10 and Drupal 11 sites already running Search API, Facets and Type Tray.
- Re-index content after enabling the processor so category values become available for faceting.
