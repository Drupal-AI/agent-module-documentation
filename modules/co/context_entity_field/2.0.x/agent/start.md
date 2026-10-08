# Context Entity Field — agent index

Adds one Context **condition** plugin, `entity_field`, that evaluates an entity field's state
(empty / filled / value-equals) so a Context can gate its reactions on field values. Depends on
contrib `context`. No config page (`configure: null`), no permissions, no schema, no Drush, and it
defines no plugin type of its own.

- **The `entity_field` condition — derivatives, config keys, evaluate() logic, UI scoping** →
  [plugins/condition.md](plugins/condition.md)

Key facts:
- Plugin `Drupal\context_entity_field\Plugin\Condition\EntityFieldCondition` (id `entity_field`),
  derived by `EntityFieldDeriver` (extends core `EntityBundle`) — one derivative per entity type
  that `hasKey('bundle')`, each with that entity type as context.
- Config: `field_name`, `field_state` (`filled`|`empty`|`value`), `field_value`.
- `context_entity_field_plugin_filter_condition_alter()` unsets `entity_field` from the
  `block_ui` and `layout_builder` consumers so it is Context-only.
