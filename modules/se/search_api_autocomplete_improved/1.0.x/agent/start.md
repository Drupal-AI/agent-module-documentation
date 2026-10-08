<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Autocomplete Improved (search_api_autocomplete_improved) — agent index

**Optimised caching, validation and result counts for Search API Solr autocomplete.**

- **Version:** 1.0.x
- **Core:** ^10.2 || ^11
- **Depends:** search_api_solr:search_api_solr_autocomplete
- **Configure:** `/admin/config/search/search-api/search_api_autocomplete_improved` (perm `administer search_api_autocomplete`)

**Surface:** `hook_search_api_autocomplete_suggestions_alter()` shim → `SearchApiAutocompleteImprovedHooks`; services `AutocompleteSuggestionProcessor`, `SuggestionValidator`, `ResultCountCalculator`; dedicated cache bin + cache-invalidator event subscriber; `SettingsForm`.

**Security:** operates inside the existing autocomplete flow; config gated by `administer search_api_autocomplete`. No public write/mutation route. Low risk.
