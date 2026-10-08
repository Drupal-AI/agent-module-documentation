<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Boolean Field Boost lets you promote items in search results based on a boolean flag — for example pushing 'featured' or 'promoted' content higher up the ranking.

---

It provides a single Search API processor plugin (`boolean_field_boost`) that runs at the `preprocess_index` stage. In its configuration form you pick any boolean field on the index and assign a boost factor; when an item's chosen boolean is TRUE, the configured multiplier is applied to that item's boost during indexing. The plugin uses core Search API boost-factor utilities and supports an 'Ignore' option to disable a field. It has no routes, permissions or services of its own — configuration lives in the Search API index/processor settings, so it is governed by Search API's own admin permissions. Because boosting happens at index time, re-indexing is needed for changes to take effect.

---

- Boost 'featured' content to the top of search results.
- Promote in-stock or available products via a boolean flag.
- Rank 'editor's pick' items above ordinary content.
- Assign a custom boost multiplier per boolean field.
- Apply boosts at index time via a Search API processor.
- Ignore selected boolean fields with an explicit option.
- Combine with other Search API processors for tuned relevance.
- Elevate sticky or highlighted nodes in results.
- Down-rank by leaving the boolean false (no boost).
- Configure entirely within the Search API index UI.
- Support any backend that honors Search API boosts.
- Improve findability of priority content.
- Use standard boost-factor values from Search API utilities.
- Re-index to apply updated boost settings.
- Keep ranking logic declarative rather than in custom code.
