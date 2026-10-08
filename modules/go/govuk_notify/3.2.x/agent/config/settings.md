<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form, config object, service selection

## Install & enable

```bash
composer require drupal/govuk_notify   # pulls alphagov/notifications-php-client ^7.0.0 + php-http/guzzle7-adapter
drush en govuk_notify -y
```

You need a Notify account, an **API key**, and (usually) a **"default" template**. For the UK
service: create the account at notifications.service.gov.uk, make an API key on *API Integration*,
and create an email template whose subject is `((subject))` and body is `((message))`, plus an SMS
template whose body is `((message))`. Note the template IDs.

`hook_install()` (`govuk_notify.install`) adds `govuk_notify => govuk_notify_mail` to
`system.mail`'s `interface` map (registering the plugin as an available mailer, not yet the
default). `hook_uninstall()` removes it.

## Settings form & route

- Route `govuk_notify.admin_settings_form` → path **`/admin/config/system/govuk_notify`**,
  `_form: GovUKNotifyAdminForm`, requirement **`_permission: 'administrator gov uk notify'`**,
  `_admin_route: TRUE`. Menu link "Gov Notify" under *system.admin_config_system*.
- Form class `Drupal\govuk_notify\Form\GovUKNotifyAdminForm` extends `ConfigFormBase`; form id
  `govuk_notify_form`; editable config `govuk_notify.settings`. Injects `plugin.manager.mail`
  and `current_user` (for sending the test messages).

## Config object `govuk_notify.settings`

Written by `submitForm()`. No `config/install` default and **no `config/schema`** ship, so the
object is created on first save and strict schema tooling has nothing to validate against.

| Key | Widget | Meaning |
|---|---|---|
| `notification_service` | select `uk` / `ca` / `au` | Which Government Notify endpoint the service targets. |
| `api_key` | textfield | The Notify API key passed as `apiKey` to the client. |
| `default_template_id` | textfield | Notify template id used for **email** when the message sets none. Should contain `((subject))` + `((message))`. |
| `default_sms_template_id` | textfield | Notify template id used for **SMS** when none is set. Should contain `((message))`. |
| `force_temporary_failure` | checkbox | Test-key only: reroute mail to `temp-fail@simulator.notify` (see mail plugin). |
| `force_permanent_failure` | checkbox | Test-key only flag (stored; permanent-failure rerouting is a `@todo`, not yet implemented). |

The form also shows two **non-persisted** helper fields:

- `send_system_emails` (checkbox) — not stored in `govuk_notify.settings`. Its default is derived
  from whether `system.mail` `interface.default == 'govuk_notify_mail'`. On submit, if ticked it
  sets `system.mail` `interface.default = govuk_notify_mail`; if unticked **and** the default was
  previously `govuk_notify_mail` it resets it to `php_mail`. This is how "send all system emails
  via Notify" is toggled.
- `govuk_notify_email_test` / `govuk_notify_sms_test` — transient. If filled, `submitForm()` sends
  a live test through `mailManager->mail('govuk_notify', NULL, $to, $langcode, $params)` and shows a
  success/error message. Not saved to config.

On save, `submitForm()` also invalidates cache tag
`govuk_notify_template:{default_template_id}` so a changed default template is re-fetched.

## Which endpoint is used

`GovUKNotifyService::__construct()` reads `notification_service` (defaulting to `uk` when empty)
and picks the base URL:

- `au` → `https://rest-api.notify.gov.au`
- `ca` → `https://api.notification.alpha.canada.ca`
- default/`uk` → `https://api.notifications.service.gov.uk`

The client is `new Alphagov\Notifications\Client(['baseUrl' => $url, 'apiKey' => $config->get('api_key'),
'httpClient' => new Http\Adapter\Guzzle7\Client()])`, built inside a try/catch that logs a warning
via `govuk_notify.logger_channel` on failure and leaves `notifyClient` NULL (send methods then
no-op and return FALSE).

## Permission

`administrator gov uk notify` (title "Administrator Gov Notify") — the only permission; gates the
settings form. Grant to trusted admins only (the API key is shown in the form).

## Config export example

```yaml
# govuk_notify.settings
notification_service: uk
api_key: ''            # set via the form / a secrets workflow, not committed
default_template_id: 00000000-0000-0000-0000-000000000000
default_sms_template_id: 00000000-0000-0000-0000-000000000000
force_temporary_failure: false
force_permanent_failure: false
```
