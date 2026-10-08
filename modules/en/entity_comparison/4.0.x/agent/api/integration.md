<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integration points: blocks, fields, Views, routes, hooks

## The toggle route

```
entity_comparison.action
  path: /entity-comparison/{entity_comparison_id}/{entity_id}
  controller: EntityComparisonController::action
  requirements: _permission: 'access content'
```

`action()` toggles the entity in the session, then either redirects to `?destination` (falling
back to `/` — external destinations are rejected and replaced with `/`) or, when the request
carries `_wrapper_format=drupal_ajax`, returns an `AjaxResponse` with:

- a `ReplaceCommand` on `[data-entity-comparison={comparison_id}-{entity_id}]` re-rendering the link,
- a `ReplaceCommand` on `#comparison-table` when the destination contains `/compare/`,
- a `ReplaceCommand` on `a.{block link class}` for every placed comparison block,
- `MessageCommand`s for each status/error message.

Toggle logic (`processRequest()`): the entity is added if absent, removed if present. On add it
checks the limit; on remove it just unsets the key. The session key is
`entity_comparison_{uid}` and the structure is
`[entity_type][bundle_type][comparison_id][] = entity_id`.

```php
// Read the current list programmatically.
$uid  = \Drupal::currentUser()->id();
$list = \Drupal::service('session')->get('entity_comparison_' . $uid);
$ids  = $list['node']['product']['products'] ?? [];
```

## Blocks

| Plugin id | Deriver | Renders |
|---|---|---|
| `entity_comparison_block` | `Derivative\EntityComparisonBlock` | A link to the comparison page, with the item count; block setting `link_text` |
| `entity_comparison_link_block` | `Derivative\EntityComparisonLinkBlock` | The add/remove link for the entity in the current context |

Both are derived per comparison and appear under the *Comparisons* block category. The first
block's anchor gets the class `entity-comparison-{id}` (`getLinkClass()`), which is what the AJAX
response targets — keep it if you override the block template.

## Field type / formatter / Views

- Computed base field **`entity_comparison_link`** added by `hook_entity_bundle_field_info()` on
  the target bundle, `setCustomStorage(TRUE)`, display type `entity_comparison_link`, setting
  `enitity_comparison` (note the typo — it is the real key in code and schema).
- `hook_entity_field_access()` allows `view` on any `entity_comparison_link` field only for users
  with `use {id} entity comparison`, deriving the id from the field name
  (`link_for_entity_comparison_{id}`).
- `hook_entity_extra_field_info()` + `hook_entity_view()` provide the
  `link_for_entity_comparison_{id}` display component (weight 100, visible by default).
- `hook_views_data_alter()` registers a comparison-link Views field
  (`Plugin/views/field/EntityComparisonLink.php`) on the entity's data table for bundles that have
  a comparison.

## Theme

One theme hook, `entity_comparison_link` (variables `entity_comparison`, `id`; preprocessor in
`entity_comparison.theme.inc`). Every render of it sets `#cache: ['max-age' => 0]` and
`#access => hasPermission("use {id} entity comparison")`, so any display containing the link is
uncacheable — expect a measurable hit on listing pages and consider placing the link only in
views/blocks that are already dynamic.

The comparison table is rendered by the controller (id `#comparison-table`), not by a dedicated
theme hook; override it through `hook_entity_comparison_rows_alter()` or a preprocess on the
table render array.

## `hook_entity_comparison_rows_alter()`

```php
/**
 * Implements hook_entity_comparison_rows_alter().
 */
function mymodule_entity_comparison_rows_alter(array &$header, array &$rows, array $comparison_context) {
  // $comparison_context = [
  //   'entity_comparison'  => \Drupal\entity_comparison\Entity\EntityComparison,
  //   'entities'           => [entity_id => entity, …] in table-column order,
  //   'comparison_fields'  => [entity_id => [field_name => rendered markup]],
  // ];
  $row = [t('Price per unit')];
  foreach ($comparison_context['entities'] as $entity) {
    $row[] = number_format($entity->field_price->value / max(1, $entity->field_units->value), 2);
  }
  $rows[] = $row;
}
```

Use it to add computed rows, reorder, or blank out cells. The header's first cell is empty (it is
the field-label column) and the first row is the "Remove from the list" row.

## Rendering notes for the compare page

- Each entity is loaded by id from the session list; if it no longer exists it is silently removed
  from the list and skipped.
- The current language's translation is used when the entity has one.
- Fields are rendered with `$view_builder->viewField($field, $display_component)` using the
  generated view mode's components — so field-level access applies.
- Entity labels in the header link to the canonical route when the entity type has one.
