SMSAPI integrates Drupal with the SMSAPI.com SMS gateway to send single, bulk and templated SMS, manage MFA/2FA verification codes, and log delivery reports.

---

SMSAPI wraps the official `smsapi/php-client` SDK behind a Drupal-friendly service and admin UI. After you enter your SMSAPI OAuth token and pick a service region (Poland, international .com, Sweden or Bulgaria), the module lets site builders send test messages from an admin form and lets developers inject the `smsapi.service` to send SMS programmatically from any class, form, block or event subscriber. It adds a reusable "SMSAPI SMS Template" configuration entity for tokenised messages (e.g. an authorization-code template is created on install), a Profile page that surfaces your SMSAPI account data, a test/production environment switch with an optional mock ("test") mode so requests can be validated without spending credit, and helper methods for sending and verifying one-time MFA codes. A `/smsapi/callback` endpoint records SMSAPI delivery-status reports into Drupal's log so operators can see message outcomes.

---

- Send a plain SMS to one phone number from custom code via `SmsapiService::sendSms($phone, $message, $sender)`.
- Send the same message to many recipients at once with `SmsapiService::sendMultipleSms($phoneNumbers, $message, $sender)`.
- Define reusable, tokenised message templates as "SMSAPI SMS Template" config entities and send them with `sendSmsWithTemplate()`.
- Blast a single template to a list of numbers using `sendMultipleTemplateSms()`.
- Add SMS-based two-factor authentication by generating a one-time code with `sendVerificationCode()` and validating it with `checkVerificationCode()`.
- Send a booking/appointment confirmation SMS when a Commerce order or Webform submission completes, from a custom event subscriber.
- Notify editors or admins by SMS when specific content is published or a workflow transition happens.
- Deliver order-shipped / delivery notifications to customers via a hook or queue worker calling the service.
- Send account-related alerts (password changed, suspicious login) as SMS from a custom module.
- Test connectivity and credentials from the admin "Send SMS" form (`/admin/smsapi/send-sms`) before wiring up code.
- Use Test Environment mode to force all outgoing messages to a single configured test phone number and sender while developing.
- Enable Mock mode to exercise the full send path against SMSAPI without actually delivering (and billing) messages.
- List your account's active, approved sender names dynamically in a form via `SmsapiService::getSenders()`.
- Display your SMSAPI account/profile data (points, credentials info) on the admin Profile page (`/admin/smsapi/profile`).
- Target the correct regional SMSAPI endpoint (smsapi.pl, smsapi.com, smsapi.se, smsapi.bg) by choosing the service region in configuration.
- Support the module maintainers automatically by leaving the Partner ID (`XLEJ`) enabled on outbound messages.
- Build a staff "send a quick SMS" tool by exposing the admin send forms to trusted roles.
- Create per-campaign or per-notification-type templates (welcome, reminder, verification) editable by non-developers at `/admin/structure/smsapi-sms-template`.
- Interpolate dynamic values (name, code, amount) into a template at send time by passing a token → value map.
- Localise or vary a message body without code changes by editing the template entity.
- Record and audit SMS delivery outcomes by configuring SMSAPI to post reports to `/smsapi/callback`, which writes them to the Drupal log.
- Send SMS appointment reminders from a cron job or scheduled queue that calls the service for due items.
- Integrate SMS OTP into a custom registration or checkout step by combining `sendVerificationCode()` and `checkVerificationCode()`.
- Provide a "resend code" action in a custom flow by re-invoking `sendVerificationCode()` for the same phone number.
