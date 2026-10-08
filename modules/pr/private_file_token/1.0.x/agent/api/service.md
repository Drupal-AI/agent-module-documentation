# API — the `private_file_token` service

Service id `private_file_token` → `Drupal\private_file_token\Access\PrivateFileTokenGenerator`
(defined in `private_file_token.services.yml`; args `@private_key`,
`@private_file_token.settings`, `@datetime.time`). Use it to sign or verify a private-file path
in custom code.

```php
/** @var \Drupal\private_file_token\Access\PrivateFileTokenGenerator $gen */
$gen = \Drupal::service('private_file_token');

$path      = '/system/files/styles/thumbnail/private/report.pdf'; // base-path-stripped path
$timestamp = \Drupal::time()->getRequestTime();

// Mint.
$token = $gen->get($path, $timestamp);           // 43-char URL-safe HMAC string
$url   = $path . '?' . http_build_query(['token' => $token, 'timestamp' => $timestamp]);

// Verify (e.g. in a custom controller/access check).
$ok = $gen->validate($token, $path, $timestamp); // bool
```

### Methods

- `get(string $uri, int $timestamp): string` — `Crypt::hmacBase64($uri . $timestamp,
  $privateKey->get() . Settings::getHashSalt())`. Deterministic for a given path+timestamp on a
  given site; changes if the site private key or hash salt changes.
- `validate(string $token, string $uri, int $timestamp): bool` — `FALSE` if
  `now - timestamp > expiration_time`; otherwise `hash_equals(get($uri,$timestamp), $token)`.

### Notes for callers

- `$uri` must be the exact path used at request time — the module strips the base path so it
  matches `Request::getPathInfo()`. Sign the same string you expect the browser to hit.
- In normal use you don't call this at all: `hook_file_url_alter` signs URLs automatically and
  the file-access hook validates them. Call the service directly only for custom URL shapes.
- The token embeds no user identity — treat any signed URL as a bearer credential valid until
  it expires.
