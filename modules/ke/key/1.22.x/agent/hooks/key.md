# Hooks

Declared in `key.api.php`.

## `hook_key_provider_info_alter(array &$key_providers)`
Alter the discovered **key provider** plugin definitions (invoked from the provider plugin
manager). Use it to swap classes, change labels, or remove a provider.

```php
function mymodule_key_provider_info_alter(array &$key_providers) {
  // Swap the classes used for the Configuration and File key providers.
  $key_providers['config']['class'] = 'Drupal\key\Plugin\KeyProvider\FileKeyProvider';
  $key_providers['file']['class']   = 'Drupal\key\Plugin\KeyProvider\ConfigKeyProvider';
}
```

Standard plugin-manager `hook_*_info_alter()` also applies to key types and inputs via their
managers (`plugin.manager.key.key_type` / `.key_input`). To add new plugins, see
[plugins/key.md](../plugins/key.md).
