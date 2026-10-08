<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Autocomplete Suggestions

Enriches entity-reference autocomplete suggestions with the entity type label and a Published/Unpublished status marker, and lets you limit how many results are returned.

- Overrides the core `system.entity_autocomplete` route controller.
- Adds configurable "show status" and "show entity type" flags.
- Adds a configurable results limit.
- Helps editors pick the right entity at a glance.

---

# Installing & configuring

- Enable the module (`drush en entity_autocomplete_suggestions`).
- Configure at `/admin/config/autocomplete-suggestion-configurations`.
- Toggle `allow_entity_type`, `show_status`, and `limit_results`.
- Settings live in `entity_autocomplete_suggestions.settings` config.
- The settings form requires `administer site configuration`.

---

# Usage & behaviour

- A route subscriber repoints `system.entity_autocomplete` to `EntityAutocompleteSuggestionsController::handleAutocomplete`.
- The controller extends core `EntityAutocompleteController` and uses a custom matcher.
- `EntityAutocompleteSuggestionsMatcher` extends core `EntityAutocompleteMatcher`.
- Matches are fetched via the field's selection handler `getReferenceableEntities()`.
- The selection handler enforces entity access, as in core.
- Each label is augmented with `(id)`, entity type, and status.
- Status (Published/Unpublished) is shown only when `show_status` is enabled.
- Entity type is shown only when `allow_entity_type` is enabled.
- `limit_results` (default 10) caps the suggestion count.
- Labels are sanitized via `strip_tags`/`Html::decodeEntities`/`Tags::encode`.
- The core selection-settings hash validation still guards the route.
- No new anonymous mutation routes are added.
- Works across node, taxonomy term, user and other entity references.
- Because it reuses the selection handler, unpublished nodes appear only to users the handler already permits.
- Uninstalling restores the default autocomplete controller.
- Only the config form is added as a custom route.
