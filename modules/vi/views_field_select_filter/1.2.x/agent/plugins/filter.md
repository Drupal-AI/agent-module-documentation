# The `fieldselect` Views filter

Source: `src/Plugin/views/filter/FieldSelectFilter.php` (`@ViewsFilter("fieldselect")`, extends
`Drupal\views\Plugin\views\filter\InOperator`). It is not added by hand in code — the `.module`'s
`hook_views_data_alter` attaches it to every string/integer field so it appears in the Views UI filter
list as "<Field label> (selector)".

## How it is registered

`views_field_select_filter_views_data_alter()` loads all `field_config` of type `string` then `integer`.
For each, if `$data[$entity__field][$field_value]` exists it adds a sibling key
`<field>_value_fsf` with:

```
filter:
  id: fieldselect
  field: <field>_value        # the real DB column
  table: <entity>__<field>    # the field data table
  field_name: <field>
  allow empty: TRUE
```

## Behavior

- `operatorOptions()` returns `[]` — there is no operator select; it is a pure "value is one of" filter.
- `valueForm()` renders **nothing unless the filter is exposed** (`$form_state->get('exposed')`); as a
  non-exposed filter it stores no value.
- `getValueOptions()` builds the dropdown by querying distinct column values:
  `\Drupal::database()->select(table,'ft')->fields('ft',[field])->distinct()`, ordered by the field,
  and `fetchAllKeyed(0,0)` (value ⇒ value).

## Exposed-filter options (added in `buildExposeForm`)

| Option | Type | Default | Effect |
|---|---|---|---|
| `sort_values` | radios ASC/DESC (`0`/`1`) | `0` (ASC) | Orders the option query. |
| `current_language` | checkbox | `0` | Adds `condition('langcode', currentLanguage)`; only shown when the site has >1 language. |

If the View has an exposed/normal filter on content **type** with selected bundles, the option query is
also constrained with `condition('bundle', <types>, 'in')`, so the dropdown lists only values present in
those bundles.

## Caveats

- The distinct-values query runs directly against the field data table with **no entity/node access
  check**, so option values from unpublished or otherwise inaccessible content can appear in the
  dropdown (the result rows are still access-filtered by Views' own query — only the *option list* is
  unfiltered). Avoid on fields whose mere values are sensitive.
- Only `string` and `integer` single-value field columns (`<field>_value`) are supported.
