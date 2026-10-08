# Views filter: search_api_taxonomy_machine_name

A Views filter for **Search API index** views that filters on taxonomy term machine names,
with optional hierarchy depth controls.

- **id**: `search_api_taxonomy_machine_name`
- **class**: `Drupal\search_api_taxonomy_machine_name\Plugin\views\filter\SearchApiTaxonomyMachineName`
- extends the parent module's `TaxonomyIndexMachineName` and adds `SearchApiFilterTrait`.

## How it is wired

`hook_views_data_alter()` (`search_api_taxonomy_machine_name.views.inc`) scans every Search
API index's Views data and, for any field where `entity_type === 'taxonomy_term'` and
`field_name === 'machine_name'`, overrides the filter handler id to
`search_api_taxonomy_machine_name`. So on a Search API view, the machine-name field's filter
automatically uses this handler — you just add the field's filter to the view.

## Options it adds on top of the base filter

Inherited from `TaxonomyIndexMachineName`: selection **type** (Dropdown / Autocomplete),
vocabulary **limit** / **vid**, **hierarchy** (show hierarchy in dropdown), error message.
Added here:

| Option | Meaning | Default |
|---|---|---|
| `hierarchy_parent` | "Start at level" — passed as the `$parent` arg to `loadTree()` | `0` |
| `hierarchy_max_depth` | "Max depth" — passed as `$max_depth` to `loadTree()` (blank ⇒ NULL ⇒ unlimited) | `NULL` |

Both only apply when the **hierarchy** checkbox is on and the vocabulary is limited; the
dropdown is then built from `termStorage->loadTree($vid, $hierarchy_parent, $hierarchy_max_depth, TRUE)`
and each option gets a `level-<depth>` CSS class. An empty "Max depth" string is normalised
to NULL in `validateExtraOptionsForm()`.

## Typical use

1. Have a Search API index with a taxonomy term reference field indexed as its
   `machine_name` (see [../plugins/hierarchy-processor.md](../plugins/hierarchy-processor.md)).
2. Create a Search API view on that index.
3. Add the machine-name field as a **filter** (it resolves to this handler automatically).
4. Expose it, pick Dropdown + hierarchy, and set Start at level / Max depth to scope the tree.

For full-hierarchy matching (parent query returns descendants) also enable the
`taxonomy_machine_name_hierarchy` processor on the index so ancestor slugs are indexed.
