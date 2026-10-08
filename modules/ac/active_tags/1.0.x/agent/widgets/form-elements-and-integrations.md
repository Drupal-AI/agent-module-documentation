<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Active Tags — form elements & integrations

## Form-API render elements

Use these directly in a `$form` array (see the module README "Developers Guide" for full examples).

### `entity_autocomplete_active_tags`

- Class: `Drupal\active_tags\Element\EntityAutocompleteActiveTags` (`@FormElement`).
- Same shape as core's `entity_autocomplete` element, plus Active-Tags extras. Common keys:
  `#target_type`, `#tags` (TRUE for multi), `#default_value` (entities), `#selection_handler`,
  `#selection_settings` (e.g. `target_bundles`, `info_label`), `#autocreate` (`bundle`, `uid`),
  `#match_limit`, `#min_length`, `#delimiter`, `#style` (`rectangle`/`bubble`), `#show_entity_id`,
  `#not_exist_message`, `#not_found_message`, `#placeholder`.
- Points at the `active_tags.entity_autocomplete` route for suggestions.

### `select_active_tags`

- Class: `Drupal\active_tags\Element\SelectActiveTags` (`@FormElement`).
- A `<select>`-backed tag element: `#mode => 'select'`, `#options`, `#match_limit`, `#style`, `#placeholder`.

## Third-party integrations

These are optional plugins; they activate only when the host module is present.

- **Webform** — `src/Plugin/WebformElement/EntityAutocompleteActiveTags.php` (+ `WebformEntityReferenceActiveTagsTrait`) exposes an "Entity autocomplete (Active Tags)" element for the Webform builder.
- **Facets** — `src/Plugin/facets/widget/ActiveTagsWidget.php` renders a facet as an interactive tag widget (`assets.facets` library, depends on `facets/widget`). `initFacets` in the JS builds the whitelist from the facet links and toggles them.
- **Better Exposed Filters** — `src/Plugin/better_exposed_filters/filter/ActiveTags.php`, config key `better_exposed_filters.filter.bef_active_tags`; renders a Views exposed filter as Active Tags.

## Developer hook

```php
/**
 * Alter a single Active Tags autocomplete match before it is returned.
 */
function mymodule_active_tags_autocomplete_match_alter(&$label, &$info_label, array $context) {
  // $context holds target_type, handler, selection settings and the loaded 'entity'.
  // Set $label = NULL to drop the suggestion.
}
```

Invoked per match in `ActiveTagsEntityAutocompleteMatcher::getMatches()`. The older
`hook_active_tags_autocomplete_matches_alter(&$matches, $options)` still fires but is deprecated.
