# Glossify alter hooks

The submodule filters let other modules alter which terms are sourced. There is no `glossify.api.php`;
these are documented in the README and implemented via query tags / `moduleHandler->alter()`.

## Query tag alters (`hook_query_TAG_alter`)

Each filter tags its term-source query, so you can add joins/conditions:

| Filter | Query tag → hook |
|---|---|
| Glossify Node | `glossify_node_tooltip` → `hook_query_glossify_node_tooltip_alter()` |
| Glossify Taxonomy | `glossify_taxonomy_tooltip` → `hook_query_glossify_taxonomy_tooltip_alter()` |
| Glossify Commerce | `glossify_commerce_product_tooltip` → `hook_query_glossify_commerce_product_tooltip_alter()` |

Example — exclude taxonomy terms flagged by a boolean field:

```php
function MODULE_query_glossify_taxonomy_tooltip_alter(\Drupal\Core\Database\Query\AlterableInterface $query) {
  $query->leftJoin('taxonomy_term__field_exclude_from_glossary', 't__feg', 't__feg.entity_id = tfd.tid');
  $query->condition($query->orConditionGroup()
    ->condition('t__feg.field_exclude_from_glossary_value', 0)
    ->isNull('t__feg.field_exclude_from_glossary_value'));
}
```

Base table aliases: node query uses `nfd` (node_field_data), taxonomy uses `tfd`
(taxonomy_term_field_data), commerce uses `cpfd` (commerce_product_field_data).

## `glossify_taxonomy_vocabs` alter (taxonomy filter only)

`TaxonomyTooltip::process()` calls `$this->moduleHandler->alter('glossify_taxonomy_vocabs', $vocabs)`
before querying, so you can override the list of vocabulary ids at runtime:

```php
function MODULE_glossify_taxonomy_vocabs_alter(array &$vocabs) {
  $vocabs[] = 'tags';           // add a vocabulary to the source list
}
```

## Excluding text without code

Wrap the text in an element with class `glossify-exclude` (e.g.
`<span class="glossify-exclude">Term</span>`) — `parseTooltipMatch()` skips any node with that class.
The README shows adding a CKEditor 5 Style (`p.glossary-exclude|Exclude from glossary`) so editors can
apply it. (Note: the parser matches the class **`glossify-exclude`**.)
