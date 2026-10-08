# Sending, receiving & the SMS message API

## Services

| Service id | Class | Purpose |
|---|---|---|
| `sms.provider` (alias of `sms.provider.default`) | `Drupal\sms\Provider\DefaultSmsProvider` | Core send/queue/receive/report engine. |
| `sms.phone_number` | `Drupal\sms\Provider\PhoneNumberProvider` | Resolve an entity's phone numbers and send to an entity. |
| `sms.phone_number.verification` | `Drupal\sms\Provider\PhoneNumberVerification` | Create/look up phone-number verifications, purge expired. |
| `sms.queue` | `Drupal\sms\Provider\SmsQueueProcessor` | Moves stored messages into the queue worker, garbage-collects. |
| `plugin.manager.sms_gateway` | `Drupal\sms\Plugin\SmsGatewayPluginManager` | Gateway plugin manager. |

## The `SmsMessage` value object

`Drupal\sms\Message\SmsMessage` (interface `SmsMessageInterface`) is the transport DTO. Key methods:
`addRecipient()/addRecipients()/getRecipients()`, `setMessage()/getMessage()`,
`setSender()/setSenderNumber()`, `setGateway()/getGateway()`, `setDirection()/getDirection()` (see
`Drupal\sms\Direction::OUTGOING` / `::INCOMING`), `setOption()/getOption()`,
`setAutomated()/isAutomated()`, `setResult()/getResult()`, `chunkByRecipients($size)`,
`getReport($recipient)/getReports()`. There is also an **entity** form of the message,
`Drupal\sms\Entity\SmsMessage` (entity type `sms`), used once a message is stored in the queue;
`SmsMessage::convertFromSmsMessage()` converts the value object to the entity.

## Send to a raw number

```php
use Drupal\sms\Message\SmsMessage;
use Drupal\sms\Direction;

$sms = (new SmsMessage())
  ->addRecipient('+15555550123')
  ->setMessage('Hello from Drupal')
  ->setDirection(Direction::OUTGOING);

// Preferred: queue (respects the gateway's skip_queue and load-balances via cron).
\Drupal::service('sms.provider')->queue($sms);

// Or send immediately (bypasses the queue):
// \Drupal::service('sms.provider')->send($sms);
```

Gateway selection: if you do not `setGateway()`, pre-process events pick one — the
`MESSAGE_GATEWAY` event lets subscribers vote a gateway per recipient (highest priority wins);
otherwise the `sms.settings:fallback_gateway` is used. If no gateway can be resolved a
`RecipientRouteException` is thrown.

## Send to a user / entity (by its phone number)

```php
use Drupal\sms\Message\SmsMessage;

$user = \Drupal\user\Entity\User::load(1);
$sms = (new SmsMessage())->setMessage('Your code is 1234');
// Throws NoPhoneNumberException if the entity has no (verified) number.
\Drupal::service('sms.phone_number')->sendMessage($user, $sms);
```

`PhoneNumberProvider::getPhoneNumbers($entity, $verified = TRUE)` returns the entity's numbers by
dispatching the `ENTITY_PHONE_NUMBERS` event (the framework's own subscriber resolves them from the
verified `sms_phone_number_verification` records for the entity's bundle). `sendMessage()` sends to
the first returned number, tags the message with the recipient entity, and calls `queue()`.

## Queue vs immediate

`DefaultSmsProvider::queue()` dispatches `MESSAGE_PRE_PROCESS` + `MESSAGE_QUEUE_PRE_PROCESS`,
validates `sms` entities, and then: if the message's gateway has **skip_queue**, calls `send()`
(outgoing) or `incoming()` immediately; otherwise persists it as an `sms` entity. `sms.queue`
(`SmsQueueProcessor::processUnqueued()`, run from `hook_cron`) loads unqueued stored messages whose
`send_on` is due and pushes them to the `SmsProcessor` queue worker, which calls `send()`.
`garbageCollection()` deletes processed messages older than the gateway's per-direction retention.

## Receiving inbound messages

An inbound message reaches the site when a gateway plugin declares `incoming_route` and a push path
is set (see [plugins/gateway.md](../plugins/gateway.md)). `Drupal\sms\SmsIncomingController::processIncoming()`
calls the gateway plugin's `processIncoming()` (which parses the raw request into an
`SmsProcessingResponse` of `SmsMessage`s) and `queue()`s each with `Direction::INCOMING`.
`DefaultSmsProvider::incoming()` dispatches `MESSAGE_INCOMING_PRE_PROCESS`/`_POST_PROCESS`; if the
gateway plugin implements `SmsIncomingEventProcessorInterface` its `incomingEvent()` runs.

## Delivery reports

Two paths: **pull** (`getDeliveryReports()` on the plugin, for `reports_pull` gateways) and **push**
(the gateway POSTs to the report path). Push lands on
`Drupal\sms\DeliveryReportController::processDeliveryReport()` → `SmsProvider::processDeliveryReport()`,
which calls the plugin's `parseDeliveryReports(Request, Response)` and dispatches
`DELIVERY_REPORT_POST_PROCESS`; the framework subscriber (`SmsDeliveryReportsProcessor`) writes the
reports onto the matching stored `sms` message. Reports are `Drupal\sms\Message\SmsDeliveryReport`
with statuses from `Drupal\sms\Message\SmsMessageReportStatus`.
