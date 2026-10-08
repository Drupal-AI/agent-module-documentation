<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `node_field` Condition plugin

Class `Drupal\entity_field_condition\Plugin\Condition\NodeField` extends
`ConditionPluginBase`. It is a **consumer** of the condition/context system, not a plugin
*type* — you don't implement new plugins, you configure this one.

## Context

```
@Condition(
  id = "node_field",
  context_definitions = { "node" = @ContextDefinition("entity:node", required = TRUE) }
)
```
It needs a `node` in context. In block visibility the UI supplies the mapping
`node: '@node.node_route_context:node'` automatically.

## Configuration keys (schema `condition.plugin.node_field`)

| Key | Meaning |
|---|---|
| `entity_type_id` | always `node` (default). |
| `entity_bundle` | a node type machine name, or `''` = **Any bundle**. |
| `field` | the field machine name to inspect (e.g. `title`, `field_foo`). |
| `value_source` | `null` (Is NULL) \| `specified` (exact `===`) \| `contains` (regex `preg_match`). |
| `value` | the string to compare (ignored when `value_source` is `null`). |
| plus the standard condition keys | `id`, `negate`, `context_mapping`. |

## How `evaluate()` decides

- If `field` is empty and the condition is **not** negated → returns TRUE.
- Loads the field value off the context node. Only acts when the entity is a content entity
  of `entity_type_id` and (bundle is empty **or** matches `entity_bundle`).
- **Structured/multi-value fields**: iterates each delta, taking `target_id` (entity
  references), else `uri` (link fields), else `value`. Returns TRUE on the first delta that
  `=== value` (this short-circuit fires regardless of `value_source`).
- **Scalar fields**: compares the single value per `value_source`:
  - `null` → `is_null($value)`
  - `specified` → `$value === $configuration['value']`
  - `contains` → `preg_match('/' . $value . '/', $field_value)` (⚠ the configured value is used
    as a raw regex pattern — escape `/` and regex metachars if you mean a literal substring).
- Wrap with the host's **Negate** toggle to invert the result.

## Attach it to a block (config)

A placed block stores the condition under `visibility`:

```yaml
# config: block.block.<id>
visibility:
  node_field:
    id: node_field
    negate: false
    context_mapping:
      node: '@node.node_route_context:node'
    entity_type_id: node
    entity_bundle: article
    field: title
    value_source: specified
    value: 'Welcome'
```

Read/verify with: `drush cget block.block.<id> visibility.node_field`.

## Attach it in code

```php
$manager = \Drupal::service('plugin.manager.condition');
$condition = $manager->createInstance('node_field', [
  'entity_type_id' => 'node',
  'entity_bundle' => 'article',
  'field' => 'field_foo',
  'value_source' => 'contains',
  'value' => 'promo',
]);
$condition->setContextValue('node', $node);
$result = $condition->evaluate();   // bool
```
