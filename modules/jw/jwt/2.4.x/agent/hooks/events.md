<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JWT events (extension points)

JWT has no `.api.php` hooks; it extends via **Symfony events** on `JwtAuthEvents`
(`Drupal\jwt\Authentication\Event\JwtAuthEvents`). Subscribe with a normal
`event_subscriber`-tagged service.

| Constant | String | When | Event class | You do |
|---|---|---|---|---|
| `JwtAuthEvents::GENERATE` | `jwt.generate` | Before a new token is encoded | `JwtAuthGenerateEvent` | `$event->getToken()->setClaim(...)` to add claims |
| `JwtAuthEvents::VALIDATE` | `jwt.validate` | After signature check, before trusting the token | `JwtAuthValidateEvent` | `$event->invalidate($reason)` to reject; treat token as untrusted |
| `JwtAuthEvents::VALID` | `jwt.valid` | After the token is fully validated | `JwtAuthValidEvent` | `$event->setAccount($user)` to say who authenticated |

Rules baked into the event contract:
- In `VALIDATE`, assume the token is hostile — only decide validity, never perform side effects
  that depend on a valid token. Other subscribers may still invalidate it.
- In `VALID`, the token is trusted; return a Drupal user (you may create one). Do **not** try to
  reject here — use `VALIDATE`.
- In `GENERATE`, remember JWTs are signed but **not encrypted** — never put secrets in claims.

## Minimal subscriber

```php
// src/EventSubscriber/MyJwtSubscriber.php
use Drupal\jwt\Authentication\Event\JwtAuthEvents;
use Drupal\jwt\Authentication\Event\JwtAuthGenerateEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyJwtSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [JwtAuthEvents::GENERATE => ['onGenerate']];
  }
  public function onGenerate(JwtAuthGenerateEvent $event): void {
    $event->getToken()->setClaim(['drupal', 'uid'], (int) \Drupal::currentUser()->id());
    $event->getToken()->setClaim('exp', \Drupal::time()->getRequestTime() + 3600);
  }
}
```

```yaml
# my_module.services.yml
services:
  my_module.jwt_subscriber:
    class: Drupal\my_module\EventSubscriber\MyJwtSubscriber
    tags: [{ name: event_subscriber }]
```

Reference implementations shipped in this project: `jwt_auth_consumer` subscribes to `VALIDATE`
+ `VALID` (loads the user from `drupal.uid`/`uuid`/`name`), and `jwt_auth_issuer` subscribes to
`GENERATE` (adds the current user's `drupal.uid`).
