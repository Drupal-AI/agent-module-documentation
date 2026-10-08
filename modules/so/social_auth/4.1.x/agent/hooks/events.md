<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events

Social Auth dispatches Symfony events (not classic `hook_*`). Constants are in
`Drupal\social_auth\Event\SocialAuthEvents`; subscribe with a normal
`EventSubscriberInterface` service tagged `event_subscriber`.

| Constant | Event name | Event class | When |
|---|---|---|---|
| `SocialAuthEvents::USER_FIELDS` | `social_auth.user.fields` | `UserFieldsEvent` | Social Auth is gathering the fields used to create the Drupal user. Alter them here. |
| `SocialAuthEvents::USER_CREATED` | `social_auth.user.created` | `UserEvent` | A new user was created via social auth. |
| `SocialAuthEvents::USER_LOGIN` | `social_auth.user.login` | `UserEvent` | A user logged in via social auth. |
| `SocialAuthEvents::BEFORE_REDIRECT` | `social_auth.before_redirect` | `BeforeRedirectEvent` | Just before redirecting the browser to the provider. |
| `SocialAuthEvents::FAILED_AUTH` | `social_auth.failed_authentication` | `FailedAuthenticationEvent` | Authentication failed on the provider side. |

Event classes extend `SocialAuthEventBase`. `UserEvent` carries the Drupal user + provider
plugin id; `UserFieldsEvent` carries the field array (get/set) used for account creation;
`BeforeRedirectEvent` / `FailedAuthenticationEvent` carry the plugin id and destination/error.

## Example subscriber

```php
use Drupal\social_auth\Event\SocialAuthEvents;
use Drupal\social_auth\Event\UserFieldsEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySocialAuthSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [SocialAuthEvents::USER_FIELDS => 'onUserFields'];
  }
  public function onUserFields(UserFieldsEvent $event): void {
    $fields = $event->getUserFields();
    // e.g. force a role or adjust the generated username.
    $event->setUserFields($fields);
  }
}
```

Register the class as a service tagged `{ name: event_subscriber }`.
