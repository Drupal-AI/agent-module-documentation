# Hooks

The module invites exactly one hook (`plugin.api.php`).

## `hook_plugin_selector_alter(array &$definitions)`

Alter the discovered **plugin selector** plugin definitions (keys are plugin ids, values are
definitions).

```php
function my_module_plugin_selector_alter(array &$definitions) {
  // Remove a selector.
  unset($definitions['plugin_radios']);

  // Swap a selector's class.
  $definitions['plugin_select_list']['class'] = \Drupal\my_module\MySelectList::class;
}
```

That is the only hook. Everything else is done through services
(`plugin.plugin_type_manager`, `plugin.manager.plugin.plugin_selector`) and the
`ResolveDefaultPlugin` event, not hooks.
