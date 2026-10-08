<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhooks events & alter hook

## Symfony events (`Drupal\webhooks\Event\WebhookEvents`)

Subscribe in an `EventSubscriberInterface`:

| Constant | Value | Event object | Fired |
|---|---|---|---|
| `WebhookEvents::SEND` | `webhook.send` | `SendEvent($config, $webhook)` | Before an outgoing webhook is POSTed. |
| `WebhookEvents::RECEIVE` | `webhook.receive` | `ReceiveEvent($config, $webhook)` | When an incoming webhook is received (inline) or processed from the queue. Act on the payload here. |
| `WebhookEvents::SEND_ERROR` | `webhook.send.error` | `SendErrorEvent($config, $webhook, $exception)` | When an outgoing POST throws. |

`ReceiveEvent::getWebhook()` returns the `Webhook`; set its status to FALSE
(`$event->getWebhook()->setStatus(FALSE)`) to signal a processing failure — the queue worker throws
`SuspendQueueException` in that case.

Example:
```php
public static function getSubscribedEvents(): array {
  return [WebhookEvents::RECEIVE => ['onReceive']];
}
public function onReceive(\Drupal\webhooks\Event\ReceiveEvent $event) {
  $payload = $event->getWebhook()->getPayload();
  // handle the incoming payload...
}
```

The bundled `webhook` submodule uses exactly this to persist received webhooks.

## Alter hook

`hook_webhooks_event_info_alter(array &$options)` — invoked while `WebhookConfigForm` builds the
outgoing **Enabled Events** table. Add your own event rows so admins can subscribe outgoing webhooks
to custom events. Each option is keyed by the event machine name and has `type` + `event` columns.
Fire your event later by building a `Webhook` and calling
`WebhooksService::triggerEvent($webhook, '<event>')` (or `drush webhooks:trigger <event>`).
