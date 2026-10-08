# Hooks (`conditional_fields.api.php`)

Implement these to make non-Field-API "pseudo-fields" and container fields available as
controlling/dependent fields (e.g. Field Group, Paragraphs).

- `hook_conditional_fields($entity_type, $bundle_name)` — return extra fields keyed by machine
  name → label, so they appear in the dependency UI.
- `hook_conditional_fields_alter(&$fields, $entity_type, $bundle_name)` — alter that field list
  (e.g. sort it).
- `hook_conditional_fields_children($entity_type, $bundle_name)` — return `parent => [children]`
  for fields that contain other fields (Field Group, Paragraphs, …).
- `hook_conditional_fields_children_alter(&$fields, $entity_type, $bundle_name, $field)` — alter
  the resolved child-field list.
- `hook_handler_info_alter(&$definitions)` — alter/override registered handler plugins (see
  [../plugins/handler.md](../plugins/handler.md)).

See `ConditionalFieldForm::getFields()` and `DependencyHelper::getInheritingFieldNames()` for how
the returned data is consumed.
