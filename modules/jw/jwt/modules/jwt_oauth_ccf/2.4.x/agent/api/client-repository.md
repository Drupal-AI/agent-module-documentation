<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The client credential repository (`jwt_oauth_ccf.client_repository`)

Service `jwt_oauth_ccf.client_repository`, class
`Drupal\jwt_oauth_ccf\ClientCredentialRepository`, implementing
`Drupal\jwt_oauth_ccf\ClientCredentialRepositoryInterface`.

## Storage

Credentials are stored in the core **`user.data`** key-value store, module name
`jwt_oauth_ccf`, **keyed by `client_id`** (mirrors `users_jwt`'s key repository):

```php
$this->userData->set('jwt_oauth_ccf', $uid, $client_id, $record);   // save
$this->userData->get('jwt_oauth_ccf', NULL, $client_id);             // lookup by client_id
$this->userData->get('jwt_oauth_ccf', $uid);                          // all of a user's clients
```

The stored record is `['label' => ..., 'secret_hash' => ..., 'created' => <timestamp>]` —
the plaintext secret is **never** persisted, only its `password_hash()` (bcrypt, `2y`).

## The `ClientCredential` value object

`Drupal\jwt_oauth_ccf\ClientCredential` — plain public properties:

| Property | Type | Meaning |
|---|---|---|
| `uid` | `int` | Owning user ID |
| `clientId` | `string` | The public client identifier (globally unique) |
| `label` | `string` | Human-readable label |
| `secretHash` | `string` | The stored bcrypt hash — never the plaintext |
| `created` | `int` | Creation timestamp |
| `secret` | `?string` | Plaintext secret — **only set on the object returned by
  `createClient()` when the secret was auto-generated**; never populated when reading back |

## Repository methods

```php
$repo = \Drupal::service('jwt_oauth_ccf.client_repository');

// $secret = NULL auto-generates a strong secret (returned once on ->secret).
// $client_id = NULL auto-generates a 'ccf_' + 32 hex char id.
$repo->createClient(int $uid, string $label, ?string $secret = NULL, ?string $client_id = NULL): ClientCredential;

$repo->getClient(string $client_id): ?ClientCredential;   // lookup by client_id
$repo->getUserClients(int $uid): array;                    // all of a user's clients, keyed by client_id
$repo->verifySecret(ClientCredential $client, string $secret): bool;  // password_verify(), guards >512 chars
$repo->deleteClient(string $client_id): void;               // delete one credential
$repo->deleteUserClients(int $uid): void;                    // delete ALL of a user's credentials — careful
```

`createClient()` throws `\InvalidArgumentException` if a caller-supplied `$client_id` is
already in use — it never silently overwrites another account's credential.

## Example: create a known credential for uid 1 by script

```php
$repo = \Drupal::service('jwt_oauth_ccf.client_repository');
$client = $repo->createClient(1, 'my integration', NULL, 'my_known_client_id');
// $client->secret holds the plaintext ONLY right now — it is not retrievable again.
```

```bash
drush php:eval "print_r(\Drupal::service('jwt_oauth_ccf.client_repository')->getUserClients(1));"
```

## Notes

- A `client_id` resolving to more than one `uid` record (which should not normally happen)
  is treated by `getClient()` as "not found" — it requires exactly one match.
- `verifySecret()` refuses to hash/verify a secret longer than 512 characters, mirroring
  core's password-hashing DoS guard.
