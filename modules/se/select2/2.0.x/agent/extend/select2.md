# Extend & customise Select2

## Override Select2 config options — `#select2`

The element sets sensible Select2 defaults, but any [Select2 option](https://select2.org/configuration/options-api)
can be overridden with the `#select2` property (merged into `data-select2-config`, overrides win):

```php
$form['x'] = [
  '#type' => 'select2',
  '#options' => [...],
  '#select2' => [
    'allowClear' => FALSE,
    'minimumInputLength' => 2,
    'closeOnSelect' => FALSE,
  ],
];
```

The field widgets also feed their `width` setting through `#select2['width']`.

## Custom autocomplete route / options callbacks

Two callback hooks on the element let you bypass the built-in `select2.entity_autocomplete`
route and default option resolution:

- `#autocomplete_route_callback` — a callable `(&$element)` that sets
  `#autocomplete_route_name` and `#autocomplete_route_parameters`. Default:
  `Select2::setAutocompleteRouteParameters()`. (Select2 Facets uses this to point at its own
  `select2_facets.facet_autocomplete` route.)
- `#autocomplete_options_callback` — a callable `($element, $form_state)` returning the currently
  valid selected options (`id => label`). Default: `Select2::getValidSelectedOptions()`.

## Subclass the field widget

Both widgets are ordinary plugins you can extend:

- `Select2Widget extends OptionsSelectWidget` — override `defaultSettings()`, `settingsForm()`,
  `formElement()` (it sets `#type => 'select2'`, `#cardinality`, `#select2['width']`).
- `Select2EntityReferenceWidget extends Select2Widget` — adds `autocomplete` / `match_operator` /
  `match_limit` settings, resolves `#target_type` / `#selection_handler` / `#selection_settings`
  from the field, wires `#autocreate` from the reference handler's `auto_create` setting, and
  overrides `prepareFieldValues()` to create new entities via the handler's
  `createNewEntity()`.

## Alter autocomplete matches (no subclassing needed)

Implement `hook_select2_autocomplete_matches_alter(array &$matches, array $options)` to modify or
annotate autocomplete results globally (see api/select2.md). The `select2.autocomplete_matcher`
service is a plain class you can also decorate for wholesale replacement.

## Reuse `Select2Trait`

`Drupal\select2\Select2Trait::getValidReferenceableEntities()` returns valid `id => label` pairs
for an entity-reference selection handler — reused by the element and both widgets when you need
to resolve/validate selected reference options.
