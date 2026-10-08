# Services API

Declared in `social_post.services.yml`. These are the runtime helpers an implementer module
uses to persist and look up connections.

| Service id | Class | Constructor args |
| --- | --- | --- |
| `social_post.user_authenticator` | `User\UserAuthenticator` | `@current_user`, `@messenger`, `@logger.factory`, `@social_post.user_manager`, `@social_post.data_handler` |
| `social_post.user_manager` | `User\UserManager` | `@entity_type.manager`, `@messenger`, `@logger.factory`, `@current_user` |
| `social_post.data_handler` | `DataHandler` | `@session` |

## `social_post.user_authenticator` — `User\UserAuthenticator`

Extends `social_api\User\UserAuthenticator`. The front-door helper a controller calls during the
OAuth flow. Call `setPluginId($plugin_id)` first (the `OAuth2ControllerBase` constructor does this
automatically).

| Method | Signature | Behavior |
| --- | --- | --- |
| `addUserRecord` | `addUserRecord($name, $provider_user_id, $url, $token): bool` | Creates a `social_post` entity for the **current** Drupal user (delegates to the user manager, passing `currentUser()->id()`). Returns `false` if a record for that `provider_user_id` already exists. |
| `getDrupalUserId` | `getDrupalUserId($provider_user_id): int\|false` | Looks up the Drupal user id linked to a provider user id. |
| `setPluginId` / `currentUser` / `nullifySessionKeys` | inherited from Social API | Set the active plugin id, get the current-user proxy, clear OAuth session keys after a failed callback. |

```php
/** @var \Drupal\social_post\User\UserAuthenticator $auth */
$auth = \Drupal::service('social_post.user_authenticator');
$auth->setPluginId('social_post_twitter');
$auth->addUserRecord($screenName, $providerUserId, $profileUrl, $accessToken);
```

## `social_post.user_manager` — `User\UserManager`

Extends `social_api\User\UserManager`; constructed with entity type `social_post`. Owns all
`social_post` entity CRUD.

| Method | Signature | Behavior |
| --- | --- | --- |
| `addUserRecord` | `addUserRecord($name, $user_id, $provider_user_id, $url, $token, $additional_data = ''): bool` | Guards on `getDrupalUserId()` (returns `false` if the provider id is already stored), then `SocialPost::create([...])->save()`. Sets a `link` field only when `$url` is non-empty. Logs + shows an error message on exception. |
| `getAccounts` | `getAccounts($plugin_id, $user_id = NULL): SocialPost[]` | `loadByProperties(['user_id' => $user_id ?? currentUser, 'plugin_id' => $plugin_id])`. |
| `getAllAccounts` | `getAllAccounts($plugin_id): SocialPost[]` | All accounts for a provider, across users (`loadByProperties(['plugin_id' => $plugin_id])`). |
| `updateToken` | `updateToken($plugin_id, $provider_user_id, $token): bool` | Loads the record by `plugin_id` + `provider_user_id`, calls `setToken($token)->save()`. Returns `false` if not found or on `EntityStorageException`. |
| `getDrupalUserId` | inherited | Maps a `provider_user_id` to a Drupal uid. |

## `social_post.data_handler` — `DataHandler`

Empty subclass of `social_api\SocialApiDataHandler`, constructed with `@session`. Reads/writes
transient values (notably the OAuth `state`) to the session via `set($key, $value)` /
`get($key)`. Used by the connect flow to persist `oauth2state` between the redirect and the
callback (see [connect-flow.md](connect-flow.md)).
