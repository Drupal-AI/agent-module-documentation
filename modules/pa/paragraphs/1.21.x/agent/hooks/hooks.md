# Hooks

Declared in `paragraphs.api.php`. Implement in your `.module` (or a `#[Hook]` class).

## `hook_paragraphs_behavior_info_alter(array &$paragraphs_behavior)`
Alter the discovered behavior plugin definitions, keyed by plugin id.
```php
function mymodule_paragraphs_behavior_info_alter(&$paragraphs_behavior) {
  $paragraphs_behavior['my_layout']['label'] = t('New label');
}
```

## `hook_paragraphs_widget_actions_alter(array &$widget_actions, array &$context)`
Alter the action buttons/dropdown of the paragraphs widget. `$widget_actions` has `actions`
and `dropdown_actions`; `$context` carries `form`, `widget`, `items`, `delta`, `element`,
`form_state`, `paragraphs_entity`, `is_translating`, `allow_reference_changes`.

## `hook_paragraphs_conversion_alter(ParagraphInterface $original, ParagraphInterface $converted)`
Fires once per converted paragraph after a [conversion plugin](../plugins/conversion.md)
runs. Implementations must handle translations themselves.
```php
function mymodule_paragraphs_conversion_alter($original, $converted) {
  if ($converted->bundle() === 'text_image') { /* tweak $converted, then $converted is saved by caller */ }
}
```

Standard core alter hooks the module also invokes/uses include `hook_entity_type_alter`,
`hook_entity_base_field_info_alter`, `hook_migration_plugins_alter`, and theme suggestion
hooks (see [../theming/theming.md](../theming/theming.md)).
