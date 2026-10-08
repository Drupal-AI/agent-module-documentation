# SMS Framework — sending, queue, phone numbers, verification API

## Services

| Service | Class | Use |
|---|---|---|
| `sms.provider` (alias of `sms.provider.default`) | `DefaultSmsProvider` | Send / queue messages, process delivery reports. |
| `sms.phone_number` | `PhoneNumberProvider` | Resolve an entity's phone numbers; send to an entity. |
| `sms.phone_number.verification` | `PhoneNumberVerification` | Create/lookup verifications, purge expired. |
| `sms.queue` | `SmsQueueProcessor` | Process the SMS send queue (cron). |
| `plugin.manager.sms_gateway` | `SmsGatewayPluginManager` | Gateway plugin discovery. |

## Send a message

```php
use Drupal\sms\Message\SmsMessage;
use Drupal\sms\Direction;

$sms = (new SmsMessage())
  ->addRecipient('+15551234567')
  ->setMessage('Hello from Drupal')
  ->setDirection(Direction::OUTGOING);

// Queue it (recommended; honours gateway skip_queue, events, scheduling):
\Drupal::service('sms.provider')->queue($sms);
// or send immediately:
\Drupal::service('sms.provider')->send($sms);
```

`SmsProviderInterface` also handles pushed reports via `processDeliveryReport(Request,
SmsGatewayInterface)` (called from `DeliveryReportController`). Messages may be `SmsMessage`
value objects or `sms` content entities (`SmsMessage::convertFromSmsMessage()` upgrades one).

## Send to an entity's phone number

```php
$provider = \Drupal::service('sms.phone_number');
$numbers = $provider->getPhoneNumbers($user);        // verified numbers (via ENTITY_PHONE_NUMBERS event)
$provider->sendMessage($user, $sms);                 // throws NoPhoneNumberException if none
```

`getPhoneNumbers()` dispatches `SmsEvents::ENTITY_PHONE_NUMBERS`; the bundled
`SmsEntityPhoneNumberProcessor` supplies verified numbers from `phone_number_settings`.

## Verification

`sms.phone_number.verification` (`PhoneNumberVerification`):
- `newPhoneVerification($entity, $phone_number)` — creates an
  `sms_phone_number_verification` entity with a random 6-char code, queues the verification SMS
  (message from the bundle's `phone_number_settings`), returns the verification.
- `getPhoneVerificationByCode($code)`, `getPhoneVerificationByPhoneNumber(...)`,
  `getPhoneVerificationByEntity($entity, $number)` — lookups.
- `updatePhoneVerificationByEntity($entity)` — creates verifications for new numbers on the
  entity's phone field, deletes ones for removed numbers (wired from entity hooks).
- `purgeExpiredVerifications()` — deletes expired unverified codes; optionally strips the
  unverified number from the entity when the bundle's purge option is set.

The `/verify` form (`VerifyPhoneNumberForm`) flips a verification to verified on a valid,
unexpired code (flood-limited). Entities/services use `dynamic_entity_reference` so a
verification can target any entity type.

## Queue / cron

`SmsQueueProcessor` (`sms.queue`) drains queued outgoing messages on cron; the
`SmsProcessor` queue worker plugin performs the actual gateway send. Gateways flagged
`schedule_aware` respect `SmsMessage::getSendTime()`.
