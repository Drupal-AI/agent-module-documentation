# Services

Declared in `tagify.services.yml`.

## `tagify.autocomplete_matcher`
Class `Drupal\tagify\TagifyEntityAutocompleteMatcher` (interface
`TagifyEntityAutocompleteMatcherInterface`). Returns matching entities for the Tagify
autocomplete route.

```php
$matches = \Drupal::service('tagify.autocomplete_matcher')->getMatches(
  $target_type,        // e.g. 'taxonomy_term'
  $selection_handler,  // e.g. 'default'
  $selection_settings, // handler settings array
  $string,             // typed string
  $selected            // already-selected ids to exclude
);
// => [ ['label' => ..., 'value' => ..., 'info_label' => ...], ... ]
```
Fires `hook_tagify_autocomplete_match_alter()` per match (see hooks doc).

## `tagify.hierarchical_term_manager`
Class `TagifyHierarchicalTermManager` (interface `TagifyHierarchicalTermManagerInterface`).
Helpers for hierarchical vocabularies:

- `getTree(string $bundle): array`
- `getParents(array $tree, string $entity_id): array`
- `getParentName(string $entity_id, string $bundle): string`
- `isHierarchical(?EntityInterface $entity): bool`

## `tagify.theme_resolver`
Class `TagifyThemeResolver` (interface `TagifyThemeResolverInterface`). Resolves which
Tagify CSS variant (`default`, `claro`, `gin`) to attach based on the active theme.
