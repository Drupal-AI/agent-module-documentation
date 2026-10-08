<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# XframeSubscriber — the framing header

The module's entire behaviour is one event subscriber.

## Registration

`xframe_allow_webvisor.services.yml`:

```yaml
services:
  xframe_allow_webvisor.subscriber:
    class: Drupal\xframe_allow_webvisor\EventSubscriber\XframeSubscriber
    tags:
      - { name: event_subscriber }
```

## Class

`src/EventSubscriber/XframeSubscriber.php` —
`Drupal\xframe_allow_webvisor\EventSubscriber\XframeSubscriber implements EventSubscriberInterface`.

- `getSubscribedEvents()` returns `[KernelEvents::RESPONSE => [['onKernelResponse']]]`, so it runs on
  every HTTP response (default priority, no path/route filtering).
- `onKernelResponse(ResponseEvent $event)` does exactly:

  ```php
  $response = $event->getResponse();
  $response->headers->set('content-security-policy',
    "frame-ancestors 'self' http://webvisor.com https://webvisor.com https://metrika.yandex.ru http://metrika.yandex.ru");
  ```

## Behaviour

- Emitted header on every response:
  `Content-Security-Policy: frame-ancestors 'self' http://webvisor.com https://webvisor.com https://metrika.yandex.ru http://metrika.yandex.ru`
- `frame-ancestors` controls which origins may embed the page in a `<frame>`, `<iframe>`,
  `<embed>` or `<object>`. Listing the site (`'self'`) plus the Yandex WebVisor and Metrica hosts
  lets Yandex Metrica WebVisor frame the site for session replay.
- The value is hard-coded; there is nothing to configure. The origins cannot be changed without
  editing the class.
- `headers->set(...)` assigns the `content-security-policy` header value (it does not append a
  directive to a pre-existing policy). If the site or another module also emits a
  Content-Security-Policy, verify the resulting header after enabling.

## Operating it

1. Install/enable: `drush en xframe_allow_webvisor -y` (or via the module page). No further steps.
2. Confirm: request any page and inspect the `Content-Security-Policy` response header — it should
   carry the `frame-ancestors` directive above.
3. Disable to stop emitting the header: `drush pmu xframe_allow_webvisor -y`.

For adjustable framing rules or a broader set of security headers, use Security Kit (`seckit`)
instead — this module is deliberately minimal and fixed.
