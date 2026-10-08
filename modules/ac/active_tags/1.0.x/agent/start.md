<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Active Tags (active_tags) — agent index

Client-side **chip/pill widget for entity_reference fields** (taxonomy free-tagging being the common case). Turns each referenced entity into a removable token with an autocomplete dropdown, highlighted matches, drag-reorder, duplicate blocking, and optional user avatars / entity-id / info-label decorations. Version **1.0.1**, core `^9.5 || ^10 || ^11`, depends on core `field` and `taxonomy`. Bundled **Tagify-derived** JS (`Drupal.ActiveTags`), served **locally** — no CDN.

## What it actually provides

- **Two field widgets** (assigned under *Manage form display*):
  - `entity_reference_autocomplete_active_tags` — "Autocomplete (Active Tags)", extends core `EntityReferenceAutocompleteWidget`. For `entity_reference` fields.
  - `select_active_tags` — "Select (Active Tags)". Renders a `<select>` as tags.
- **Two Form-API render elements** for custom forms: `entity_autocomplete_active_tags`, `select_active_tags` (see README "Developers Guide" for `#type` examples).
- **Custom autocomplete route** `active_tags.entity_autocomplete` → `/active_tags/{target_type}/{selection_handler}/{selection_settings_key}`, controller subclasses core `EntityAutocompleteController`; matcher `ActiveTagsEntityAutocompleteMatcher` returns `entity_id`, `label`, `info_label`, `avatar` as JSON.
- **Integration plugins**: Webform element (`EntityAutocompleteActiveTags`), Facets widget (`ActiveTagsWidget`), Better Exposed Filters filter (`bef_active_tags`).
- **Alter hook**: `hook_active_tags_autocomplete_match_alter($label, $info_label, $context)` to change suggestion labels.
- **Config schema** for both widgets' settings (match operator, limit, min length, delimiter, style, placeholder, show_entity_id, show_avatar, convert_uppercase, info_label token, not-found/not-exist/tag-limit messages).
- No permissions, no Drush commands, no external libraries.

## Key files

- `active_tags.routing.yml` — the autocomplete route (note `_access: 'TRUE'`, mirroring core; access is gated by an HMAC `selection_settings_key`).
- `src/ActiveTagsEntityAutocompleteMatcher.php` — builds the suggestion JSON (labels, info_label token replacement, user avatar).
- `src/Controller/ActiveTagsEntityAutocompleteController.php` — validates the settings-key hash and calls the matcher.
- `src/Plugin/Field/FieldWidget/*` — the two widgets. `src/Element/*` — the two render elements.
- `assets/js/active-tags.js` — bundled Tagify-derived library. `assets/js/active-tags.init.js` — `Drupal.behaviors.activeTagsWidgets`, the tag/dropdown templates and the `fetch()` to the autocomplete endpoint.
- `assets/css/active-tags{,.claro,.gin,.seven}.css` — base + admin-theme variants.

## Detail docs

- `widgets/field-widgets.md` — the two field widgets, settings, and how the autocomplete flow works.
- `widgets/form-elements-and-integrations.md` — the render elements, Webform/Facets/BEF plugins, and the alter hook.

## Notes / gotchas

- Despite the `taxonomy` dependency it works for **any** entity_reference target type; `user` targets get avatar support.
- The autocomplete endpoint returns display labels via `Html::decodeEntities()` and the client renders them into tag pills / suggestions; treat entity labels as the display source of truth.
- Free tagging is a governance decision more than a widget one — any create-capable widget grows a vocabulary; a review process or restricted `target_bundles` matters more than the widget.
