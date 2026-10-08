# Plugin type: VaultAuth (authentication strategies)

Defines *how* Drupal authenticates to the Vault/OpenBao server. The base module defines the
plugin **type** but ships **no** implementations — concrete strategies (Token, AppRole, …)
live in separate drupal.org projects that depend on `vault`.

| Element | Value |
|---------|-------|
| Discovery dir | `Plugin/VaultAuth` (in any module) |
| Interface | `Drupal\vault\Plugin\VaultAuthInterface` (`@api`) |
| Base class | `Drupal\vault\Plugin\VaultAuthBase` (`@api`) |
| Annotation | `@VaultAuth` (`Drupal\vault\Annotation\VaultAuth`: `id`, `label`) |
| Manager service | `plugin.manager.vault_auth` (`VaultAuthManager`) |
| Alter hook | `hook_vault_vault_auth_info_alter(&$definitions)` |
| Plugin cache key | `vault_vault_auth_plugins` |
| Config form (optional) | implement `Drupal\vault\Plugin\VaultPluginFormInterface` (extends core `PluginFormInterface`) |

The one required method is `getAuthenticationStrategy(): \Vault\AuthenticationStrategies\AuthenticationStrategy`
— it returns a strategy object from the `csharpru/vault-php` library, which the client applies
via `setAuthenticationStrategy()` before `authenticate()`.

`VaultAuthBase` implements `VaultAuthInterface`, `ContainerFactoryPluginInterface`, and
`DependentPluginInterface`, and declares an abstract `create()` — so a plugin can inject
services and declare config dependencies.

## Selecting / configuring

The chosen plugin id is stored in `vault.settings:plugin_auth`; its per-plugin settings go in
`auth_plugin_config` (schema `vault.auth_plugin.[plugin_auth]`). The settings form
(`VaultConfigForm`) lists all plugin definitions in the "Authentication Strategy" select and,
if the plugin implements `VaultPluginFormInterface`, renders its subform (AJAX-swapped when the
selection changes) and stores the values via the plugin's `ConfigurableInterface::getConfiguration()`.

## Skeleton for a new strategy

```php
namespace Drupal\my_vault_auth\Plugin\VaultAuth;

use Drupal\vault\Plugin\VaultAuthBase;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Vault\AuthenticationStrategies\TokenAuthenticationStrategy;
use Vault\AuthenticationStrategies\AuthenticationStrategy;

/**
 * @VaultAuth(
 *   id = "my_token",
 *   label = @Translation("My Token Auth"),
 * )
 */
final class MyTokenAuth extends VaultAuthBase {

  public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition): self {
    return new self($configuration, $plugin_id, $plugin_definition);
  }

  public function getAuthenticationStrategy(): AuthenticationStrategy {
    return new TokenAuthenticationStrategy($this->configuration['token']);
  }

}
```

Add `Drupal\Core\Plugin\PluginFormInterface`/`VaultPluginFormInterface` plus
`ConfigurableInterface` if the strategy needs stored credentials, and register a matching
`vault.auth_plugin.my_token` schema in your module.
