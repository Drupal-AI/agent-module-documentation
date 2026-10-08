<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron Fail Alert — configuration & mechanism

## Install & enable

```bash
composer require drupal/cron_fail_alert
drush en cron_fail_alert -y
```

Core-only (`drupal/core: ^10.3 || ^11`). No other module dependencies, no submodules, no Drush
commands, no libraries.

## Settings form

- Route `cron_fail_alert.settings_form` → **`/admin/config/system/cron-fail-alert`**
  (the module also adds a menu link under *Configuration → System → Cron* and local task tabs).
- Permission: **`administer cron-fail-alert configuration`** (defined in
  `cron_fail_alert.permissions.yml`).
- Form: `Drupal\cron_fail_alert\Form\SettingsForm` (`ConfigFormBase`), form id `cron_fail_alert_settings`,
  editing config object **`cron_fail_alert.settings`**. Fields use `#config_target` so they map
  straight to config keys.

Two sections:

**Monitoring settings**
- `frequency` — number, required, `#min 1 #max 1440`, suffix "minutes". How often the check may run.
- `tolerance` — number, required, `#min 1 #max 10080` (1 week), suffix "minutes". Max age of the last
  cron run before it counts as failed.

**Email notification settings**
- `to` — email, required. Recipient. Description notes it defaults to the site's default email; the
  form pre-fills the description with `system.site:mail`.
- `subject` — textfield, required, `#maxlength 255`. Site name is appended when the mail is sent.
- `message` — textarea, required, 5 rows. Body template; supports tokens `@minutes` and `:site`.

`validateForm()` enforces two rules:
- `to` must pass `email.validator` (`EmailValidatorInterface`), else error on `to`.
- `tolerance` must be **strictly greater than** `frequency` ("must be greater than the check
  frequency to avoid false positives"), else error on `tolerance`.

## Config object `cron_fail_alert.settings`

Schema (`config/schema/cron_fail_alert.schema.yml`, type `config_object`):

| Key | Type | Install default (`config/install/`) | Meaning |
|---|---|---|---|
| `frequency` | integer | `15` | Minutes between checks (throttle). |
| `tolerance` | integer | `20` | Minutes since last cron before "failed". |
| `to` | email | `''` | Recipient; empty → falls back to `system.site:mail`. |
| `subject` | string | `URGENT: Drupal cron has failed, please investigate` | Subject template. |
| `message` | text | `The scheduled cron has not been running as expected for the last @minutes minutes, and we need someone to investigate the issue as soon as possible at :site` | Body template. |
| `langcode` | string | `en` | Language code (backfilled by post-update). |

Post-update `cron_fail_alert_post_update_add_langcode()` (`cron_fail_alert.post_update.php`) adds
`langcode` from the default language if missing.

### Config export example

```yaml
# cron_fail_alert.settings
langcode: en
frequency: 15
tolerance: 20
to: 'ops@example.com'
subject: 'URGENT: Drupal cron has failed, please investigate'
message: 'The scheduled cron has not been running as expected for the last @minutes minutes, and we need someone to investigate the issue as soon as possible at :site'
```

## How the check runs (subscriber)

`CronFailAlertSubscriber` (service `cron_fail_alert.event_subscriber`) subscribes to
`KernelEvents::RESPONSE` → `onKernelResponse()`. The check is deliberately driven by ordinary page
responses, not by cron, since a failed cron cannot run its own alert.

1. Read state `cron_fail_alert.last_check_timestamp` (default 0). If
   `(time() - last)/60 < frequency`, return — this throttles the check to once per `frequency` minutes
   and keeps per-request overhead near zero.
2. Otherwise call `checkCronStatus()`, then always write `time()` back to
   `cron_fail_alert.last_check_timestamp` (so a failing state does not re-send on every request).

`checkCronStatus()`:
- `minutesAgo = (time() - state('system.cron_last')) / 60`.
- If `minutesAgo < tolerance` → return FALSE (healthy).
- Else assemble the mail:
  - recipient = config `to` `??` `system.site:mail`;
  - subject = `TranslatableMarkup('@subject on Site: @site_name', …)` from config `subject` + site name;
  - body = `FormattableMarkup(config message, ['@minutes' => floor($minutesAgo), ':site' => request->getSchemeAndHttpHost()])`;
  - `sendCronFailAlertEmail()` → `mailManager->mail('cron_fail_alert', 'cron_fail_alert_mail', $to, <default langcode>, $params)`.
- Logs to the `cron_fail_alert` channel: `notice` on success, `error` ("Failed to send email
  notification to @email") when the mail result is falsy.

## Mail assembly (`hook_mail`)

`CronFailAlertHooks::mail()` (`src/Hook/CronFailAlertHooks.php`, `#[Hook('mail')]`), invoked via the
`#[LegacyHook]` shim `cron_fail_alert_mail()` in `cron_fail_alert.module`. For key
`cron_fail_alert_mail` it sets `$message['from']` to `system.site:mail`, `$message['subject']` to the
passed title, and appends `MailFormatHelper::wrapMail($params['message'])` to the body.

## Operating notes

- Because the check rides on HTTP responses, a site with no traffic during an outage window may not
  send the alert until the next request arrives; sites relying on visitor-triggered core cron are the
  intended fit.
- Tokens are literal: use `@minutes` and `:site` exactly (these are `FormattableMarkup` placeholders,
  not Drupal Token module tokens).
- Set `tolerance` above your actual cron interval (e.g. cron every 15 min → tolerance ≥ 20) to avoid
  false positives; the form will refuse `tolerance <= frequency`.
