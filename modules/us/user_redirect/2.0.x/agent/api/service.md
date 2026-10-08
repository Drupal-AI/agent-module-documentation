# User Redirect — how the redirect works

## Entry points (module hooks)

`user_redirect.module` implements:

```php
function user_redirect_user_login(AccountInterface $account) {
  \Drupal::service('user_redirect.service')->setLoginRedirection($account);
}
function user_redirect_user_logout(AccountInterface $account) {
  \Drupal::service('user_redirect.service')->setLogoutRedirection($account);
}
```

So the logic fires on every core login/logout, for the account being authenticated.

## Service: `user_redirect.service`

Class `Drupal\user_redirect\UserRedirect` implements `UserRedirectInterface`. Constructor
args: `request_stack`, `config.factory`, `current_user`, `path.current`,
`path_alias.manager`, `path.matcher`. Public methods:

| Method | Purpose |
|---|---|
| `setLoginRedirection(?AccountInterface $account)` | Apply the `login` redirect (respecting the ignore list). |
| `setLogoutRedirection(?AccountInterface $account)` | Apply the `logout` redirect (respecting the ignore list). |

Interface constants: `UserRedirectInterface::KEY_LOGIN = 'login'`,
`KEY_LOGOUT = 'logout'`.

## Algorithm

1. **Ignore check** — if `ignore` is set *and* `ignore_for.<login|logout>` is truthy, the
   current path's alias is matched against each ignore pattern with `path.matcher`. On a
   match the method returns early (no redirect). This is why the default `/user/reset/*`
   keeps one-time-login links working.
2. **Role priority** — `prepareDestination()` takes `current_user->getRoles()` and
   `array_reverse()`s it, then loops. The **first** role (in reversed order) that has a
   non-empty `redirect_url` in the relevant config map wins; the loop then stops. Effectively
   the last role in the account's role array is highest priority.
3. **Apply**:
   - **External URL** (`UrlHelper::isExternal()`): a `TrustedRedirectResponse($url)` is
     created and `->send()` immediately.
   - **Internal URL**: builds `Url::fromUserInput($redirect_url)` and sets the request's
     `destination` query parameter to it, so Drupal's normal post-login redirect handling
     navigates there.

## Notes / gotchas

- Config is read once in the constructor (`config.factory->get('user_redirect.settings')`).
- If `user_redirect.settings` was never saved, all lookups return empty and no redirect
  occurs — the module is inert until configured.
- "Priority" in the UI is the weight column; because roles are reversed, arrange weights so
  the intended winning role sorts last in the account's role list.
- There is no public API beyond the two methods above; to change behaviour you would
  decorate or replace the `user_redirect.service`.
