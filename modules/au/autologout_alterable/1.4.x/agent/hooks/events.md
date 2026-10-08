# Autologout Alterable — events

The module is "alterable" via Symfony events (not classic hooks). Constants in
`Drupal\autologout_alterable\Events\AutologoutEvents`; event classes in the same namespace. Subscribe
with a normal `EventSubscriberInterface` service tagged `event_subscriber`.

| Constant | Event name | Event class | When / what you can alter |
|---|---|---|---|
| `AutologoutEvents::ALTER_ENABLED` | `autologout_alterable_alter_enabled` | `AutologoutAlterEnabledEvent` | Fired every request while resolving whether autologout is enabled. Alter enabled state per current user / route (disabled ⇒ activity and expiry are not updated). |
| `AutologoutEvents::SET_LAST_ACTIVITY` | `autologout_alterable_set_last_activity` | `AutologoutSetLastActivityEvent` | Fired when last activity is set (each request unless already expired). Change the last-activity time or tell the module not to store it — e.g. feed activity from an SSO/decoupled system. |
| `AutologoutEvents::AUTOLOGOUT_PROFILE_ALTER` | `autologout_alterable_autologout_profile_alter` | `AutologoutProfileAlterEvent` | Fired when the profile is built (each request, before deciding expiry). Alter expiry time, redirect URL, extendibility, etc. |
| `AutologoutEvents::AUTOLOGOUT_CRON_PROFILE_ALTER_CRON` | `autologout_alterable_cron_autologout_profile_alter` | `AutologoutCronProfileAlterEvent` | Fired during the **cron** session check. Alter expiry or prevent session deletion. NOTE: limited context — session service etc. is not the normal request context; `current_user` can still be trusted. |

## Example subscriber
```php
final class MyAutologoutSubscriber implements \Symfony\Component\EventDispatcher\EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [
      \Drupal\autologout_alterable\Events\AutologoutEvents::ALTER_ENABLED => 'onAlterEnabled',
      \Drupal\autologout_alterable\Events\AutologoutEvents::AUTOLOGOUT_PROFILE_ALTER => 'onProfileAlter',
    ];
  }
  public function onAlterEnabled(\Drupal\autologout_alterable\Events\AutologoutAlterEnabledEvent $event): void {
    // e.g. $event->setEnabled(FALSE) for a given route/user.
  }
  public function onProfileAlter(\Drupal\autologout_alterable\Events\AutologoutProfileAlterEvent $event): void {
    // e.g. adjust the profile's session expiry or redirect URL.
  }
}
```
Register it in `*.services.yml` with `tags: [{ name: event_subscriber }]`. Inspect the specific event
class for its exact getters/setters (profile object is `AutologoutProfileInterface`).

## Built-in subscriber
`autologout_alterable_event_subscriber` (`AutologoutSubscriber`) is the module's own request subscriber
that updates last activity and triggers logout on expiry — a reference for context/order.
