# Events — `PasswordResetEvent`

`Drupal\rest_password\Event\PasswordResetEvent` (extends
`Drupal\Component\EventDispatcher\Event`). Dispatched by the `lost_password_reset` REST resource
(`ResetPasswordFromTempRestResource::post()`) around a successful password change made with a valid
temp password.

Constants (event names):

| Constant | Event name | When |
|---|---|---|
| `PasswordResetEvent::PRE_RESET` | `event.pre_rest_password_reset` | after the temp token matches, **before** `$account->save()` |
| `PasswordResetEvent::POST_RESET` | `event.post_rest_password_reset` | **after** the new password is saved |

At PRE_RESET the account already has the new password set in memory (`setPassword`) but is not yet
saved; at POST_RESET it is persisted.

API: `$event->getUser(): \Drupal\user\UserInterface`.

> Note: these fire only via `/user/lost-password-reset`. The temp-password **login** path
> (`/user/login`) does not dispatch them.

## Example subscriber

```php
use Drupal\rest_password\Event\PasswordResetEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class RestPasswordSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [
      PasswordResetEvent::POST_RESET => 'onPostReset',
    ];
  }

  public function onPostReset(PasswordResetEvent $event): void {
    $user = $event->getUser();
    // e.g. log it, notify, invalidate other sessions, sync to an external IdP.
  }
}
```

Register the class as a service tagged `event_subscriber`.
