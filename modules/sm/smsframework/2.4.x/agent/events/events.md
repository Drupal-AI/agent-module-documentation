# Events

Constants live on `Drupal\sms\Event\SmsEvents`. Subscribe with a tagged `event_subscriber` service.
`MESSAGE_*` events carry `Drupal\sms\Event\SmsMessageEvent` (`getMessages()`/`setMessages()`), so a
subscriber may add, remove, split (chunk) or re-gateway messages.

| Constant | String | Fired | Event class |
|---|---|---|---|
| `MESSAGE_PRE_PROCESS` | `sms.message.pre_process` | before any queue/send/receive | `SmsMessageEvent` |
| `MESSAGE_POST_PROCESS` | `sms.message.post_process` | after send/receive (not for queued) | `SmsMessageEvent` |
| `MESSAGE_QUEUE_PRE_PROCESS` | `sms.message.queue.pre_process` | before storing to the queue | `SmsMessageEvent` |
| `MESSAGE_QUEUE_POST_PROCESS` | `sms.message.queue.post_process` | after storing to the queue | `SmsMessageEvent` |
| `MESSAGE_OUTGOING_PRE_PROCESS` | `sms.message.outgoing.pre_process` | before send | `SmsMessageEvent` |
| `MESSAGE_OUTGOING_POST_PROCESS` | `sms.message.outgoing.post_process` | after send | `SmsMessageEvent` |
| `MESSAGE_INCOMING_PRE_PROCESS` | `sms.message.incoming.pre_process` | before receiving | `SmsMessageEvent` |
| `MESSAGE_INCOMING_POST_PROCESS` | `sms.message.incoming.post_process` | after receiving | `SmsMessageEvent` |
| `MESSAGE_GATEWAY` | `sms.message.gateway` | only when no gateway was set yet | `RecipientGatewayEvent` |
| `DELIVERY_REPORT_POST_PROCESS` | `sms.report.post_process` | after a gateway parses pushed reports | `SmsDeliveryReportEvent` |
| `ENTITY_PHONE_NUMBERS` | `sms.entity_phone_numbers` | resolving an entity's phone numbers | `SmsEntityPhoneNumber` |

Notes:
- `RecipientGatewayEvent`: `getRecipient()`, `addGateway($gateway, $priority = 0)` — highest priority
  wins; add a gateway only if you are sure, else let the framework fall back.
- `SmsEntityPhoneNumber`: `getEntity()`, `addPhoneNumber($number)`, `getPhoneNumbers()`.
- `SmsDeliveryReportEvent`: `getReports()`, `setResponse()/getResponse()` (lets you shape the HTTP
  response returned to a pushing gateway).

Example (`my_module.services.yml` → tagged `event_subscriber`):

```php
public static function getSubscribedEvents(): array {
  return [
    \Drupal\sms\Event\SmsEvents::MESSAGE_PRE_PROCESS => ['onPreProcess'],
    \Drupal\sms\Event\SmsEvents::MESSAGE_GATEWAY => ['onGateway'],
  ];
}
public function onGateway(\Drupal\sms\Event\RecipientGatewayEvent $event): void {
  $event->addGateway(\Drupal\sms\Entity\SmsGateway::load('my_gw'), 100);
}
```

See `sms.api.php` in the source for a full worked subscriber.
