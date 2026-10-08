<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Contextual Filter Default Entity Field Values adds a Views contextual-filter (argument) default plugin that supplies the argument from a field value on the "current" entity — the entity resolved from the page's route parameters.

---

The module ships a single `argument_default` Views plugin, `current_entity_field_value` (class `CurrentEntityFieldValue`), selectable under a contextual filter's *When the filter value is NOT available → Provide default value → Field value from Current Entity*. You choose a content entity type and one of its fields (as `field_name:property`); at runtime the plugin loads that entity from the current route (`current_route_match->getParameter(entity_type_id)`) and returns the chosen field property. It reads all deltas via `array_column()` and either concatenates them with a separator (`+` for OR, `,` for AND — matching Views' multi-value argument syntax) or returns a single delta. An "empty value" fallback is returned when the field exists but is empty, which pairs well with a Views exception value to skip the filter entirely. The plugin declares itself cacheable per `url` with a permanent max-age and merges the source entity's cache tags into the view so the result invalidates correctly. It provides a config schema for the six stored options and one `hook_update_N` (8201) that migrates the legacy string `single_value_delta` to an integer. No settings page, no permissions, no services, no Drush.

---

- Filter a view by a field value taken from the node currently being viewed.
- Show related content that shares a taxonomy term with the current node.
- Build a "more like this" block driven by a reference field on the current entity.
- Use a field on the current user, term, media, or any content entity as a contextual filter.
- Pull a specific property of a field (e.g. `field_link:uri`, `field_ref:target_id`).
- Feed a multi-value field into an OR contextual filter using the `+` separator.
- Feed a multi-value field into an AND contextual filter using the `,` separator.
- Take only the first (or Nth) value of a multi-value field via the single-value delta.
- Provide a fallback value when the current entity's field is empty.
- Combine the empty-value fallback with a Views exception to skip filtering when empty.
- Drive a view placed as a block on entity pages off that entity's own fields.
- Reference the current entity's author, category, or region field in an embedded view.
- Contextualize a listing without hard-coding IDs in the view path.
- Filter media library or media views by a field on the host entity.
- Build cross-entity relationships (e.g. current term's parent reference) into a view.
- Populate a summary/argument from an integer or numeric field on the current entity.
- Use a link field's value from the current entity as a Views argument.
- Keep the view cache correct by inheriting the source entity's cache tags automatically.
- Avoid custom argument-default PHP by configuring the field mapping in the UI.
- Migrate an older configuration where `single_value_delta` was stored as a string (update 8201).
