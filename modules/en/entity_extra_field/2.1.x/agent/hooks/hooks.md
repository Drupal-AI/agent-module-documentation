<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

## `hook_entity_extra_field_twig_context_alter(&$context, EntityInterface $entity, EntityDisplayInterface $display)`

Declared in `entity_extra_field.api.php`. Alter the Twig context passed to the `twig` extra-field plugin before its inline template renders. `$context` already contains `theme`, `theme_directory`, `base_path`, `front_page`, `is_front`, `language`, `is_admin`, `logged_in`, `entity` (see [../plugins/extra-field-types.md](../plugins/extra-field-types.md)).

```php
function mymodule_entity_extra_field_twig_context_alter(&$context, $entity, $display) {
  if ($entity->bundle() === 'article') {
    $context['new_variable'] = 'New variable value';
  }
}
```

Invoked from `ExtraFieldTwigPlugin::build()` via `$this->moduleHandler->alter('entity_extra_field_twig_context', $context, $entity, $display)`.

## `hook_extra_field_type_info_alter(array &$info)` (plugin alter)

The `ExtraFieldType` plugin manager calls `alterInfo('extra_field_type_info')`, so you can alter/remove the discovered field-type plugin definitions:

```php
function mymodule_extra_field_type_info_alter(array &$info) {
  // e.g. unset a plugin, or tweak a label.
  unset($info['twig']);
}
```

## Not a hook, but related

- Register a **new** field-type plugin by adding a class under `src/Plugin/ExtraFieldType/` with `@ExtraFieldType` — see the plugins doc.
- Visibility uses core **Condition** plugins (no custom condition hook here).
