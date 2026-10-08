# Hooks

The module has no `.api.php`, but the ViewsReferenceSetting plugin manager exposes one alter
hook (registered in `ViewsReferenceSettingManager::__construct`).

## `hook_viewsreference_viewsreference_setting_info_alter(array &$definitions)`
Alter the discovered ViewsReferenceSetting plugin definitions — add, remove, or reweight the
per-embed controls.

```php
function my_module_viewsreference_viewsreference_setting_info_alter(array &$definitions) {
  // Hide the offset control everywhere.
  unset($definitions['offset']);
}
```

The module itself also implements core Views hooks in `viewsreference.module`
(`hook_views_pre_view`, `hook_views_pre_render`, `hook_module_implements_alter`) to apply the
selected settings to the executing view — you do not call these, but they explain why arguments
and titles resolve at render time.
