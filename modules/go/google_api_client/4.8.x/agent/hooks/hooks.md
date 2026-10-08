<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks (`google_api_client.api.php`)

Four hooks let other modules customize authentication and react to Google responses.

## `hook_google_api_client_account_scopes_alter(&$scopes, $google_api_client_id)`

Add/remove OAuth scopes just before authentication for a given account id. `$scopes` is the
service→scope-constants array.

```php
function mymodule_google_api_client_account_scopes_alter(&$scopes, $google_api_client_id) {
  if ($google_api_client_id == 1) {
    unset($scopes['gmail']['GMAIL_METADATA']);
  }
}
```

## `hook_google_api_client_account_state_alter(&$state, $google_api_client)`

Alter the OAuth `state` before redirecting to Google. Common uses: change the post-auth
`destination`, add/remove a `src` source tag (so you can recognize the response in your own
response handler), or opt out of persisting the authentication. `$google_api_client` is the
account entity — check `getId()` **and** `getEntityTypeId()` (other modules, e.g. gauth_user,
share the interface and may reuse ids).

## `hook_google_api_client_authenticate_account_access($id, $type, AccountInterface $user_account)`

Gate who may authenticate an account. Return `AccessResult::allowed()`, `::forbidden()`, or
`::neutral()`. Lets you restrict the Authenticate link to specific users/roles.

```php
function mymodule_google_api_client_authenticate_account_access($id, $type, $user_account) {
  if ($id == 1 && $type == 'google_api_client') {
    return in_array('google_user', $user_account->getRoles())
      ? \Drupal\Core\Access\AccessResult::allowed()
      : \Drupal\Core\Access\AccessResult::forbidden();
  }
  return \Drupal\Core\Access\AccessResult::neutral();
}
```

## `hook_google_api_client_google_response()`

Fires when a Google response is received (beyond plain authentication). Response data is in the
URL, so read `\Drupal::request()` / the `state` query param; check your `src` tag (set via the
state alter hook) to only handle responses your module initiated. Used to implement flows like
"Login with Google" or custom API callbacks.
