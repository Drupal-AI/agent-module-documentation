# Pwned Passwords client service

Service `pwned_passwords_client` → `Drupal\password_policy_pwned\PwnedPasswordsClient`
(implements `PwnedPasswordsClientInterface`). Constructor arg: `@http_client` (Guzzle).

## Interface
```php
interface PwnedPasswordsClientInterface {
  // Returns the number of breach occurrences for $password (0 if none / on error).
  public function getOccurrences($password);
}
```

## How the lookup works (`PwnedPasswordsClient::getOccurrences`)
```php
$hash       = strtoupper(sha1($password));
$hashPrefix = substr($hash, 0, 5);   // ONLY this is sent to HIBP
$hashSuffix = substr($hash, 5);
$url = "https://api.pwnedpasswords.com/range/$hashPrefix";
// GET with ['timeout' => 10.0]; body is "SUFFIX:COUNT" lines separated by "\n".
// Match $hashSuffix locally and return its COUNT; else 0.
```
- k-anonymity: the full password and full SHA-1 hash never leave the site — only the 5-char prefix.
- On any `GuzzleException` the error is logged and `0` is returned (fail open).

## Using it
```php
$count = \Drupal::service('pwned_passwords_client')->getOccurrences($password);
if ($count > 0) { /* password is compromised */ }
```
Prefer constructor injection of `pwned_passwords_client` in your own services.

## Replacing it
Override the `pwned_passwords_client` service (e.g. to point at a self-hosted HIBP mirror or add
caching) by providing your own class implementing `PwnedPasswordsClientInterface` via a
`*.services.yml` alias/override. The constraint plugin resolves the client through the container,
so a swap applies everywhere.

Note: a deprecated `PasswordPnwed` class (misspelling) extends `PasswordPwned` for BC and is removed
in 3.0.0 — do not reference it.
