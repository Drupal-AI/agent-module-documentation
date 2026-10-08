<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Merges the Facets "missing" (no-value) facet item into an existing facet item so un-valued results share a real option instead of showing a separate "None" entry.

---

Facets Missing Merge is a small add-on for the Facets module that ships one build-stage facet processor, "Merge missing item" (`missing_item_merge`). Facets can add a "missing" item to a facet to gather all results that have no value for the faceted field (shown as something like "None"). This processor folds that missing item onto a target item you configure: the target's count grows by the missing count, the target's raw value is dropped from the missing filters, and the merged option is relabelled "Target (or None)". You pick the target with a single "Target item" textfield that is matched against each result's raw value or its display value (so you can enter a node ID/term ID or its title). Enable and configure it per facet in the Facets admin UI, and order it before the URL processor in the build phase because it rewrites the missing filter parameters. The module has no settings page, routes, permissions or services of its own — everything is configured on the individual facet.

---

- Fold a facet's "missing"/"None" item into a real facet option so users see one merged choice.
- Give un-valued content a sensible default home under an existing facet value rather than a bare "None".
- Merge the missing item onto a target chosen by its raw value (for example a node ID or term ID).
- Merge the missing item onto a target chosen by its display value/title (for example "Cat").
- Relabel the merged option automatically as "Target (or None)" without editing templates.
- Combine the missing item's result count into the target item's count in the facet list.
- Keep clicking the merged facet option to return both the target's results and the un-valued results.
- Tidy up an entity-reference facet where many items have no referenced value.
- Reduce visual clutter on a facet block by removing the standalone missing item.
- Present a "catch-all" facet value that also captures records missing that field.
- Apply the merge only when the facet's "missing" option is enabled (the processor no-ops otherwise).
- Configure the merge independently for each facet that needs it.
- Order the processor before the URL processor so facet links stay correct after the merge.
- Support faceted search UIs built on Search API and Facets on Drupal 9, 10, or 11.
- Avoid custom PHP or Twig by using a shipped, configurable processor.
- Handle facets where the "missing" label would otherwise confuse site visitors.
- Map "no value" results onto a meaningful default category label.
- Use raw-value matching to target items whose display label is not stable across languages.
- Keep a facet's option list shorter by one item after merging.
- Integrate cleanly with existing Facets processors by running at build stage (weight 5).
