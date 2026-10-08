Configurable Views Filter Block adds a "Views Exposed Filter Block (configurable form)" block that behaves like core's exposed-filter block but lets you choose, per block instance, exactly which exposed filters (and the reset button, sort, pager and fieldset groups) are shown — so you can split one view's exposed form across several regions.

---

The module provides a single Block plugin `configurable_views_filter_block_block` that extends core's `ViewsExposedFilterBlock` and reuses the same `ViewsExposedFilterBlock` deriver, so a derivative exists for every view display that has "Exposed form in block" enabled (plugin id `configurable_views_filter_block_block:<view_id>-<display_id>`). Each placed block gets extra settings on its block-configuration form: a **Visible filters** checkbox set (`visible_filters`, listing the display's exposed filters by identifier), plus "Other visibility options" that map to booleans `no_groups` (flatten collapsible `details` fieldsets into plain containers), `no_reset` (hide the reset button), `no_sort` (hide exposed sort criteria), and `no_pager` (hide exposed pager `items_per_page`/`offset` fields). The reset/sort/pager options only appear when the underlying view actually exposes those. At render time `build()` calls the parent then recursively walks the exposed-form render array, visually hiding (wrapping in `<div class="hidden-exposed-filter">`, not `#access`-removing, so values are preserved) any filter not in `visible_filters`, the reset/sort/pager elements per the booleans, and converting `details` groups to containers when `no_groups` is set; it also assigns a fresh unique form `#id` so multiple instances of the same view's exposed form can coexist on one page. Settings are stored in the block config entity under `settings` (schema `configurable_views_filter_block`) and it attaches a small CSS library. The module has no settings route, permissions, services, or Drush commands of its own.

---

- Show only a subset of a view's exposed filters in one region and the rest in another.
- Place the same view's exposed form twice on a page, each showing different filters.
- Move a view's exposed **sort** options out of the main filter block into their own block.
- Hide the reset button on a particular exposed-filter block instance.
- Hide the exposed pager (items-per-page / offset) controls on one instance.
- Flatten collapsible filter fieldsets (details) into a plain inline form on a given block.
- Combine a view's exposed filters with Facets in the same region by trimming the block.
- Build a compact "search box only" block from a view that also exposes many other filters.
- Expose just a category filter in a sidebar while keeping the keyword filter in the header.
- Keep filter values intact when hiding fields (fields are visually hidden, not removed).
- Render multiple instances of one view's exposed form without duplicate-form-id conflicts.
- Give editors a curated filter UI per landing page using the same underlying view.
- Show only the most-used exposed filters to reduce clutter on mobile layouts.
- Split a complex faceted search form into logical grouped blocks.
- Hide sort criteria on a block where a fixed sort order is desired.
- Present a single exposed filter as a standalone quick-filter widget.
- Reuse a report view's exposed filters selectively across several dashboard pages.
- Pair with Better Exposed Filters to restyle the trimmed exposed form (suggested dependency).
- Configure everything through the normal Block layout UI — no code required.
- Deploy per-instance filter configuration as block config entities across environments.
- Avoid cloning a view just to present a different exposed-filter subset in another place.
