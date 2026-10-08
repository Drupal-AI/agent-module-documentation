# Term Dependent processor (`term_dependent`)

A Facets **build processor** (`@FacetsProcessor`, stage `build` weight 41) defined by
`src/Plugin/facets/processor/TermDependent.php`. It turns a facet into the CHILD level of a
drill-down: it keeps only the terms that are children of whatever term is currently selected in
another ("dependee") facet. Enable it per facet on the facet edit form (Processors section),
labelled **"Show terms on Dependee Facet"**. Its stage weight (41) is higher than Term Depth (40),
so it runs after Term Depth on the same facet.

Uses `UnchangingCacheableDependencyTrait` (static cache metadata) and reads the dependee facet's
Term Depth settings, so the **dependee facet must have the Term Depth processor enabled**.

## Settings

`buildConfigurationForm()` lists every OTHER facet (from `facets_facet` storage, excluding the
current one) with a single checkbox each:

| Key | Form field | Type | Meaning |
|---|---|---|---|
| `<facet_id>` › `dependee` | "Dependee" checkbox per listed facet | boolean | Treat that facet as the parent this one depends on |

Settings shape: a map keyed by facet id, e.g. `{ category_facet: { dependee: true } }`. More than
one dependee may be ticked.

## Runtime behavior — `build(FacetInterface $facet, array $results)`

1. Collects the facet ids whose `dependee` is truthy; if none, returns `$results` unchanged.
2. For each enabled dependee facet id:
   - Loads the facet (`facets_facet` storage) and rebuilds it via the `facets.manager` service
     (`returnBuiltFacet()`) so its active items are populated.
   - Reads the dependee's Term Depth settings:
     `getProcessorConfigs()['term_depth']['settings']['level']` and `['bundle']`.
   - Gets the dependee's `getActiveItems()` — the term ids the visitor selected in that facet.
   - If there is at least one active item, for each active `tid` calls `taxonomy_term`
     `loadTree($bundle, $tid, $level, TRUE)` (the subtree UNDER that parent term, to the dependee's
     depth, loaded as entities) and collects the descendant term ids.
   - `array_filter` keeps only this facet's results whose `getRawValue()` is in the collected ids.
   - `$facet->addCacheableDependency($current_facet)` so the result varies with the dependee facet.

If nothing is selected in the dependee facet, this facet's results pass through unchanged (a Term
Depth-limited child facet still shows its configured depth until a parent term is chosen).

## Enable via config (drush / YAML)

Inside the facet config entity (`facets.facet.<id>.yml`):

```yaml
processor_configs:
  term_dependent:
    processor_id: term_dependent
    weights: {  }
    settings:
      category_facet:      # the parent/dependee facet id
        dependee: true
```

Schema (`config/schema/facets_taxonomy_multilevel.processor.schema.yml`):
`plugin.plugin_configuration.facets_taxonomy_multilevel_processor.term_dependent` — a sequence of
mappings, each with a `dependee` boolean.

Caveats:
- The dependee facet MUST have Term Depth configured; `build()` reads its `level`/`bundle`
  unconditionally and errors if `term_depth` is absent from the dependee.
- Typical drill-down: parent facet = Term Depth level 1; child facet = Term Depth level 2 + Term
  Dependent pointing at the parent. Selecting a parent term narrows the child facet to that term's
  children.
