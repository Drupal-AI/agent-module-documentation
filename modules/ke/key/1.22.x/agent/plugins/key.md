# Define Key plugins (KeyType / KeyProvider / KeyInput)

Key defines **three plugin types**, each managed by `Drupal\key\Plugin\KeyPluginManager`
(services `plugin.manager.key.key_type`, `.key_provider`, `.key_input`). Discovery is by
annotation (attribute equivalents not shipped — use annotations). Put plugins under
`src/Plugin/KeyType|KeyProvider|KeyInput/` in your module.

| Plugin type | Annotation | Base class | Interface |
|---|---|---|---|
| Key type | `@KeyType` | `KeyTypeBase` | `KeyTypeInterface` (multivalue: `KeyTypeMultivalueInterface`) |
| Key provider | `@KeyProvider` | `KeyProviderBase` | `KeyProviderInterface` (settable: `KeyProviderSettableValueInterface`) |
| Key input | `@KeyInput` | `KeyInputBase` | `KeyInputInterface` |

`@KeyType` properties: `id`, `label`, `description`, `group` (e.g. `authentication`,
`encryption`), `key_value` (which input plugin, default `text_field`), `multivalue`.
`@KeyProvider` adds `storage_method` and `tags`. Optionally implement `KeyPluginFormInterface`
for a settings form.

## Example key provider (fetch from an external vault)
```php
namespace Drupal\mymodule\Plugin\KeyProvider;

use Drupal\key\Plugin\KeyProviderBase;
use Drupal\key\KeyInterface;

/**
 * @KeyProvider(
 *   id = "my_vault",
 *   label = @Translation("My Vault"),
 *   description = @Translation("Fetches the value from My Vault."),
 *   storage_method = "remote",
 *   key_value = { "accepted" = FALSE, "required" = FALSE }
 * )
 */
class MyVaultKeyProvider extends KeyProviderBase {
  public function getKeyValue(KeyInterface $key) {
    // Return the secret string for $key->getConfiguration()['...'].
  }
}
```

Built-in providers to model on: `EnvKeyProvider`, `FileKeyProvider`, `ConfigKeyProvider`,
`StateKeyProvider`. Alter registered providers with
[hook_key_provider_info_alter()](../hooks/key.md).
