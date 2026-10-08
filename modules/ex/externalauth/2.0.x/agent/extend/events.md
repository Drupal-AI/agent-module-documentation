# externalauth events

Constants in `Drupal\externalauth\Event\ExternalAuthEvents`. Subscribe with a normal
`EventSubscriberInterface`.

| Constant | Name | Event object | Fired when |
|---|---|---|---|
| `ExternalAuthEvents::LOGIN` | `externalauth.login` | `ExternalAuthLoginEvent` | A user was logged in after external auth. |
| `ExternalAuthEvents::REGISTER` | `externalauth.register` | `ExternalAuthRegisterEvent` | A new external user was registered. |
| `ExternalAuthEvents::AUTHMAP_ALTER` | `externalauth.authmap_alter` | `ExternalAuthAuthmapAlterEvent` | Before authmap data is stored — alter it. |

```php
public static function getSubscribedEvents(): array {
  return [
    ExternalAuthEvents::REGISTER => 'onRegister',
    ExternalAuthEvents::AUTHMAP_ALTER => 'onAuthmapAlter',
  ];
}

public function onRegister(ExternalAuthRegisterEvent $event) {
  $account = $event->getAccount();      // add roles, fields, etc.
}
public function onAuthmapAlter(ExternalAuthAuthmapAlterEvent $event) {
  // $event->setAuthname(...) / adjust the data to be stored.
}
```
