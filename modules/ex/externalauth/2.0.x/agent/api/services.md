# externalauth API — services

Both services are autowired; type-hint the interfaces.

## `externalauth.externalauth` — `ExternalAuthInterface`
The high-level flow API for an auth module that has already verified an external identity.
- `load(string $authname, string $provider)` — return the mapped user (or FALSE).
- `login(string $authname, string $provider)` — log in the mapped user; FALSE if none.
- `register(string $authname, string $provider, array $account_data = [], $authmap_data = NULL)`
  — create a new Drupal user for the external identity and store the mapping.
- `loginRegister(string $authname, string $provider, array $account_data = [], $authmap_data = NULL)`
  — log in if mapped, otherwise register then log in. The usual entry point.
- `linkExistingAccount(string $authname, string $provider, UserInterface $account, $authmap_data = NULL)`
  — attach an external identity to an already-existing Drupal account.
- `userLoginFinalize(UserInterface $account, string $authname, string $provider): UserInterface`
  — finalize the session for an account you resolved yourself.

## `externalauth.authmap` — `AuthmapInterface`
Direct access to the identity-mapping store.
- `save(UserInterface $account, string $provider, string $authname, $data = NULL)`
- `get(int $uid, string $provider)` / `getAuthData(int $uid, string $provider)`
- `getAll(int $uid): array` — all provider mappings for a user.
- `getUid(string $authname, string $provider)` — reverse lookup to a Drupal uid.
- `delete(int $uid, ?string $provider = NULL)` — remove one or all of a user's mappings.
- `deleteProvider(string $provider)` — remove every mapping for a provider.

Example:
```php
$externalAuth->loginRegister($authname, 'my_sso', [
  'name' => $authname,
  'mail' => $email,
]);
```
