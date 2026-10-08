# Hooks

From `organigrams.api.php`. Both are `alter` hooks invoked while the tree is built/rendered by
`TaxonomyTermTree` / `OrganigramsController`.

## `hook_organigrams_taxonomy_term_tree_alter(array &$items)`
Alter the hierarchical array of taxonomy terms before it is turned into the chart render array.
Use it to add, remove, reorder, or annotate nodes programmatically.

```php
function mymodule_organigrams_taxonomy_term_tree_alter(array &$items) {
  // $items is the hierarchical term list; mutate in place.
}
```

## `hook_organigrams_taxonomy_term_markup_alter(string &$markup, object $term)`
Alter the rendered HTML for a single term node.

```php
function mymodule_organigrams_taxonomy_term_markup_alter(string &$markup, object $term) {
  // $markup is the node's rendered HTML; $term is the taxonomy term.
}
```

The module itself also implements core hooks worth knowing: `hook_token_info()` / `hook_tokens()`
(the `organigrams` token type, one `[organigrams:{vid}]` token per vocabulary),
`hook_form_alter()` (vocabulary add/edit + term overview tweaks), and
`hook_entity_type_alter()` (swaps in `OrganigramsListBuilder` to highlight organigram vocabularies).
