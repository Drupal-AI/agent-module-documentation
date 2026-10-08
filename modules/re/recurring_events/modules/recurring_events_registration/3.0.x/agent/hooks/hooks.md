# Recurring Events Registration — hooks

Source: `recurring_events_registration.api.php`.

| Hook | Purpose |
|---|---|
| `hook_recurring_events_registration_first_waitlist_alter(Registrant $registrant)` | Return the registrant that should be promoted from the waitlist (override the default selection). Must return a valid `Registrant`. |
| `hook_recurring_events_registration_send_notification_alter(bool &$send_email, RegistrantInterface $registrant)` | Veto/allow sending a notification for a specific registrant. |
| `hook_recurring_events_registration_notification_types_alter(array &$notification_types)` | Add/override configurable notification types (each: `name`, `description`). The reminders submodule uses this to add `registration_reminder`. |
| `hook_recurring_events_registration_message_params_alter(array &$params, RegistrantInterface $registrant)` | Add values to the `$params` later passed to `hook_mail()` / `hook_mail_alter()` (use scalars/arrays, not loaded entities — messages may be queued). |

Example — do not email registrant #100:
```php
function mymodule_recurring_events_registration_send_notification_alter(bool &$send_email, $registrant) {
  if ((int) $registrant->id() === 100) {
    $send_email = FALSE;
  }
}
```
