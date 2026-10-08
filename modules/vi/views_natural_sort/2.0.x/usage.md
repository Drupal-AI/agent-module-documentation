<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Natural Sort adds a "natural" Views sort that orders string properties (like a node title) the way a human would — ignoring leading articles ("The", "A"), stripping filler words/symbols, and sorting embedded numbers numerically (so "Item 2" precedes "Item 10").

---

The module maintains a dedicated index table (`views_natural_sort`) of pre-transformed, sortable strings. When an entity is saved (`hook_entity_insert`/`update`/`delete`), it stores a transformed copy of each supported string property; the transformation runs a configurable pipeline of plugins (remove beginning words, remove words, remove symbols, natural-number encoding, days-of-the-week). Via `hook_views_data_alter()` it upgrades every eligible string property's Views sort handler id from `standard` to `natural`, which adds "Sort ascending/descending naturally" (`NASC`/`NDESC`) options to that sort in the Views UI; choosing one joins the `views_natural_sort` table and orders by the transformed `content` column. A settings form at `/admin/structure/views/settings/views_natural_sort` (permission `administer views`) configures which words/symbols are stripped, whether day-of-week sorting is on, and the reindex batch size, and offers a "Rebuild Index" button. The set of sortable properties can be extended in code via `hook_views_natural_sort_supported_properties_alter()`, and the transformation pipeline via a `IndexRecordContentTransformation` plugin or `hook_views_natural_sort_transformations_alter()`. Out of the box it primarily targets node titles but works for any integer-id entity's `string` base properties that Views exposes as a `standard` sort.

---

- Sort a list of book titles alphabetically while ignoring a leading "The" or "A".
- Order a glossary/index view so "The Hobbit" files under H-ish position (after articles are stripped), not T.
- Sort product names with embedded numbers so "Model 2" comes before "Model 10" (natural number order).
- Alphabetize movie titles ignoring leading articles across English and a few other languages (La, Le, Il).
- Provide a human-friendly A–Z listing of nodes by title in a view.
- Sort user names or file names naturally (any integer-id entity string property Views exposes).
- Strip filler words like "and", "or", "of" so titles sort on their meaningful words.
- Ignore punctuation/symbols ("#", quotes, brackets) when ordering titles.
- Build an author bibliography sorted by work title without the article-word noise.
- Sort version-like strings or catalogue codes containing numbers in true numeric order.
- Offer editors a "sort naturally" option on the title sort in any view (NASC / NDESC).
- Keep a directory of organizations ordered ignoring leading "The".
- Configure a custom list of beginning words to strip for a specific site vocabulary.
- Add site-specific filler words or symbols to ignore during sorting.
- Enable day-of-the-week ordering so "Monday…Sunday" sort in week order rather than alphabetically.
- Rebuild the natural-sort index after a bulk import so all existing content sorts correctly.
- Tune reindex batch size to avoid timeouts on very large content sets.
- Extend natural sorting to a custom string field via hook_views_natural_sort_supported_properties_alter().
- Add a custom transformation plugin (e.g. for names or abbreviations) to change how strings are normalized.
- Present search/browse result lists in intuitive natural order instead of raw ASCII order.
- Sort taxonomy term names naturally in a term listing view.
- Ensure negative and decimal numbers embedded in titles sort correctly (the numbers transformation handles them).
