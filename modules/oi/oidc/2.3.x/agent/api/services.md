<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services, events, hooks, user data

## Services (`oidc.services.yml`)

| Service id | Class | Use |
| --- | --- | --- |
| `oidc.openid_connect_session` | `OpenidConnectSession` | Holds the login flow in the PHP session: `initRealm($plugin_id)`, `getRealmPlugin()`, `initState($destination)`/`getState()`/`clearState()`, `setJsonWebTokens()`/`getJsonWebTokens()`, `isAuthenticated()`, `destroy()`. State is bound to the session; a realm cannot be changed once the user is authenticated. |
| `oidc.json_http_client` | `JsonHttp\JsonHttpClient` | Thin JSON wrapper over core `http_client` (Guzzle). `get(JsonHttpGetRequest)` / `post(JsonHttpPostRequest)`; disables redirect following, requires HTTP 200, decodes JSON to array. Used for discovery, token, userinfo and JWKS calls. |
| `oidc.existing_account_validator` | `ExistingAccountValidator` | `isValid(UserInterface $account)` — TRUE only when `uid > 1` and the account has no existing external-auth mapping. Gates whether an existing local account may be auto-linked. |
| `plugin.manager.openid_connect_realm` | `OpenidConnectRealmManager` | Realm plugin manager — see plugins/realms.md. |
| `logger.channel.oidc` | logger channel | Channel `oidc`. |

Access checks: `_oidc_openid_connect_redirect` (`OpenidConnectRedirectAccessCheck`) allows a redirect
route only for an anonymous caller whose session state equals the `state` query parameter;
`_oidc_openid_connect_logout` (`OpenidConnectLogoutAccessCheck`) allows logout only when the session
is OIDC-authenticated. Cache contexts `user.openid_connect` and `user.openid_connect_realm` vary on the
current login/realm.

## Token value objects
- `JsonWebTokens` — `getType()`, `getIdToken()`/`getAccessToken()`/`getRefreshToken()` (each a `Token`),
  `getId()`, `getUsername()`, `getEmail()`, `getGivenName()`, `getFamilyName()`, `getClaim($name)`,
  `getClaims()`. Serializable via `toArray()`/`fromArray()` (stored in the session).
- `Token` — `getValue()`, `getExpires()` (unix ts).

## Events

`LinkExistingAccountEvent` (`Drupal\oidc\Event\LinkExistingAccountEvent`) — dispatched during
`loginRedirect` when no account is yet mapped for the external identity, to let code attach a local
account to the new login. Methods: `getProvider()` (`oidc:<plugin_id>`), `getJsonWebTokens()`,
`getAccount()`, `setAccount(UserInterface)`. The module's own `LinkExistingAccountSubscriber`
(priority 1000) matches a local user by the e-mail claim, gated by `oidc.existing_account_validator`.
Register a higher-priority subscriber to change or veto the match — call `stopPropagation()` to stop
the auto-link, or `setAccount()` to point it at a different account — so you can apply your own
policy for which logins may link to an existing account:

```php
public static function getSubscribedEvents() {
  return [\Drupal\oidc\Event\LinkExistingAccountEvent::class => ['onLink', 2000]];
}
public function onLink(\Drupal\oidc\Event\LinkExistingAccountEvent $event) {
  if (!$this->linkingAllowed($event->getProvider(), $event->getJsonWebTokens(), $event->getAccount())) {
    $event->stopPropagation();
  }
}
```

The module also subscribes to `externalauth` events: `AssignDefaultRoleSubscriber`
(`ExternalAuthEvents::REGISTER`) adds the realm's `default_rid` to new users; `UpdateUserSubscriber`
(`ExternalAuthEvents::LOGIN`) syncs username/e-mail/given/family names from the claims on every login.

## Hooks implemented (relevant to integrators)
- `hook_entity_base_field_info` — adds user base fields `given_name`, `family_name`, and computed
  `display_name` (`DisplayNameFieldItemList`).
- `hook_token_info` / `hook_tokens` — user tokens `[user:given-name]`, `[user:family-name]`,
  `[user:family-name-abbr]`.
- `hook_user_format_name_alter` — renders a user's display name via the realm's `display_name_format`.
- `hook_cron` — refreshes each enabled realm's JWKS (`updateJwks()`).
- `hook_module_preuninstall` — clears realm storage/JWKS and deletes `oidc:*` authmap entries.
- Route/validation/language alters: `hook_validation_constraint_alter` (swaps `UserMailUnique`),
  `hook_language_negotiation_info_alter`, `hook_entity_reference_selection_alter`,
  `hook_form_user_admin_settings_alter`, `hook_form_user_form_alter` (hides name/mail/pass fields for
  passwordless OIDC accounts). `RoutingEvents::ALTER` disables `user.register`/`user.pass` when
  `disable_user_routes` is on and sets `oidc_user_title` as the user page title callback.

## Notes
- New OIDC users get a random UUID username initially, replaced by the username claim on login.
- Linking an existing account nulls its local password (`$account->setPassword(NULL)`), making it a
  pure SSO account thereafter.
- No drush commands and no REST/JSON:API surface are provided.
