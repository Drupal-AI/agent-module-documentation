<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UX Enhanced Autocomplete (ux_enhanced_autocomplete) — agent index

**Decorates the core entity autocomplete matcher to render two-line suggestions (title + type/ID/date/author) for node and taxonomy_term reference fields.**

- **Version:** 1.0.x (installed 1.0.1)
- **Core:** ^10.1 || ^11 || ^12
- **Configure route:** `ux_enhanced_autocomplete.settings` → `/admin/config/user-interface/ux-enhanced-autocomplete` (permission: `administer site configuration`)
- **Service override:** `entity.autocomplete_matcher` → `UxEnhancedEntityAutocompleteMatcher` (wraps the original, injected as `ux_enhanced_autocomplete.original_autocomplete_matcher`)
- **Supported types:** `node`, `taxonomy_term` (others fall back to core matcher)
- **Settings keys:** `match_limit`, `min_length`, `show_entity_type`/`show_entity_id`/`show_date`/`show_author`, `bold_*`, `enable_color`, `accent_color`, `separator`, `truncate_title`, `title_max_length`, `date_format`
- **Hooks:** `#[LegacyHook]` → `UxEnhancedAutocompleteHooks` (help, page_attachments CSS library, field-widget third-party settings)

**Security:** Adds no routes of its own beyond the admin settings form (permission-gated). Reuses core's autocomplete route and the entity-reference selection handler's `getReferenceableEntities()`, which enforces entity access; entity loads only cover IDs the access-checked handler already returned. No `accessCheck(FALSE)`, all labels `Html::escape()`d, no external calls.

See [configure/settings.md](configure/settings.md)
