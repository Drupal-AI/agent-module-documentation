<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Taxonomy Multilevel adds two Facets build processors — **Term Depth** and **Term Dependent** — that make a hierarchical taxonomy behave sensibly as a facet, showing only the level a visitor has reached rather than every term at once.

---

A deep vocabulary makes a poor flat facet: a "Category" facet with four levels and hundreds of terms produces a list where the useful distinctions are invisible. Facets can render hierarchy, but deciding *which* terms to offer at a given moment is the harder half, and that is what these processors do. **Term Depth** (plugin `term_depth`, build stage 40) filters the facet to the terms at one chosen depth of one vocabulary, so a facet can show only top-level categories. **Term Dependent** (plugin `term_dependent`, build stage 41) filters a facet to the children of whatever term is currently selected in another "dependee" facet — the drill-down behaviour visitors expect from a catalogue. Both are ordinary `@FacetsProcessor` build plugins in `src/Plugin/facets/processor/`, enabled per facet from the Facets UI, and they only trim the facet's already-computed result array — they do not alter the search index or the facet's source, so enabling and disabling them is free and reversible. Term Dependent reads the dependee facet's Term Depth settings, so the two are designed to work together. Composer accepts Facets `^2.0 || ^3.0` (both current majors) with core `^9 || ^10 || ^11`.

---

- Show only top-level categories until one is chosen.
- Drill down through a multi-level taxonomy.
- Make one facet's terms depend on another facet's active selection.
- Reduce a facet from hundreds of terms to a handful.
- Build a catalogue-style category browser.
- Limit a facet to a specific hierarchy depth.
- Show subcategories only after a category is selected.
- Keep a facet block short on a search page.
- Improve faceted navigation for a deep vocabulary.
- Support a product taxonomy with several levels.
- Chain a region facet into a city facet.
- Reduce visitor confusion on a large facet.
- Configure drill-down without writing custom code.
- Improve mobile usability of a search page.
- Work with either Facets 2.x or 3.x.
- Combine with an autocomplete facet widget for the still-long facets.
- Model a subject hierarchy in a library catalogue.
- Prevent irrelevant deep terms from appearing in a facet.
- Present a first-level facet plus a dependent second-level facet on the same page.
