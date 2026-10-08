# Enable the password grant & request a token

There is **no module settings page**. You enable the grant per **Consumer** and then request a
token from Simple OAuth's token endpoint.

## 1. Enable "Password" on a Consumer

Consumers are `consumer` entities (from the `consumers` module, a Simple OAuth dependency). Each
has a multi-value `grant_types` field (`list_string`). Enabling the module makes `password` an
available value.

UI: *Configuration → Web services → Consumers* → edit/add a consumer → tick **Password** under
grant types → set/confirm **Default scopes** (the module moves the scopes selector into a
"Default scopes" details section) → Save.

Code / scripting:

```php
use Drupal\consumers\Entity\Consumer;
$consumer = Consumer::create([
  'label' => 'My app',
  'client_id' => 'my_app',
  'secret' => 'CHANGE_ME',          // hashed on save
  'grant_types' => ['password', 'refresh_token'],
  'user_id' => 1,
]);
$consumer->save();
```

To add the grant to an existing consumer, append `'password'` to its `grant_types` field and save.

Read it back:

```php
$c = \Drupal::entityTypeManager()->getStorage('consumer')->load($id);
$grants = array_column($c->get('grant_types')->getValue(), 'value');  // contains 'password'
```

## 2. Request an access token

`POST` to Simple OAuth's token endpoint (default `/oauth/token`), form-encoded or JSON:

```
POST /oauth/token
grant_type=password
client_id=my_app
client_secret=CHANGE_ME
username=<drupal username OR email>
password=<drupal password>
scope=<optional space-separated scopes>
```

Response: a JSON body with `access_token`, `token_type: Bearer`, `expires_in`, and (when the
consumer allows it) `refresh_token`. The refresh token TTL comes from the consumer's
`refresh_token_expiration` field (defaults to 1209600 seconds / 14 days).

## Notes

- `username` accepts the Drupal **username or the account email** (email is matched first when it
  contains `@`).
- Only **active** accounts (`status = 1`) can obtain a token.
- Repeated failures are flood-limited per IP and per user (see
  [api/user-repository.md](../api/user-repository.md)); a blocked request returns HTTP 403 with
  error `flood_ip_blocked` or `flood_user_blocked`.
