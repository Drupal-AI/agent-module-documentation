<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Active Tags — field widgets

Two field widgets, assigned per field under **Structure → (entity type) → Manage form display**.

## `entity_reference_autocomplete_active_tags` — "Autocomplete (Active Tags)"

- Class: `Drupal\active_tags\Plugin\Field\FieldWidget\EntityReferenceAutocompleteActiveTagsWidget`, extends core `EntityReferenceAutocompleteWidget`, `multiple_values = TRUE`, for `entity_reference` fields.
- Renders the field with the `entity_autocomplete_active_tags` form element and attaches the `active_tags/assets` library plus the theme variant (`assets.claro` / `assets.gin` / `assets.seven`).
- On the client (`active-tags.init.js` → `initAutocomplete`) each field becomes a `Drupal.activeTags(input, …)` instance. Typing fires a debounced `fetch()` to the field's `data-autocomplete-url`, i.e. the route `active_tags.entity_autocomplete` at `/active_tags/{target_type}/{selection_handler}/{selection_settings_key}?q=…&selected=…`.
- Server side, `ActiveTagsEntityAutocompleteController::handleAutocomplete()` looks the `selection_settings_key` up in the `entity_autocomplete` key/value store and, **when `q` is non-empty**, verifies it against an HMAC of the serialized settings + target type + handler (same scheme as core). `ActiveTagsEntityAutocompleteMatcher::getMatches()` then runs the selection handler's `getReferenceableEntities()` and returns one JSON object per match: `entity_id`, `value` (`"Label (id)"`, tag-encoded), `label` (`Html::decodeEntities()` of the entity label), `info_label` (token-replaced), and — for `user` targets — `avatar`.

### Settings (config schema `field.widget.settings.entity_reference_autocomplete_active_tags`)

- `match_operator` — STARTS_WITH / CONTAINS.
- `match_limit` — max suggestions (`0` = unlimited).
- `min_length` — minimum characters before suggesting.
- `delimiter` — extra separator char besides Enter.
- `style` — `rectangle` or `bubble`.
- `size`, `placeholder`.
- `show_entity_id` — append the entity id chip.
- `show_avatar` — show user avatar (user targets; falls back to bundled `no-user.svg`).
- `convert_uppercase` — capitalize the first letter of a tag.
- `show_info_label` + `info_label` — token string rendered beside each tag/suggestion (e.g. `[node:type]`).
- `not_found_message`, `not_exist_message`, `tag_limit_message` — client messages.
- `cardinality`, `identifier` — derived field metadata passed to the JS.

## `select_active_tags` — "Select (Active Tags)"

- Class: `Drupal\active_tags\Plugin\Field\FieldWidget\SelectActiveTagsWidget`; renders a `<select>` (options from the field's allowed values / referenceable entities) as tags via `initSelect`.
- No autocomplete endpoint — the whitelist is the option list already in the DOM; selecting/removing a chip toggles the underlying `<option>`.
- Settings (`field.widget.settings.select_active_tags`): `match_operator`, `style`, `match_limit`, `placeholder`, `cardinality`, `identifier`.

## Behaviour notes

- Duplicate tags are blocked; tags are drag-sortable (core `Sortable`); cardinality caps the number of tags.
- `active_tags_update_8001()` renamed the old `limit` setting to `match_limit` on existing form displays.
- Extend suggestion labels with `hook_active_tags_autocomplete_match_alter(&$label, &$info_label, $context)` (deprecated older variant: `hook_active_tags_autocomplete_matches_alter`).
