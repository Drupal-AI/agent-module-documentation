# Recurring Events Registration — services

Both services are `shared: false` (get a fresh instance per use).

## `recurring_events_registration.creation_service`
`Drupal\recurring_events_registration\RegistrationCreationService`. Set the context, then query.
```php
$svc = \Drupal::service('recurring_events_registration.creation_service');
$svc->setEventInstance($eventinstance);   // or ->setEventSeries($series)
```
Selected methods (`src/RegistrationCreationService.php`):
| Method | Returns / does |
|---|---|
| `hasRegistration()` | Whether the event has registration enabled. |
| `getRegistrationType(): RegistrationType` | `series` or `instance` (enum `src/Enum/RegistrationType.php`). |
| `hasAvailability()` / `retrieveAvailability()` | Spots left. |
| `hasWaitlist()` | Waitlist enabled? |
| `registrationIsOpen()` | Is registration currently open? |
| `getRegistrationDateRange()` / `registrationOpeningClosingTime()` | Open/close window. |
| `retrieveRegisteredParties($nonWaitlist = TRUE, $waitlist = TRUE, $uid = FALSE)` | Registrant entities. |
| `retrieveRegisteredPartiesCount(...)` | Count. |
| `retrieveWaitlistedParties()` / `retrieveFirstWaitlistParty()` | Waitlist. |
| `promoteFromWaitlist()` | Promote next waitlisted registrant (honors the promotion hook). |
| `hasUserRegisteredById($uid)` / `hasUserRegisteredByEmail($email, $ignoreId = NULL)` | Duplicate checks. |
| `retrieveAvailability()`, `eventInstanceIsInFuture()`, `eventSeriesHasFutureInstances()` | State helpers. |
| `getAvailableTokens($relevant = ['registrant'])` | Tokens usable in notifications. |

## `recurring_events_registration.notification_service`
`Drupal\recurring_events_registration\NotificationService`. Builds/sends a configured notification.
```php
$n = \Drupal::service('recurring_events_registration.notification_service');
$n->setKey('registration_notification')->setEntity($registrant);
if ($n->isEnabled()) {
  $subject = $n->getSubject();   // token-parsed
  $body    = $n->getMessage();
}
$n->addEmailNotificationToQueue($key, $registrant);  // queue instead of send now
```
Other setters: `setSubject()`, `setMessage()`, `setFrom()`, `setConfigName()`; `parseTokenizedString()`,
`getAvailableTokens()`. Queued items are processed by
`src/Plugin/QueueWorker/EmailNotificationsQueueWorker.php`. Whether a notification actually sends can be
vetoed via `hook_recurring_events_registration_send_notification_alter()`.

## Computed fields (Views/entity)
`src/Plugin/ComputedField/`: `AvailabilityCount`, `RegistrationCount`, `WaitlistCount`; plus Views
field/filter/argument plugins under `src/Plugin/views/` expose capacity, count, availability and
waitlist counts.
