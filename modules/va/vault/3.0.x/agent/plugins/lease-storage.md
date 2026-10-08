# Plugin type: VaultLeaseStorage (lease storage backends)

Vault dynamic secrets come with time-bound **leases** that must be persisted and renewed
before expiry, or the credentials stop resolving mid-flight. A `VaultLeaseStorage` plugin
decides where those leases live. This plugin type ships three implementations.

| Element | Value |
|---------|-------|
| Discovery dir | `Plugin/VaultLeaseStorage` |
| Interface | `Drupal\vault\Plugin\VaultLeaseStorageInterface` (`@api`) |
| Base class | `Drupal\vault\Plugin\VaultLeaseStorageBase` (`@api`) |
| Annotation | `@VaultLeaseStorage` (`Drupal\vault\Annotation\VaultLeaseStorage`: `id`, `label`) |
| Manager service | `plugin.manager.vault_lease_storage` (`VaultLeaseStorageManager`) |
| Alter hook | `hook_vault_vault_lease_storage_info_alter(&$definitions)` |
| Plugin cache key | `vault_vault_lease_storage_plugins` |
| Config key | `vault.settings:plugin_lease_storage` (default `state`) + `lease_storage_plugin_config` |

## Shipped plugins

| id | Class | Label | Backing store |
|----|-------|-------|---------------|
| `state` | `VaultLeaseStateStorage` | Cleartext Key/Value | Drupal expirable key-value collection `vault_lease`. Default. Its config subform renders the `cleartext-lease-storage-warning` theme element. |
| `static` | `VaultLeaseStaticStorage` | Memory Array | PHP static array — per-request only; suits sites that rarely use dynamic secrets. |
| `encrypted_state` | `VaultLeaseEncryptedStateStorage` | Encrypted Key/Value | Expirable key-value collection `vault`, payload encrypted via the **Encrypt** module (`provider = "encrypt"`). Config: `encryption_profile` (an `encryption_profile` entity id); schema `vault.lease_storage_plugin.encrypted_state`. |

## Interface (`VaultLeaseStorageInterface`)

`getLease($storage_key): mixed`, `setLease($storage_key, $lease_id, $data, int $expires, bool $renewable): void`,
`updateLeaseExpires($storage_key, int $new_expires, bool $renewable): bool`,
`revokeLease($storage_key): bool`, `renewLease($storage_key, int $increment): bool`,
`renewAllLeases(int $increment): void`, `setClient(VaultClientInterface $client): void`.

`VaultLeaseStorageBase` implements the renew/revoke/renew-all flow (calling
`PUT /v1/sys/leases/renew` and `/v1/sys/leases/revoke` through the injected
`vault.vault_client_no_lease_storage`) and leaves four abstract methods for the backend:
`create()`, `getLeaseRaw($storage_key): ?array`, `getAllLeases(): array`,
`deleteLease($storage_key): void`, plus `setLease()`.

Storage keys: a caller passes something like `"key:key_machine_id"`; the shipped plugins hash
it with `Crypt::hmacBase64($storage_key, Settings::get('hash_salt'))` and store under
`hashed::<hash>`. `getLease()` refuses keys already prefixed `hashed::`, so the raw key can be
looked up but the hashed form cannot be reverse-queried through the public method.

## Adding one

```php
namespace Drupal\my_module\Plugin\VaultLeaseStorage;

use Drupal\vault\Plugin\VaultLeaseStorageBase;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * @VaultLeaseStorage(
 *   id = "my_backend",
 *   label = "My backend",
 *   description = @Translation("Where I keep leases"),
 * )
 */
final class MyLeaseStorage extends VaultLeaseStorageBase {

  public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition): self {
    try { $client = $container->get('vault.vault_client_no_lease_storage'); }
    catch (\Exception $e) { $client = NULL; }   // no client during initial setup
    return new self($configuration, $plugin_id, $plugin_definition, $client, $container->get('logger.channel.vault'));
  }

  protected function getLeaseRaw(string $storage_key): ?array { /* return ['lease_id'=>…, 'data'=>…, 'renewable'=>…] or NULL */ }
  protected function getAllLeases(): array { /* [key => data, …] */ }
  protected function deleteLease(string $storage_key): void { /* … */ }
  public function setLease(string $storage_key, string $lease_id, mixed $data, int $expires, bool $renewable): void { /* … */ }

}
```

Implement `PluginFormInterface` + `ConfigurableInterface` if the backend needs stored settings,
and register a `vault.lease_storage_plugin.my_backend` schema mapping.
