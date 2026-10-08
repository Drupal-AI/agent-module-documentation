<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: KeyPair service, key selection, extending

## `key_asymmetric.key_pair` service

Class `Drupal\key_asymmetric\KeyPair` (interface `KeyPairInterface`). One public method:

```php
public function getKeyProperties(string $key_value, ?string $password = NULL): ?array;
```

Given a raw key string (PEM or base64, with or without armor), it uses phpseclib to recognise the
key and returns its properties, e.g. `type` (`private`/`public`), `format`, `algo` (e.g. `RSA`),
`key_size`, `hash_algo`, and for certificates the cert subject/issuer/validity. Returns metadata
without needing a Key entity. `$password` validates a password-protected private key.

```php
$props = \Drupal::service('key_asymmetric.key_pair')->getKeyProperties($pem);
// ['type' => 'private', 'algo' => 'RSA', 'key_size' => 2048, ...]
```

The deprecated procedural wrapper `key_asymmetric_get_key_properties($key_value, $password)` calls
this service (removed in 2.0.0 — use the service).

## Selecting stored keys by type

Use the Key module's repository, filtered by these type ids:

```php
$repo = \Drupal::service('key.repository');
$publics = $repo->getKeysByType('asymmetric_public');   // Key[] of public keys/certs
foreach ($publics as $key) {
  $settings = $key->getKeyType()->getConfiguration();   // key_type_settings
  if (($settings['format'] ?? NULL) === 'PKCS8' && !empty($settings['private_key'])) {
    // suitable key that also has a linked private key
  }
}
```

Metadata can theoretically be tampered with; for absolute certainty re-check the raw value with
`getKeyProperties()` on `$key->getKeyValue()`.

## Extending the key types

Subclass `AsymmetricPrivateKeyType` / `AsymmetricPublicKeyType` to enforce your own rules — e.g.
remove the `skip_validation` checkbox and override `validateKeyValue()` to `setErrorByName()` when
a key doesn't meet required format/size — then register your own `@KeyType` plugin and use it.
