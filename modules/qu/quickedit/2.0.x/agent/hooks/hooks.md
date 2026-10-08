# Hooks (quickedit.api.php)

- `hook_quickedit_editor_alter(array &$editors)` — alter the registry of in-place editor plugin
  definitions, e.g. swap the class used for the `editor` (WYSIWYG) in-place editor:
  ```php
  function mymodule_quickedit_editor_alter(&$editors) {
    $editors['editor']['class'] = 'Drupal\mymodule\Plugin\quickedit\editor\MyEditor';
  }
  ```
- `hook_quickedit_render_field(EntityInterface $entity, $field_name, $view_mode_id, $langcode)` —
  return a renderable array for a single field's value when Quick Edit re-renders it after a
  save (used to wrap/customize the rendered field markup).

Implement in `mymodule.module`. See `quickedit.api.php` for full signatures.
