<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the Term condition evaluates

Class: `Drupal\term_condition\Plugin\Condition\Term` (extends `ConditionPluginBase`,
implements `ContainerFactoryPluginInterface`). Injects `entity_type.manager` and
`current_route_match`. Config key constant `TERM_KEY = 'term_uuids'`.

## `evaluate()` logic (in order)

1. **Empty + not negated → TRUE.** If `term_uuids` is empty and the condition is not
   negated, it returns TRUE (does not restrict). (If negated, evaluation continues.)
2. **Resolve the entity.** It reads the `node` context value. If there is no node context,
   it falls back to the current route, trying these parameters in order:
   `taxonomy_term`, `node`, `node_revision`, `node_preview`.
   - If the route parameter is already an `EntityInterface`, that entity is used.
   - If it is a **string** (e.g. a revision id), it loads that revision with
     `getStorage($key)->loadRevision($entity)`.
   - If nothing resolves, `evaluate()` returns FALSE.
3. **Match by UUID.** It iterates `$entity->referencedEntities()`, skips non
   `taxonomy_term` references, and returns TRUE as soon as a referenced term's `uuid()` is
   in `term_uuids` (strict `in_array(..., TRUE)`). Otherwise FALSE.

The standard **Negate** flag (from `ConditionPluginBase`) inverts the final result the
condition system reports.

## Form & storage

- `buildConfigurationForm()` — one element `terms`: a tagged `entity_autocomplete`
  (`#target_type: taxonomy_term`, `#tags: TRUE`, `#maxlength: 1024`), defaulted from the
  currently configured terms.
- `submitConfigurationForm()` — converts each selected `target_id` to the term's UUID and
  stores the list in `configuration['term_uuids']`.
- `defaultConfiguration()` — `term_uuids: []`.
- `summary()` — "The node is [not] associated with taxonomy term(s): <names>."
- `loadTerms()` — `loadByProperties(['uuid' => term_uuids])`.

## Context requirement

The plugin declares a **non-required** `node` context
(`@ContextDefinition("entity:node", required = FALSE)`). Because it is not required, the
condition is offered even on routes without a node; the route-parameter fallback in
`evaluate()` is what lets it also work on taxonomy term / revision / preview routes.

## Reuse notes

This is a plain Condition plugin, so any condition consumer (block layout, Context,
asset_injector, …) can use `id: term`. To reuse programmatically, instantiate via
`\Drupal::service('plugin.manager.condition')->createInstance('term', $config)` and set the
`node` context, then call `evaluate()`.
