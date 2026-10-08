# Term Depth processor (`term_depth`)

A Facets **build processor** (`@FacetsProcessor`, stage `build` weight 40) defined by
`src/Plugin/facets/processor/TermDepth.php`. It filters a taxonomy facet down to the terms that sit
at ONE chosen depth of ONE vocabulary — e.g. show only top-level categories. Enable it per facet on
the facet's edit form (Processors section) at `/admin/config/search/facets/<facet>/edit`, labelled
**"Show terms of defined depth"**.

## Settings

| Key | Form field | Type | Meaning |
|---|---|---|---|
| `level` | Level (number, min 1, default 1) | integer | 1-based depth to keep; **1 = root terms** |
| `bundle` | Vocabulary (select) | string | Vocabulary machine name whose tree is read |

`buildConfigurationForm()` populates the `bundle` options from every entity in
`taxonomy_vocabulary` storage.

## Runtime behavior — `build(FacetInterface $facet, array $results)`

1. Reads its own `level` and `bundle` from the facet's processor config; computes
   `depth = level - 1` (Drupal term depth is 0-based).
2. `taxonomy_term` storage `loadTree($bundle, 0, $level, FALSE)` — a lightweight tree of the whole
   vocabulary down to max depth `$level`.
3. Collects the `tid`s of terms whose `->depth === depth` into `$valid_terms`.
4. `array_filter($results, …)` keeps only facet results whose `getRawValue()` (the indexed term id)
   is in `$valid_terms`.
5. Any exception → returns an **empty** result set (the facet shows nothing). So a missing or
   mis-typed `bundle` silently empties the facet.

The facet's source/index is untouched; this only trims the displayed result array, so enabling or
disabling it is free and reversible.

## Enable via config (drush / YAML)

Normally set from the Facets UI; the values live inside the facet config entity
(`facets.facet.<id>.yml`):

```yaml
processor_configs:
  term_depth:
    processor_id: term_depth
    weights: {  }
    settings:
      level: 1
      bundle: categories   # vocabulary machine name
```

Schema (`config/schema/facets_taxonomy_multilevel.processor.schema.yml`):
`plugin.plugin_configuration.facets_taxonomy_multilevel_processor.term_depth` — mapping of `level`
(integer) and `bundle` (string).

Notes:
- Meaningful only for facets whose field is a taxonomy term reference (it matches result raw values
  against term ids).
- Pair it with Term Dependent to build a category → subcategory drill-down (see
  [term-dependent.md](term-dependent.md)).
