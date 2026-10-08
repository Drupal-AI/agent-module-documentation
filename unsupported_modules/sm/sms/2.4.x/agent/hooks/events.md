# SMS Framework — events & alter hooks

## Events (`Drupal\sms\Event\SmsEvents`)

Subscribe with a tagged `event_subscriber` service. Constants and their event objects:

| Constant | Event object | When / what |
|---|---|---|
| `MESSAGE_PRE_PROCESS` | `SmsMessageEvent` | Before processing; read/replace/chunk the message list (`getMessages()/setMessages()`). |
| `MESSAGE_POST_PROCESS` | `SmsMessageEvent` | After processing; same shape. |
| `MESSAGE_GATEWAY` | `RecipientGatewayEvent` | Choose the gateway(s) for a recipient: `getRecipient()`, `addGateway($gateway, $priority)`. |
| `MESSAGE_QUEUED` | — | Message queued. |
| `ENTITY_PHONE_NUMBERS` | `SmsEntityPhoneNumber` | Provide phone numbers for an entity: `getEntity()`, `addPhoneNumber('+123…')`, `getPhoneNumbers()`. |
| `DELIVERY_REPORT_PRE_PROCESS` / `DELIVERY_REPORT_POST_PROCESS` | `SmsDeliveryReportEvent` | Inspect/act on delivery reports (`getReports()`). |

Bundled subscribers (in `sms.services.yml`): `SmsMessageProcessor` (message routing/gateway
resolution using `sms.settings`), `SmsEntityPhoneNumberProcessor` (verified numbers for
entities), `SmsDeliveryReportsProcessor` (persists reports).

### Example

```php
// mymodule.services.yml
//   mymodule.sms_subscriber:
//     class: Drupal\mymodule\EventSubscriber\MySmsSubscriber
//     tags: [{ name: event_subscriber }]

public static function getSubscribedEvents(): array {
  return [
    \Drupal\sms\Event\SmsEvents::MESSAGE_GATEWAY => ['pickGateway'],
    \Drupal\sms\Event\SmsEvents::ENTITY_PHONE_NUMBERS => ['entityNumbers'],
  ];
}
public function pickGateway(\Drupal\sms\Event\RecipientGatewayEvent $event) {
  $event->addGateway($myGateway, 100);
}
```

## Alter hook (`sms.api.php`)

- `hook_sms_gateway_info_alter(array &$gateways)` — modify discovered `sms_gateway` plugin
  definitions (e.g. relabel).

See `sms.api.php` and `\Drupal\sms\Event\SmsEvents` for the full contract; the test module
`sms_test` (`tests/modules/`) has working subscriber examples.
