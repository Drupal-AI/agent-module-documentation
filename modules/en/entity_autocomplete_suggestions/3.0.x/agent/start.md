<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Autocomplete Suggestions — agent orientation

Alters entity autocomplete labels to show type + published status and cap result count.

- Version 3.0.x, core ^9||^10.
- `EntityAutocompleteSuggestionsRouteSubscriber` repoints `system.entity_autocomplete` to `EntityAutocompleteSuggestionsController` (extends core controller).
- Matcher `EntityAutocompleteSuggestionsMatcher extends EntityAutocompleteMatcher`; results via `$handler->getReferenceableEntities()` → selection handler enforces access.
- Status disclosure is gated by admin config `show_status`; only entities the selection handler returns are shown. No confirmed access bypass.
- Config: `/admin/config/autocomplete-suggestion-configurations` (`administer site configuration`).
