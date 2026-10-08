<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Suggestion builds its own n-gram index from published site content (plus admin-defined priority terms and terms visitors actually search for) and serves type-ahead completions from that index over a JSON endpoint, so a search box can offer suggestions drawn from what the site really contains — no Search API, Solr, or external service required.

---

A search box with no completions makes visitors guess a site's vocabulary, and the guesses are usually wrong — someone types "car park" where the content says "parking". Suggestion closes that gap by maintaining its own suggestion index and serving it as the user types. Indexing tokenizes text (lowercase, strip non-alphabetic characters, drop words shorter than the configured minimum, remove stopwords), then slices the remaining words into overlapping n-grams of `atoms_min`..`atoms_max` words in both forward and reversed order, and stores each n-gram in a dedicated `{suggestion}` table with a `density` score used for ranking. Three sources feed the index: titles of the content types you select (rebuilt on cron and via a batch "Index Suggestions" form, and kept live by node insert/update/delete hooks), "priority" phrases an administrator types into the settings form (scored highest), and "surfer" searches — terms visitors submit through a search box that the module has attached autocomplete to, admitted to the index only when their words already appear in your published content. At request time the controller at `/suggestion/autocomplete?q=…` lowercases and trims the query, LIKE-matches it against the index (prefix first, then substring to fill the limit), and returns a JSON array of `{value,label}` objects that Drupal's core autocomplete widget renders. You wire it up by dropping the module's "Suggestion Search" block in place of the core search block, or by naming a `form_id:field_name` pair in the settings so the module attaches `#autocomplete_route_name` to that field, or by adding that route to any field yourself in `hook_form_FORM_ID_alter()`. Administration lives at `/admin/config/suggestion` behind the `administer suggestion` permission, with sub-pages for indexing, searching the index, and editing or removing individual n-grams. The autocomplete route is intentionally open (`_access: 'TRUE'`) so anonymous visitors get completions, and the index is limited to published nodes of the selected content types; queries shorter than the configured minimum length return an empty array.

---

- Offer search completions as visitors type, sourced from real content.
- Replace the core search block with an autocompleting "Suggestion Search" block.
- Add autocomplete to an existing search field by naming its `form_id:field_name` pair in settings.
- Attach the `suggestion.autocomplete` route to any text/search field in `hook_form_FORM_ID_alter()`.
- Provide typeahead without installing Search API, Solr, or a SaaS search backend.
- Reduce zero-result searches by surfacing the vocabulary the site actually uses.
- Seed the index by batch-indexing titles of chosen content types.
- Keep the index current automatically as nodes are created, edited, unpublished, or deleted via cron sync.
- Curate high-value completions by entering "priority" phrases that always rank first.
- Let real visitor searches ("surfer" terms) organically strengthen popular completions.
- Suppress unwanted terms with a configurable stopword list.
- Remove or re-weight an individual completion from the per-n-gram edit page.
- Tune suggestion volume and latency via min/max characters, min/max words, and result-limit settings.
- Limit suggestions to specific content types.
- Rank completions by a computed density score so popular/priority phrases appear first.
- Serve cacheable autocomplete responses (1-hour max-age, varied by the `q` query argument).
- Support a large content archive where a hand-maintained suggestion list is impractical.
- Improve mobile and small-keyboard search entry by cutting typing.
- Point the search block's form action at `/search/node`, a Views search page, or any search path.
- Run entirely inside Drupal with no third-party dependency.
