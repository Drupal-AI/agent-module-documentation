<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AppRole authentication

`vault_auth_approle` adds the `approle` choice to the **base Vault module's** authentication plugin
selector. It has no settings page of its own; you pick and configure it on the Vault module's config
form (`vault.settings`, route `vault.settings`), section "Authentication".

## Plugin

| Item | Value |
| --- | --- |
| Plugin id | `approle` |
| Class | `Drupal\vault_auth_approle\Plugin\VaultAuth\AppRole` (`src/Plugin/VaultAuth/AppRole.php`) |
| Annotation | `@VaultAuth(id = "approle", label = "AppRole")` |
| Base class | `Drupal\vault\Plugin\VaultAuthBase` (implements `VaultAuthInterface`) |
| Manager | `plugin.manager.vault_auth` → `Drupal\vault\Plugin\VaultAuthManager` |
| Strategy returned | `Vault\AuthenticationStrategies\AppRoleAuthenticationStrategy` (from `csharpru/vault-php`) |

## Config keys

Schema `vault.auth_plugin.approle` (`config/schema/vault_auth_approle.schema.yml`):

| Key | Type | Form widget | Meaning |
| --- | --- | --- | --- |
| `role_id` | string | `textfield` "AppRole ID" | The AppRole RoleID — the (non-secret) identifier of the application role. |
| `secret_key_id` | string | `key_select` "AppRole Secret", filtered to `type: authentication` | Machine name of a **Key** entity that holds the AppRole SecretID. The SecretID itself is **not** stored here. |

`defaultConfiguration()` sets both to `NULL`. These two keys are stored by the base module inside the
`vault.settings` config object under `auth_plugin_config` (active only while `plugin_auth: approle`);
see the base module schema `vault.settings` → `auth_plugin_config: vault.auth_plugin.[%parent.plugin_auth]`.

## Where the SecretID lives

Only the **Key machine name** is written to config (`secret_key_id`). The actual SecretID is held by
the chosen Key entity and comes from whatever provider that Key uses (environment variable, file,
config, etc.), so the credential need not be part of the site's exported configuration. The plugin
resolves it at construction time:

```php
// AppRole::__construct(), abridged.
$key_entity = $key_repository->getKey($configuration['secret_key_id']);
if ($key_entity === NULL) {
  throw new \Drupal\Component\Plugin\Exception\PluginException('Secret Key does not exist');
}
$this->setSecretId($key_entity->getKeyValue());
```

If either `role_id` or `secret_key_id` is empty the plugin instantiates with empty credentials (so the
config form can be shown before it is filled in) rather than resolving a Key.

## Set it without the UI

The plugin config is nested in the base module's `vault.settings`. Select the plugin and provide both
values (the Key must already exist — create it with the Key module, e.g. an `env`-provider Key):

```bash
drush config:set vault.settings plugin_auth approle -y
drush config:set vault.settings auth_plugin_config.role_id  '<role-id-uuid>' -y
drush config:set vault.settings auth_plugin_config.secret_key_id 'my_approle_secret_key' -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('vault.settings')
  ->set('plugin_auth', 'approle')
  ->set('auth_plugin_config', [
    'role_id' => '<role-id-uuid>',
    'secret_key_id' => 'my_approle_secret_key', // machine name of a Key entity
  ])
  ->save();
```

## Runtime login flow

Authentication is driven by the base module, not by this plugin:

1. `Drupal\vault\VaultClientFactory::createInstance()` reads `plugin_auth` / `auth_plugin_config`
   from `vault.settings` (via `Drupal\vault\VaultConfig`) and calls
   `plugin.manager.vault_auth->createInstance('approle', $auth_plugin_config)`.
2. It calls `$plugin->getAuthenticationStrategy()`, which returns
   `new AppRoleAuthenticationStrategy($roleId, $secretId)`.
3. The factory does `$client->setAuthenticationStrategy($strategy)->authenticate()`. The
   `csharpru/vault-php` client performs the AppRole login request (Vault's `auth/approle/login`
   endpoint) using the injected PSR HTTP client — which is Drupal core's `http_client` (Guzzle) — and
   returns a Vault token used for subsequent secret reads.
4. On any exception the factory logs `"[<ExceptionClass>] <message>"` to the `vault` logger channel
   and rethrows; this plugin does not log the RoleID, SecretID or token.

## Requirements to make it work

- The base `vault` module configured with a reachable `base_url` and a lease storage plugin
  (`plugin_lease_storage`, default `state`) so the issued token/leases can be tracked.
- The `key` module, plus a Key entity (type `authentication`) whose value is the Vault AppRole
  SecretID; its machine name goes in `secret_key_id`.
- A Vault server with the AppRole auth method enabled and a role whose RoleID/SecretID you supply.
