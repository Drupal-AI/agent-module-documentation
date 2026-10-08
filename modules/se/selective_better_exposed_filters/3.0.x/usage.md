Adds a "Show only used items" option to Better Exposed Filters so an exposed Views filter lists only the reference/taxonomy values that actually appear in the current result set, instead of every possible option.

---

Better Exposed Filters (BEF) renders Views exposed filters as select lists, checkboxes, radios, or links, but by default those widgets show *all* configured options — including terms or referenced entities that match no content. This module overrides BEF's `default`, `bef_links`, and `bef` (radio/checkbox) filter widgets so each gains extra checkboxes in the Views UI: **Show only used items**, **Filter items based on the already-filtered result set**, **Hide filter if no options**, and **Show option items count**. When enabled, it re-runs the view's query in the background to determine which option values are present, then prunes the exposed element's `#options` accordingly (optionally appending a per-option result count, or hiding the filter entirely when nothing is left). It works with core field-based reference filters — taxonomy term (`TaxonomyIndexTid`), entity reference, bundle, list/options fields, VERF, and Search API options — but intentionally not with the "Has taxonomy term" depth filter. There is no configuration page and no permissions; everything is set per filter inside the view's exposed-form settings. It is a lightweight alternative to Views Selective Filters, integrated directly into BEF.

---

- Show only taxonomy terms that are actually used by the listed content.
- Hide empty entity-reference options from an exposed select filter.
- Turn a long category dropdown into just the categories in use.
- Build faceted-style browsing without the Facets module.
- Cascade filters so one exposed filter narrows the options of another.
- Show, next to each option, how many results it will return.
- Automatically hide an exposed filter when it would have no usable options.
- Prune options in a BEF "Links" widget to only relevant links.
- Prune options in a BEF checkboxes/radios widget.
- Keep product-attribute filters (color, size) limited to available values.
- Limit a bundle filter to bundles present in the result set.
- Limit a list/options field filter to values that appear.
- Restrict Search API options filters to indexed, in-result values.
- Reflect other applied exposed filters when computing available options.
- Avoid showing "dead" filter choices that always return zero results.
- Improve UX of large vocabularies by trimming the exposed list.
- Support hierarchical taxonomy by including parent terms of used terms.
- Shrink a multi-select's size to fit the reduced option count.
- Provide selective filtering on a view embedded as a block with arguments.
- Replace the heavier Views Selective Filters module with a BEF-native option.
- Localize option pruning per translation on multilingual sites.
- Offer editors a cleaner exposed filter form on content listings.
- Reduce confusion on catalog/archive pages by hiding unusable filters.
- Set the behavior entirely from the Views UI, no code required.
