# Extend — events for account linking, attribute sync & toolkit config

Event name constants are in `Drupal\samlauth\Event\SamlauthEvents`. Subscribe with a normal
`EventSubscriberInterface`. These are the intended extension points — the shipped submodules
(`samlauth_user_fields`, `samlauth_user_roles`) are themselves just subscribers to these events.

| Constant | Name | Event object | Fired when |
|---|---|---|---|
| `SamlauthEvents::USER_LINK` | `samlauth.user_link` | `SamlauthUserLinkEvent` | Looking for an existing Drupal user to link to a first-time SAML login. |
| `SamlauthEvents::USER_SYNC` | `samlauth.user_sync` | `SamlauthUserSyncEvent` | After the assertion is validated, before the user is saved/logged in — sync fields/roles or veto. |
| `SamlauthEvents::LIBRARY_CONFIG_ALTER` | `samlauth.library_config_alter` | `SamlauthLibraryConfigAlterEvent` | Before the `OneLogin\Saml2\Auth` object is built — alter the php-saml settings array. |

## USER_LINK — link an existing account

`SamlauthUserLinkEvent`: `getAttributes()` returns the SAML attributes. If your subscriber finds
a matching Drupal account, call `$event->setLinkedAccount($account)`. If nothing is set, the
module falls back to its own name/email matching (per `map_users*` config) or creates a user.

## USER_SYNC — map attributes / roles, or block login

`SamlauthUserSyncEvent`:
- `getAccount()` / `setAccount()` — the Drupal user (may be unsaved & new).
- `getAttributes()` / `setAttributes()` — the IdP attributes (single values as 1-element arrays).
- `isFirstLogin()` — TRUE on new or newly-linked accounts (see docblock caveats).
- `getAccount()->isNew()` — truly new account.
- `markAccountChanged()` — **call this** instead of `$account->save()` so the module saves once
  after all subscribers run.
- Throw an exception (e.g. `UserVisibleException`) to **prevent the login/registration**.

```php
public static function getSubscribedEvents(): array {
  return [SamlauthEvents::USER_SYNC => 'onUserSync'];
}

public function onUserSync(SamlauthUserSyncEvent $event) {
  $attributes = $event->getAttributes();
  $account = $event->getAccount();
  if (!empty($attributes['department'][0])) {
    $account->set('field_department', $attributes['department'][0]);
    $event->markAccountChanged();
  }
}
```

Prefer `USER_SYNC` over externalauth's `REGISTER`/`LOGIN` events: it fires for both new and
existing accounts and lets you throw before a partly-populated user is saved.

## LIBRARY_CONFIG_ALTER — advanced php-saml settings

`SamlauthLibraryConfigAlterEvent`: `getConfig()` / `setConfig(array)` mutate the settings array
passed to the toolkit; `getPurpose()` returns the context (`'login'`, `'acs'`, `'logout'`, …).
Use it for options not in the UI — e.g. per-environment IdP endpoints, or setting
`requestedAuthnContext` / `requestedAuthnContextComparison`. See the OneLogin php-saml settings
reference: https://github.com/SAML-Toolkits/php-saml#settings

No `samlauth.api.php` ships; these three events are the documented API.
