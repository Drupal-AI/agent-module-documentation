# How Select2 Publish decorates options

No configuration and no services — the module is entirely two hook implementations plus an asset
library. It only acts on entity types that implement
`Drupal\Core\Entity\EntityPublishedInterface`.

## Rendered options — `hook_element_info_alter()`

`select2_publish_element_info_alter()` appends a pre-render callback to the `select2` element:
`Drupal\select2_publish\Element\StatusProperties::preRender` (a `TrustedCallbackInterface`).
For a reference element it:

- Loads every option entity and sets `#options_attributes[$id]['data-published'] = 'true'|'false'`
  (rendered onto each `<option>` by the **form_options_attributes** module — hence the dependency).
- For autocreate/tags fields, computes the default published state of a would-be new entity and
  sets `data-select2-publish-default` on the element.
- Attaches the `select2_publish/select2.publish` library (CSS + JS, JS weight `-1`) that styles
  unpublished options.

## Autocomplete (AJAX) matches — `hook_select2_autocomplete_matches_alter()`

`select2_publish_select2_autocomplete_matches_alter(array &$matches, array $options)` runs after
the Select2 matcher builds results (still keyed by entity id). It loads the match entities and, for
publishable types, sets `$matches[$id]['published'] = $entity->isPublished()` so the client can
render status on lazily-loaded suggestions too. This is the reference implementation of the parent
module's `hook_select2_autocomplete_matches_alter()`.

## Library

`select2_publish/select2.publish` — `css/select2.publish.css` + `js/select2.publish.js`
(depends on `select2/select2`). Attached automatically by the pre-render above; consumes the
`data-published` / `data-select2-publish-default` attributes to style unpublished options.
