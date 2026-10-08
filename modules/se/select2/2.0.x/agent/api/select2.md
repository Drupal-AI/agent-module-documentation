# The `select2` render element, autocomplete route, matcher & hook

## `#type => 'select2'` render element

`Drupal\select2\Element\Select2` extends core's `Select`. Use it in any form like a normal
select element.

```php
// Simple searchable select (optgroups supported):
$form['color'] = [
  '#type' => 'select2',
  '#title' => $this->t('Colour'),
  '#options' => ['r' => 'Red', 'g' => 'Green', 'b' => 'Blue'],
];

// Entity reference with AJAX autocomplete instead of rendered options:
$form['ref'] = [
  '#type' => 'select2',
  '#title' => $this->t('Article'),
  '#autocomplete' => TRUE,
  '#target_type' => 'node',
  '#selection_handler' => 'default',              // optional, defaults to 'default'
  '#selection_settings' => ['target_bundles' => ['article']],
];

// Allow creating entities on the fly ("tags"):
$form['tags'] = [
  '#type' => 'select2',
  '#target_type' => 'taxonomy_term',
  '#autocreate' => ['bundle' => 'tags'],          // 'uid' optional, defaults to current user
];
```

### Element properties (defaults from `getInfo()`)

| Property | Default | Purpose |
|---|---|---|
| `#target_type` | `NULL` | Entity type for reference/autocomplete/autocreate |
| `#selection_handler` | `'default'` | Entity reference selection plugin id |
| `#selection_settings` | `[]` | Handler settings (e.g. `target_bundles`) |
| `#autocomplete` | `FALSE` | Lazy-load options over AJAX rather than rendering them |
| `#autocreate` | `[]` | `['bundle' => …, 'uid' => …]` to create missing entities (enables Select2 `tags`) |
| `#cardinality` | `0` | Max selections (0 = unlimited); maps to `maximumSelectionLength` when multiple |
| `#empty_value` | `''` | Value of the empty/placeholder option |
| `#select2` | `[]` | Raw Select2 config overrides (see extend/select2.md) |
| `#autocomplete_options_callback` | — | Callback returning currently-valid selected options |
| `#autocomplete_route_callback` | — | Callback that sets `#autocomplete_route_name` + parameters |

The element attaches the `select2/select2` library, the per-language
`select2/select2.i18n.<langcode>` library, and (if present) the active theme's `select2.theme`
library. Multiple selection is drag-sortable via `core/sortable`. On submit the element
switches its `#type` back to `select` for core validation and, for reference fields, returns
`target_id` value arrays.

## Autocomplete route

`select2.entity_autocomplete` →
`/select2_autocomplete/{target_type}/{selection_handler}/{selection_settings_key}`
(controller `EntityAutocompleteController::handleAutocomplete`). `_access: 'TRUE'` — access is
enforced instead by an HMAC hash of the selection settings (stored in the `entity_autocomplete`
key/value store, salted with the site hash). It reads the typed string from `?q=`, excludes
already-`selected` ids, and returns JSON `{results: [{id, text}, …]}` in Select2's expected shape.

## Matcher service

`select2.autocomplete_matcher` → `Drupal\select2\EntityAutocompleteMatcher`.

```php
$matcher = \Drupal::service('select2.autocomplete_matcher');
$results = $matcher->getMatches($target_type, $selection_handler, $selection_settings, $string, $selected);
// → [['id' => …, 'text' => …], …]
```

It resolves the entity-reference selection handler, applies `match_operator` (default `CONTAINS`)
and `match_limit` (default 10), decodes labels, and filters out already-selected ids.

## Alter hook

`hook_select2_autocomplete_matches_alter(array &$matches, array $options)` — invoked by the
matcher after building results (keyed by entity id at that point; `$options` includes
`target_type` / `handler`). Add or modify per-match data. There is no `select2.api.php`; the
Select2 Publish submodule is the reference implementation (it adds a `published` flag per match).
