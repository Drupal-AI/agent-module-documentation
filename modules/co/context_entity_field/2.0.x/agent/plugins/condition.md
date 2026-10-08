# The `entity_field` condition plugin

`Drupal\context_entity_field\Plugin\Condition\EntityFieldCondition` — a **Context condition**
(core `@Condition` plugin type; this module does not define its own plugin manager). Use it inside
a Context's *Conditions* to activate reactions based on an entity field's value.

## Derivatives

`deriver = EntityFieldDeriver` (extends `Drupal\Core\Entity\Plugin\Condition\Deriver\EntityBundle`).
`getDerivativeDefinitions()` iterates every entity type where `hasKey('bundle')` is TRUE and
creates one derivative per type (`entity_field:node`, `entity_field:taxonomy_term`,
`entity_field:media`, …). Each derivative:
- sets `context_definitions` to a single `EntityContextDefinition::fromEntityType($entity_type)`,
  so the condition requires that entity as context (Context provides it on entity routes);
- labels itself "&lt;Bundle label&gt; field" (with fallbacks for types lacking a bundle label).

## Configuration (`defaultConfiguration()`)

| Key | Default | Meaning |
|---|---|---|
| `field_name` | `''` | Machine name of the field to inspect (select is populated from the entity type's field map). |
| `field_state` | `filled` | `filled`, `empty`, or `value`. |
| `field_value` | `''` | Compared string when `field_state` = `value` (form field only visible then). |

`buildConfigurationForm()` lists fields via `entity_field.manager` `getFieldMap()` for the
derivative's entity type. `submitConfigurationForm()` stores the raw form values.

## Evaluation (`evaluate()`)

```php
$entity = $this->getContextValue($this->entityType->id());
if ($entity && $entity->hasField($field_name)) {
  $is_empty = $entity->get($field_name)->isEmpty();
  if ($field_state === 'empty'  && $is_empty)  return TRUE;
  if ($field_state === 'filled' && !$is_empty) return TRUE;
  if ($field_state === 'value'  && !$is_empty) {
    foreach ($entity->get($field_name) as $item) {
      if ($item->getString() === $field_value) return TRUE; // strict, per-item
    }
  }
}
return FALSE;
```

- `value` matching is **strict string equality** against each field item's `getString()`; any one
  matching item returns TRUE.
- Missing entity, missing field, or (for `value`/`filled`) an empty field → FALSE.

## UI scoping

`context_entity_field_plugin_filter_condition_alter()` removes the `entity_field` definition when
the consumer is `block_ui` or `layout_builder`, keeping this condition available only through the
Context UI.
