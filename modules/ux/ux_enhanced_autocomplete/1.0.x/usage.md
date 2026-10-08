<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UX Enhanced Autocomplete replaces the core entity autocomplete matcher so node and taxonomy_term reference autocompletes show a richer two-line suggestion (title plus type, ID, date and author).
---
Core entity-reference autocomplete only shows an entity's label, which is ambiguous when many items share similar titles. This module decorates the core matcher by overriding the `entity.autocomplete_matcher` service with `UxEnhancedEntityAutocompleteMatcher`, which wraps the original matcher. For supported target types (`node`, `taxonomy_term`) and inputs meeting the configured minimum length, it asks the entity-reference **selection handler** for referenceable entities — so the same access filtering as core applies — then loads each returned entity to build a formatted, HTML-escaped two-line label. For any other entity type, or on any exception, it transparently falls back to the original matcher.

Everything is configurable at `/admin/config/user-interface/ux-enhanced-autocomplete` (permission: `administer site configuration`): maximum matches (`match_limit`), minimum search length (`min_length`), which info parts to show (type, ID, date, author), bold/color styling with an accent color, a separator, and title truncation length. Hooks are implemented via the modern `#[LegacyHook]` attribute delegating to the `UxEnhancedAutocompleteHooks` service (help text, page attachments for CSS, and per-widget third-party settings). Security posture is clean: the module adds no endpoints of its own — it reuses core's autocomplete route and the selection handler's `getReferenceableEntities()`, which enforces entity access; the subsequent `storage->load()` only loads IDs the access-checked handler already returned, and all output is passed through `Html::escape()`. It does not use `accessCheck(FALSE)` and makes no external calls.
---
- Show entity type/bundle alongside each autocomplete suggestion
- Show the entity ID to disambiguate similarly-titled items
- Show the creation date (nodes) or changed date (terms) in suggestions
- Show the author/owner name in suggestions
- Disambiguate nodes that share the same title during reference entry
- Configure the maximum number of autocomplete matches (`match_limit`)
- Set the minimum number of characters before autocomplete triggers (`min_length`)
- Toggle each info part (type, ID, date, author) on or off
- Bold individual info parts for emphasis
- Enable an accent color and pick the hex value for styled info parts
- Choose the separator string between info parts
- Truncate long titles to a configurable maximum length
- Apply the enhanced display to node reference autocomplete fields
- Apply the enhanced display to taxonomy_term reference autocomplete fields
- Fall back to the standard matcher for unsupported entity types automatically
- Adjust date formatting via the configured Drupal date format
- Restrict configuration to `administer site configuration` holders
- Speed up editorial entity selection by giving editors richer context inline
