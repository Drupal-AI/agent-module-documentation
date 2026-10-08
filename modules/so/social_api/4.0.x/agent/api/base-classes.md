<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Support classes

## `AuthManager\OAuth2Manager` (abstract)

Constructor: `(ImmutableConfig $settings, LoggerChannelFactoryInterface $logger_factory, ?Request $request = NULL)`.

Implemented for you: `setClient()/getClient()`, `setAccessToken()/getAccessToken()`
(all fluent setters return `static`).
Left abstract by `OAuth2ManagerInterface`: `authenticate()`, `getAuthorizationUrl()`,
`getState()`, `getUserInfo()`.

Protected state: `$client` (usually a `League\OAuth2\Client\Provider\AbstractProvider`),
`$accessToken`, `$settings`, `$loggerFactory`, `$request`, `$user`.

Implementer modules (Social Auth, Social Post) subclass this per network.

## `SocialApiDataHandler` (abstract)

Thin session wrapper, prefixed per implementer:

```php
$handler->setSessionPrefix('social_auth_acme');   // stores prefix as "social_auth_acme_"
$handler->set('oauth2state', $state);             // session key social_auth_acme_oauth2state
$handler->get('oauth2state');
$handler->getSessionPrefix();
$handler->getSession();
```

Constructor takes a `Symfony\Component\HttpFoundation\Session\SessionInterface`.

## `User\UserAuthenticator` (abstract) + `User\UserManagerInterface`

`UserAuthenticator::__construct(AccountProxyInterface $current_user, MessengerInterface $messenger, LoggerChannelFactoryInterface $logger_factory, UserManagerInterface $user_manager, SocialApiDataHandler $data_handler)`.

| method | purpose |
|---|---|
| `setPluginId($id)` / `getPluginId()` | also forwarded to the user manager; used for per-implementer logs and messages |
| `setSessionKeysToNullify(array $keys)` | keys to clear if login fails |
| `nullifySessionKeys()` | clears them through the data handler (prefix applied) |
| `currentUser()` | the `AccountProxyInterface` |

`UserManagerInterface`: `getPluginId()`, `setPluginId()`,
`getDrupalUserId(string $provider_user_id): int|false`.

## `Entity\SocialApi` — encrypted token storage

Base class for content entities that record a provider account. `create()` encrypts a
`token` value automatically; `setToken()` / `getToken()` encrypt and decrypt.

* Cipher: **AES-256-CBC** (`openssl_encrypt`/`openssl_decrypt`), random IV per token.
* Key: `Settings::getHashSalt()`, base64-decoded — i.e. the site's `hash_salt` from
  `settings.php`. **Changing the hash salt makes every stored token undecryptable.**
* Stored value: `base64("<encrypted>::<iv>")`.
* `getUserId(): int` returns `user_id.target_id`.

Requires `ext-openssl` (declared in `composer.json`).

## `Utility\SocialApiImplementerInstaller`

One static helper for an implementer's `hook_requirements()`:

```php
$requirements += SocialApiImplementerInstaller::checkLibrary(
  'social_auth_acme',            // machine name (also the requirements array key)
  'Social Auth Acme',            // human name
  'league/oauth2-acme',          // Composer package
  2.0,                           // min version
  3.0                            // max version
);
```

It uses `Composer\InstalledVersions::getVersion()`; a missing package
(`\OutOfBoundsException`) or an out-of-range version yields a `REQUIREMENT_ERROR` entry.

## `SocialApiException`

`\Exception` subclass thrown by `NetworkBase::init()` for bad settings handlers and, by
convention, by `initSdk()` implementations.

## `Controller\SocialApiController`

`integrations(string $type)` builds a `#theme: table` with columns *Module* / *Social
Network*, listing every Network plugin definition whose `type` matches (`social_auth`,
`social_post`, `social_widgets`), and the empty text *"There are no social integrations
enabled."*

Social API declares **no route** for it — implementer modules point their own routes at
`\Drupal\social_api\Controller\SocialApiController::integrations` with a `type` default. The
only route Social API itself ships is `social_api.admin_config`.

Note the column bug documented in [../plugins/network.md](../plugins/network.md): the
controller reads `$network['social_network']` while the annotation defines `socialNetwork`.

## `social_api.module`

Empty apart from a `@TODO` for help text. Social API implements no hooks and invites none
(there is no `social_api.api.php`); the only extension point is
`hook_social_api_network_info_alter()`, which comes from the plugin manager's `alterInfo()`.
