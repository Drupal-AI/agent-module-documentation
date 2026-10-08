<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GitLab OAuth login flow

File: `src/Controller/LoginController.php` — `LoginController extends ControllerBase`.
Route: `externalauth_gitlab.login_controller_login`, path `/user/login/gitlab`, requirement
`_user_is_logged_in: FALSE` (the login entry point is for anonymous visitors). A single method, `login(Request)`,
serves both legs of the OAuth 2.0 authorization-code flow.

## Services injected (`create()` / constructor)

- `externalauth.externalauth` → `ExternalAuthInterface $externalauth`
- `tempstore.private` → `PrivateTempStore` collection `externalauth_gitlab` (`$tempstore`)
- `entity_type.manager` → `$entityTypeManager`
- `config.factory` → `$configFactory`
- `page_cache_kill_switch` → `$pageCacheKillSwitch`

## `login(Request $request)`

1. Loads `externalauth_gitlab.settings`; throws `\InvalidArgumentException` if `client_id`, `client_secret` or
   `domain` is empty.
2. Calls `$this->pageCacheKillSwitch->trigger()` so the redirect response is not page-cached.
3. Builds `new Omines\OAuth2\Client\Provider\Gitlab([...])` with `clientId`, `clientSecret`, `domain`, and
   `redirectUri` set to the current route absolute URL (`Url::fromRoute('<current>', …, ['absolute' => TRUE])`).
4. Reads `code` and `state` from the query string to decide which leg it is on.
   - **No `code`** (first leg): builds the authorization URL via `$provider->getAuthorizationUrl()`, keeps the
     provider `state` in the private tempstore under the `oauth2state` key, and returns a
     `TrustedRedirectResponse` (302) to GitLab.
   - **`code` present** (callback leg): the module completes the OAuth exchange and signs the user in.
5. Exchanges the code for a token: `$provider->getAccessToken('authorization_code', ['code' => $code])`.
6. Loads the GitLab profile `$provider->getResourceOwner($token)` and calls `doLogin()`; on success shows a status
   message and redirects to `<front>`. Any exception is caught, surfaced as an error message, and also redirects to
   `<front>`.

## `doLogin(ResourceOwnerInterface $gitlab_user, $getToken)` (private)

Identity resolution through External Authentication, in order:

1. `$this->externalauth->login($gitlab_user->getId(), 'oauth2_gitlab')` — if a link already exists for this GitLab
   user id under the `oauth2_gitlab` provider, that Drupal account is logged in and returned.
2. Otherwise it loads a Drupal user whose `mail` equals the GitLab account email
   (`$gitlab_user->toArray()['email']`); if one exists it links the GitLab id to that account with
   `externalauth->linkExistingAccount($id, 'oauth2_gitlab', $account)` and logs in.
3. If no matching Drupal account exists, it throws `\RuntimeException('Could not find gitlab user! Please ask your
   admin for help!')` — **the module never registers new users** (see `readme.md`).

The `oauth2_gitlab` string is the externalauth provider name used for both linking and lookup. Roles/permissions
come entirely from the resolved local account.
