# OAuth connect/callback flow (`OAuth2ControllerBase`)

`src/Controller/OAuth2ControllerBase.php` scaffolds the two-step OAuth flow an implementer's
controller extends. An implementer subclass wires two routes (a "redirect to provider" action and
a callback action) and, in the callback, persists the token with
`social_post.user_authenticator`→`addUserRecord()`.

## Constructor dependencies

`($module, $plugin_id, NetworkManager $network_manager, UserAuthenticator $user_authenticator,
OAuth2ManagerInterface $provider_manager, RequestStack $request, DataHandler $data_handler,
RendererInterface $renderer, SocialPostListBuilder $list_builder)`. It calls
`userAuthenticator->setPluginId($plugin_id)` so later `addUserRecord()` calls target the right
provider. It extends `ControllerBase`, which exposes `buildList($provider)` for the connected-
account listing.

## `redirectToProvider()`

1. `networkManager->createInstance($pluginId)->getSdk()` → the League OAuth2 client (or `false`).
   If `false`, adds an error message and redirects to the current user's edit form.
2. `providerManager->setClient($client)`; `$auth_url = providerManager->getAuthorizationUrl()`.
3. `$state = providerManager->getState()` then `dataHandler->set('oauth2state', $state)` — the
   OAuth `state` value is stored in the session before leaving the site, to be matched on return.
4. Returns a `TrustedRedirectResponse($auth_url)`. The whole body runs inside
   `renderer->executeInRenderContext()` so cacheable metadata from URL generation is bubbled onto
   the response (see social_auth issue 3033444).

## `processCallback()`

Returns the provider's resource-owner profile (`League\...\GenericResourceOwner`) on success, or
`null`:

1. Re-obtains the SDK client; `null` + error message if unavailable.
2. Reads the stored `oauth2state` from `dataHandler` and the returned `state` from
   `request->query->get('state')`.
3. **State check:** `if (empty($retrievedState) || ($retrievedState !== $state))` →
   `userAuthenticator->nullifySessionKeys()`, error `"Login failed. Invalid OAuth2 state."`,
   returns `null`. (Strict `!==` comparison.)
4. `providerManager->setClient($client)->authenticate()` then
   `providerManager->getUserInfo()`; `null` + error if no profile.
5. Returns the profile. Exceptions are caught, logged via `getLogger($pluginId)->error()`, and
   surfaced as a generic error message.

## `checkAuthError($key = 'error')`

Helper for the callback: if the provider sent back `?error=…`, adds an error message and returns a
redirect to the current user's edit form; otherwise returns `null`. Implementers typically call
this at the top of their callback action before `processCallback()`.

## Typical implementer callback

```php
public function callback() {
  if ($redirect = $this->checkAuthError()) {
    return $redirect;
  }
  $profile = $this->processCallback();
  if ($profile) {
    $token = $this->providerManager->getAccessToken();
    $this->userAuthenticator->addUserRecord(
      $profile->getName(), $profile->getId(), $profile->getUrl(), json_encode($token)
    );
  }
  return $this->redirect('entity.user.edit_form', [
    'user' => $this->userAuthenticator->currentUser()->id(),
  ]);
}
```
