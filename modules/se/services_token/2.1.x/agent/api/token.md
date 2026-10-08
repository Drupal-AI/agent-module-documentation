<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# services_token — token API & endpoints

## Token format
`hex(uid).hex(expire).hmacBase64(uid + serialize(properties) + expire, key)` — SHA-256 HMAC. Verified by recomputing and `hash_equals`, then `requestTime < expire`.

## Minting a token
- REST: `POST /services_token/generate` (resource id `services_token:generate`) → 201 with `{expires, token}`.
- Services ServiceDefinition plugin id `services_token_generate`, path `services_token/generate`, POST.
- Both require permission `generate services token`.

## Authenticating a request
Send the token as the **HTTP Basic username**, password empty:
```
Authorization: Basic base64(<token>:)
```
`TokenAuth::applies()` triggers when a Basic username is present and the password is empty.

## Programmatic use
```php
$record = \Drupal::service('services_token.token_generator')->generate($uid, $expire, $realm);
$valid  = \Drupal::service('services_token.security_key')->verify($token, $realm);
```

## settings.php knobs
```php
$settings['services_token_private_key'] = '...';   // HMAC key (else private key + hash salt)
$settings['services_token_ttl'] = 2592000;         // token lifetime, seconds
$settings['services_token_realm'] = 'My API';      // realm string
```

## Extension hooks
`hook_services_token_properties()` / `_alter` (data folded into the signature — default adds name, password hash, status), `hook_services_token_expires_alter()`, `hook_services_token_create_alter()`.
