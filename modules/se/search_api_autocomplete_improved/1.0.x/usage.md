<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Autocomplete Improved refines Solr-backed autocomplete for Search API by adding smarter caching, suggestion validation and per-suggestion result counts.

---

The module hooks into `hook_search_api_autocomplete_suggestions_alter()` (via a `#[LegacyHook]` shim delegating to an OO hook class) to post-process suggestions: an `AutocompleteSuggestionProcessor` validates suggestions (`SuggestionValidator`) and computes accurate result counts (`ResultCountCalculator`) using cached discovery and cache-tag invalidation. A dedicated cache bin (`cache.search_api_autocomplete_improved`) and a Search API cache-invalidator event subscriber keep counts fresh when the index changes. A settings form lives at `/admin/config/search/search-api/search_api_autocomplete_improved` under the `administer search_api_autocomplete` permission. It depends on `search_api_solr`'s autocomplete submodule and targets Drupal 10.2+/11. There is no public write endpoint; it operates within the existing autocomplete query flow.

---

- Show accurate result counts next to autocomplete suggestions.
- Cache Solr autocomplete results to cut query load.
- Validate/clean suggestions before they reach the user.
- Invalidate cached counts when the search index updates.
- Improve typeahead performance on large Solr indexes.
- Reuse the existing Search API autocomplete permission for config.
- Post-process suggestions via the alter hook without a fork.
- Provide a dedicated cache bin for autocomplete data.
- Target Drupal 10.2+/11 with modern OO hook classes.
- Reduce duplicate/irrelevant autocomplete entries.
- Keep suggestion counts consistent after content changes.
- Tune autocomplete behavior from an admin settings form.
- Layer on top of search_api_solr_autocomplete.
- Speed up search UX for editorial and site visitors.
- Avoid recomputing counts on every keystroke via caching.
