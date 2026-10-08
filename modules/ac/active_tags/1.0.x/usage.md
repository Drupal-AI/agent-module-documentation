<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Active Tags replaces Drupal's comma-separated entity-reference autocomplete with a chip/pill widget: each referenced entity is a removable token, suggestions come from a dedicated autocomplete endpoint with highlighted matches, and tags can be drag-reordered.

---

Active Tags is a client-side upgrade to entity-reference input, not a taxonomy-only tool despite the `field` + `taxonomy` module dependencies. It provides two field widgets you assign under **Manage form display** — **Autocomplete (Active Tags)** (`entity_reference_autocomplete_active_tags`, extending core's `EntityReferenceAutocompleteWidget`) and **Select (Active Tags)** (`select_active_tags`) — plus two matching Form-API render elements (`entity_autocomplete_active_tags`, `select_active_tags`) for custom forms. The autocomplete widget wires each field to its own controller route `active_tags.entity_autocomplete` (`/active_tags/{target_type}/{selection_handler}/{selection_settings_key}`), a subclass of core's `EntityAutocompleteController`. Its matcher returns a richer JSON payload than core — `entity_id`, `label`, an optional token-driven `info_label`, and a user `avatar` — which the bundled JS renders as tags. The client is a **Tagify-derived library** exposed as `Drupal.ActiveTags` (`assets/js/active-tags.js`) driven by `active-tags.init.js`; everything is served **locally** (no CDN), with theme CSS variants for Claro, Gin and Seven. Widget settings (config schema `field.widget.settings.entity_reference_autocomplete_active_tags` / `.select_active_tags`) cover match operator (starts-with / contains), result limit, minimum length, delimiter, tag style (rectangle / bubble), placeholder, show-entity-id, show-avatar, uppercase-first-letter, and the info-label token string plus not-found / not-exist / tag-limit messages. Beyond field widgets it ships integration plugins: a **Webform** element (`webform_entity_reference_active_tags` via `EntityAutocompleteActiveTags`), a **Facets** widget (`ActiveTagsWidget`), and a **Better Exposed Filters** filter (`bef_active_tags`). Developers can adjust suggestion labels through `hook_active_tags_autocomplete_match_alter($label, $info_label, $context)`. Free tagging remains a governance decision: any widget that lets editors create terms grows a vocabulary without curation, so a review process or a restricted target-bundle set matters more than the widget for keeping a vocabulary tidy.

---

- Show entity-reference values as removable chips instead of a comma-separated string.
- Replace core's free-tagging taxonomy widget with a chip interface.
- Tag a node with existing terms and create new ones inline (autocreate).
- Remove a tag without hand-editing a delimited text field.
- Drag-reorder the tags on a multi-value reference field.
- Highlight the typed letters inside each autocomplete suggestion.
- Prevent duplicate tags from being added to a field.
- Reference users on a field and show each user's avatar in the tag.
- Show the entity ID next to each tag for disambiguation.
- Add a token-driven info label (e.g. content type) beside each suggestion.
- Offer a select-style Active Tags widget for a fixed options list.
- Add an `entity_autocomplete_active_tags` element to a custom Form-API form.
- Provide an Active Tags autocomplete element inside a Webform.
- Render a Facets filter as an interactive tag widget.
- Render a Views exposed filter as Active Tags via Better Exposed Filters.
- Limit suggestions with a match operator (starts-with vs contains) and a result cap.
- Require a minimum number of typed characters before suggesting.
- Choose rectangle or bubble tag styling per field.
- Customize the "no match" / "create new" / "limit reached" messages.
- Alter suggestion labels programmatically with `hook_active_tags_autocomplete_match_alter()`.
- Improve mobile and keyboard tag entry over the core text field.
- Style the widget consistently across Claro, Gin and Seven admin themes.
- Cap the number of tags to the field's cardinality.
- Reduce accidental duplicate taxonomy terms during editorial tagging.
