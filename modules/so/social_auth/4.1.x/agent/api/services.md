<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services (the API a provider/controller calls)

Defined in `social_auth.services.yml`. These orchestrate the login flow; provider controllers
(extending `OAuth2ControllerBase`) call them after the OAuth handshake.

## `social_auth.user_authenticator` — `UserAuthenticator`

The high-level entry point. Key methods:

- `setDestination(string $destination)` — where to send the user after auth.
- `authenticateUser(SocialAuthUserInterface $user): RedirectResponse` — the main flow: finds
  an existing linked account, or an account by email, or creates one (respecting
  `user_allowed`, `disable_admin_login`, `disabled_roles`), then logs in; returns a redirect.
- `authenticateWithProvider(int $user_id): bool` — log in a user already linked to this
  provider id.
- `authenticateWithEmail(string $email, string $provider_user_id, string $token, ?array $data): bool`
  — match an existing Drupal user by email and link this provider identity.
- `authenticateExistingUser(UserInterface $drupal_user)` / `authenticateNewUser(?UserInterface)`
  — lower-level branches.
- `associateNewProvider(string $provider_user_id, string $token, ?array $data)` — link a
  provider to the current (already logged-in) user.
- `checkProviderIsAssociated(string $provider_user_id): int|false` — returns the Drupal uid
  linked to a provider identity, or FALSE.
- `loginUser(UserInterface $drupal_user): bool` — finalize the Drupal login.
- `dispatchAuthenticationError(?string $error)` / `dispatchBeforeRedirect(?string $destination)`
  — fire the corresponding events (see [../hooks/events.md](../hooks/events.md)).

## `social_auth.user_manager` — `UserManager`

Creates/loads Drupal users and stores the provider link:

- `createNewUser(SocialAuthUserInterface $user): ?UserInterface`
- `createUser(SocialAuthUserInterface $user): User|false`
- `addUserRecord(int $user_id, string $provider_user_id, string $token, ?array $user_data): bool`
  — persists the `social_auth` profile entity linking uid ↔ provider identity.
- `loadUserByProperty(string $field, string $value): User|false`
- `downloadProfilePic(string $picture_url, string $id, ?string $directory = NULL): FileInterface|false`

## `social_auth.data_handler` — `SocialAuthDataHandler`

Thin wrapper over the session (`@session`) used to stash OAuth state/tokens during the
redirect↔callback handshake. `setSessionPrefix($network_id)` namespaces the keys;
`get('access_token')` / `set(...)` read/write.

## `paramconverter.network` — `NetworkConverter`

Upcasts the `{network}` route slug into a Social API Network plugin instance
(`@plugin.network.manager`), so controllers/forms receive a `NetworkInterface`.

## The stored identity: `social_auth` entity

A content entity (`base_table` `social_auth`) keyed by `user_id`, `plugin_id`,
`provider_user_id` (see `src/Entity/SocialAuth.php`). `_social_auth_get_accounts_by_uid()` and
`social_auth_user_delete()` in `social_auth.module` show how it is queried/cleaned up.
