<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: key provider plugin + secrets syncer

## Services

| Service id | Class | Arguments | Purpose |
|---|---|---|---|
| `pantheon_secrets.secrets_syncer` | `Drupal\pantheon_secrets\SecretsSyncer\SecretsSyncer` | `@entity_type.manager`, `@transliteration` | Bulk-creates Key entities from Pantheon secrets |
| `pantheon_secrets.commands` | `…\Commands\PantheonSecretsCommands` | `@pantheon_secrets.secrets_syncer` | Drush command (tag `drush.command`) |

`SecretsSyncerInterface::sync(): array` returns the ids of the keys it created (empty array
when there was nothing new).

```php
$created = \Drupal::service('pantheon_secrets.secrets_syncer')->sync();
```

Machine-name derivation: `transliterate(strtolower($secretName))` then
`preg_replace('@[^a-z0-9_.]+@', '_', …)`.

Skip rule (`secretInUse()`): a secret is skipped when **any** existing key whose
`key_provider` is `pantheon` already has that `secret_name`.

## The provider plugin

`Drupal\pantheon_secrets\Plugin\KeyProvider\PantheonSecretKeyProvider`

```php
@KeyProvider(
  id = "pantheon",
  label = @Translation("Pantheon"),
  storage_method = "pantheon",
  key_value = { "accepted" = FALSE, "required" = FALSE }
)
```

Implements `KeyPluginFormInterface` and `KeyPluginDeleteFormInterface`.

- `defaultConfiguration()` → `['secret_name' => '', 'base64_encoded' => FALSE]`.
- The client is built in the constructor:
  `CustomerSecrets::create()->getClient()` (`PantheonSystems\CustomerSecrets\CustomerSecretsClientInterface`).
- `buildConfigurationForm()` populates the **Secret name** select from
  `$client->getSecrets()` (keyed by `getName()`), and shows a disabled masked preview of
  `$client->getSecret($name)->getValue()` (all but the last 4/2/1 chars replaced with `*`).
- `validateConfigurationForm()` errors with *"The secret does not exist or it is empty."*
  when `getSecret()` returns nothing.
- `getKeyValue(KeyInterface $key)` → `$client->getSecret($this->configuration['secret_name'])->getValue()`,
  `base64_decode()`-ed when `base64_encoded` is TRUE; `NULL` if the secret is missing.
- `buildDeleteForm()` only prints a warning: deleting the Key does **not** delete the secret.

There is no caching layer — every `getKeyValue()` call hits the SDK client, which is where
any per-request caching lives.

## Extending

There is no plugin type, no hook, and no event. To customise behaviour, either implement
your own `@KeyProvider` plugin (Key module's plugin type) or decorate
`pantheon_secrets.secrets_syncer` and reimplement `sync()`.
