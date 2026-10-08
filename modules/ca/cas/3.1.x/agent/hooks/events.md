# Events

CAS has no `hook_*` API; extend it by subscribing to its Symfony events (`src/Event/`).
Dispatched by name and by class.

| Event name | Class | When / use |
|---|---|---|
| `cas.pre_validate_server_config` | `CasPreValidateServerConfigEvent` | Alter server params before ticket validation. |
| `cas.pre_validate` | `CasPreValidateEvent` | Alter the validation request URL/params. |
| `cas.post_validate` | `CasPostValidateEvent` | Inspect/alter raw validation response + attributes. |
| `cas.pre_user_load` | `CasPreUserLoadEvent` | Map/normalize the CAS username before the account is loaded. |
| `cas.pre_user_load.redirect` | `CasPreUserLoadRedirectEvent` | Redirect before user load (e.g. block a user). |
| `cas.pre_register` | `CasPreRegisterEvent` | Set email/username/roles or deny auto-registration for a new account. |
| `cas.pre_login` | `CasPreLoginEvent` | Deny login or set properties before the user is logged in. |
| `cas.post_login` | `CasPostLoginEvent` | Act after a successful login (e.g. copy attributes to fields). |
| `cas.pre_redirect` | `CasPreRedirectEvent` | Alter the redirect to the CAS server (add gateway/proxy params). |

```php
public static function getSubscribedEvents(): array {
  return [CasHelper::EVENT_PRE_REGISTER => 'onPreRegister'];
}
public function onPreRegister(CasPreRegisterEvent $event): void {
  $event->setPropertyValue('field_dept', $event->getCasPropertyBag()->getAttribute('department'));
  // $event->cancelAutomaticRegistration('Not allowed'); to deny.
}
```
(`src/DependencyInjection/DeprecatedEventConstants.php` maps old constants.)
