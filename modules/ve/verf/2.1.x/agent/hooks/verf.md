# Altering VERF's option list

VERF does not ship a `verf.api.php`, but it invokes one alter hook and one Views data
hook you can interact with.

## `hook_verf_entites_options_alter(array &$entities)`

Invoked from `EntityReference::getReferenceableEntities()` via:

```php
$this->moduleHandler->alter('verf_entites_options', $referenceable_entities);
```

- Runs **after** VERF has loaded the referenceable target entities and (unless "Ignore
  access control" is on) removed those the current user cannot `view`.
- `$entities` is an array of loaded entity objects (`\Drupal\Core\Entity\EntityInterface[]`)
  that will become the filter's selectable options (each resolved to its label afterward).
- Add entities to expose extra options, or unset entities to hide them.

Note the hook name is spelled **`verf_entites_options`** (missing an "i" in "entities") —
match it exactly. Full hook function name: `hook_verf_entites_options_alter()`.

```php
/**
 * Implements hook_verf_entites_options_alter().
 */
function mymodule_verf_entites_options_alter(array &$entities) {
  // Remove archived nodes from any VERF filter's options.
  foreach ($entities as $id => $entity) {
    if ($entity->getEntityTypeId() === 'node' && $entity->hasField('field_archived')
        && (bool) $entity->get('field_archived')->value) {
      unset($entities[$id]);
    }
  }
}
```

Caveat: this alter fires for **all** VERF filters (it has no per-field/per-view context
argument), so guard on entity type/bundle if you only want to affect specific filters.

## `hook_views_data_alter()` (how the handlers are generated)

`verf_views_data_alter()` is VERF's own implementation; you normally don't reimplement it,
but understanding it explains where the filters come from. For every entity reference
field it adds a `{column}_verf` filter entry with `filter.id = 'verf'` and a
`verf_target_entity_type_id` key. It covers both `field_config` entity_reference fields and
SQL-stored base fields (via `verf_get_filter()`, a public helper in `verf.module` returning
the filter definition array). If your custom entity type stores references with custom
storage (`hasCustomStorage()`), VERF skips it.
