<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search endpoint (Bootstrap-table dialog data source)

## Route & controller

`entity_reference_modal.search` →
`/entity-reference-modal/search/{target_type}/{selection_handler}/{selection_settings_key}`
→ `EntityReferenceModalController::fieldReference()`; methods `[GET]`, `_format: json`, requirement
`_access: 'TRUE'` (public route, by design — it is the data URL the client-side Bootstrap-table fetches).

## How the key works

The widget serializes the field's selection settings and stores them in the `entity_autocomplete` key-value
collection under
`Crypt::hmacBase64(serialize($selection_settings) . $target . $handler, Settings::getHashSalt())`.
That HMAC is the `{selection_settings_key}` path segment. `fieldReference()` loads the stored settings back
out of key-value by that key.

## Response building

- **Default (non-views) handler:** builds selection options
  (`target_type`, `target_bundles` from the stored settings, `handler => 'default:'.$target_type`; for `user`
  it forces `target_bundles = NULL`), gets the entity-reference selection plugin instance
  (`plugin.manager.entity_reference_selection`), and returns `getReferenceableEntities()` as an array of
  `{id, name: label}` rows in a `JsonResponse`. The default selection handler applies its own entity access
  checks, so rows are limited to entities the requester may view.
- **Views handler (`selection_handler == 'views'`):** loads the configured view, executes the display, and
  returns each result row as `{id, <field> => advancedRender(...)}`. If the GET request carries any query
  (exposed filter) values, the controller **clones the source display into a new `<display>_block` display and
  saves it back to the view's config** before executing.

## `js/entity-reference-search.js`

The search dropbutton link is `use-ajax`-free; the behavior `entity_reference_search` intercepts the click,
builds a `bootstrap-table` (`data-url` = the search route) with columns from
`drupalSettings.entity_reference_search[<field>].columns`, opens it in a jQuery-UI dialog, and on "Select"
writes `row[search_key] (row.id)` into the field input, caches the selection in `localStorage`
(`Drupal.entityReferenceModal`), and dispatches a `referenceModalSelected` DOM event.

## Notes

- The route is the public JSON data URL that the client-side Bootstrap-table fetches; it returns referenceable
  entity ids/labels for the given `target_type`, and the selection handler applies its own entity access checks
  to those rows.
- On the views-handler path, an exposed-filter query causes the controller to derive and persist a
  `<display>_block` display on the view (`$view_config->set('display', …)->save()`) before executing it — keep
  this in mind when reasoning about a view's stored displays.
