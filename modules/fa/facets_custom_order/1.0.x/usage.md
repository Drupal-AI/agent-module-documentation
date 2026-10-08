<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Custom Order adds a Facets sort processor ("Sort by custom order") that arranges a facet's values into a sequence you type line-by-line, instead of alphabetically or by result count.

---

Facets sorts by count or by label, and both are wrong for values that have an inherent order. A price band should read low to high, not "£0–50, £100–200, £50–100". A size facet should be S, M, L, XL rather than alphabetical, which puts L first. A rating should descend; a date range should run chronologically; a status should follow the workflow. Sorting by count is worse, because the order changes as content changes, so a visitor who filters and returns finds the options rearranged — disorienting in a way a fixed wrong order is not. This module fixes both with a `sort`-stage processor you enable on a facet: a textarea takes the order (**one value per line**), and a "Use display values" checkbox decides whether each line is matched against the result's rendered **display value** or its **raw value** (a term ID or aggregated index string) — for taxonomy/reference facets you almost always want display values on. Internally each line's position becomes its rank (`array_flip` of the trimmed lines) and results are compared by rank, so the mechanism is a stable manual sort, not weights or drag-and-drop. Two things worth attaching. **The order is configuration and the values are content**: any value you do not list ties at the end, so a vocabulary term added after the order was written silently drops to the tail — where a new size can disappear from view — which is the failure this kind of module most often produces, so revisit the list when the vocabulary grows. And there is **no ASC/DESC control** (the schema hints at one but the plugin ignores it): author the lines in the exact final order, because you cannot reverse them from the processor. Version **1.0.0**, requires `facets`, core `^8`–`^11`, admin-gated by Facets' own `administer facets` permission.

---

- Order a price-band facet low to high.
- Sort a size facet S, M, L, XL instead of alphabetically.
- Order a rating facet descending (5 stars first).
- Sort date-range facet values chronologically.
- Order a status facet to follow the editorial workflow.
- Fix an alphabetical size ordering that puts L before M.
- Stop a facet's order changing every time content is added.
- Order a difficulty facet Beginner, Intermediate, Advanced.
- Order a taxonomy facet by label using "Use display values".
- Sort a facet whose raw values are term IDs into a chosen sequence.
- Order age ranges (0–5, 6–12, 13–18) correctly.
- Fix a confusing facet order on an aggregated index field with no weight.
- Order a priority facet High, Medium, Low.
- Order distance bands (< 5km, 5–10km, 10+km) sensibly.
- Order a course-level facet Foundation → Expert.
- Sort a bedroom-count facet 1, 2, 3, 4+.
- Improve scanning of a long facet by grouping related values together.
- Order a severity facet Critical → Info.
- Pin the most-used filter values to the top of a facet.
- Give an aggregated multi-source facet a single deterministic order.
