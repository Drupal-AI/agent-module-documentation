Send Drupal emails and SMS messages through a Government Notify service (Gov.UK Notify, Government of Canada Notification, or Australian Government Notify) by registering a Notify-backed mail plugin.

---

GOV Notify Integration wraps the official `alphagov/notifications-php-client` in a Drupal service and a core Mail plugin (`govuk_notify_mail`). Once configured with an API key and template IDs on `/admin/config/system/govuk_notify`, any Drupal mail — system emails or programmatic `MailManager::mail()` calls — can be delivered via Notify. Recipients that validate as email addresses are sent as emails; anything else is treated as a phone number and sent as an SMS. You can either let Drupal render the body and pass it into a Notify "default" template (one `((subject))` and one `((message))` placeholder), or target a specific Notify template and supply its personalisation params directly. Template metadata is fetched from the API and cached. The service also supports the Canadian and Australian Notify endpoints, test-key "force temporary/permanent failure" simulation, and a companion `govuk_notify_views_backend` submodule that surfaces the Notify message log as a Views base table for dashboards.

---

- Route all Drupal system emails (password resets, contact form, user registration) through Gov.UK Notify by ticking "Use Gov Notify to send system emails".
- Send transactional emails to citizens from a public-sector Drupal site using an approved Notify account.
- Send SMS text notifications to a phone number captured in a form or field.
- Send both email and SMS from the same code path — the mail plugin auto-detects which based on whether the recipient is a valid email address.
- Use a Drupal-rendered message body inside a Notify "default" template so you keep Drupal's templating engine.
- Use a specific, Notify-designed template by passing its `template_id` and personalisation `params` in the message array.
- Send a programmatic email: `\Drupal::service('plugin.manager.mail')->mail('govuk_notify', $key, $to, $langcode, $params)`.
- Call the Notify service directly from custom code via `\Drupal::service('govuk_notify.notify_service')->sendEmail($to, $template_id, $params)`.
- Send an SMS directly via `->sendSms($to, $template_id, $params)` with template placeholders in `params`.
- Test the configured API key by entering a test email address on the settings form and saving (sends a live test email).
- Test SMS delivery by entering a test phone number on the settings form and saving.
- Point the same module at the Government of Canada Notification service by selecting the "ca" service option.
- Point the module at the Australian Government Notify service by selecting the "au" service option.
- Simulate temporary or permanent delivery failures against a Notify test key to exercise your error handling.
- Fetch a template's metadata (subject/body/placeholders) with the service's cached `getTemplate($template_id)`.
- Build a delivery-status dashboard by enabling `govuk_notify_views_backend` and creating a View on the "GovUK Notification Message Log" base table.
- Filter that message-log View by message type (email/sms/letter), delivery status, or message id/reference.
- Display Notify message fields — id, type, created/updated/sent timestamps, status, created_by, body, subject — as View columns.
- Support multiple Government Notify jurisdictions from one Drupal codebase by switching the service selector.
- Keep Notify template rendering server-side while still letting Drupal supply dynamic subject and body values.
- Provide staff a read-only audit view of what messages were sent and their current delivery state.
