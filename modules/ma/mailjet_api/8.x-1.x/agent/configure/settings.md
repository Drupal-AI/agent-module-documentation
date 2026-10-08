# Configure Mailjet API

Settings live in the `mailjet_api.settings` config object. Edit them at
`/admin/config/services/mailjetapi/settings` (route `mailjet_api.admin_settings_form`, permission
`administer mailjet api`). All keys are also present in `config/schema/mailjet_api.schema.yml`
(`type: config_object`).

## Config keys

| Key | Type | Default | Effect |
|-----|------|---------|--------|
| `api_key_public` | string | `''` | Mailjet public API key. **Required** by the form. |
| `api_key_secret` | string | `''` | Mailjet secret API key. **Required** by the form. |
| `debug_mode` | bool | `false` | Log every send / queue action to the `mailjet_api` channel (incl. the Mailjet response data). |
| `sandbox_mode` | bool | `false` | Adds `SandboxMode: true` to the payload — Mailjet validates but does not deliver. |
| `use_queue` | bool | `false` | Queue messages to `mailjet_api_cron_worker` and send them on cron instead of immediately. |
| `format_filter` | string | `''` | Text format id run over the body (via `check_markup`) when the Mailjet mailer formats the mail. Empty = `Xss::filter` with a small tag allowlist. |
| `use_theme` | bool | `false` | Render the body through the `mailjet` theme hook (see theme/email-template.md). |
| `embed_image` | bool | `false` | Inline `<img src>` local files as base64 data URIs during format. |
| `custom_campaign` | bool | `false` | Honor `params['CustomCampaign']` → Mailjet `CustomCampaign`. |
| `deduplicate_campaign` | bool | `false` | With a custom campaign, honor `params['DeduplicateCampaign']` → `DeduplicateCampaign`. |
| `mailjet_templates` | bool | `false` | Honor `params['TemplateId']` → send a Mailjet stored template (`TemplateID` + `TemplateLanguage`); the body is then ignored. |
| `template_error` | bool | `false` | Enable Mailjet template error reporting. |
| `template_error_email` | string | `''` | Address that template errors are reported to (with `template_error`). |

Note: `format_filter`, `use_theme` and `embed_image` only take effect when the **Mailjet API
mailer** is selected as the *formatter* in Mail System — they run in the plugin's `format()`.

## Set via Drush / PHP

```bash
drush config:set mailjet_api.settings api_key_public PUBLIC_KEY -y
drush config:set mailjet_api.settings api_key_secret SECRET_KEY -y
drush config:set mailjet_api.settings use_queue true -y
```

```php
\Drupal::configFactory()->getEditable('mailjet_api.settings')
  ->set('api_key_public', 'PUBLIC_KEY')
  ->set('api_key_secret', 'SECRET_KEY')
  ->set('sandbox_mode', TRUE)
  ->save();
```

Validation: `MailjetApiAdminSettingsForm::validateForm()` calls
`MailjetApiHandler::validateKey()`, which performs a live Mailjet API call (the `Apikey`
resource). The form **rejects the save** if the keys cannot connect, so the credentials must be
valid and Mailjet reachable at save time.

## Wire up mail delivery (Mail System)

This module only registers the mailer; it does not switch Drupal's mail system on its own. At
`/admin/config/system/mailsystem` (Mail System module), set the **formatter** and/or **sender** to
`Mailjet API mailer` (plugin `mailjet_api_mail`), either site-wide or per module/key. Pick the
Mailjet mailer as the *formatter* too if you rely on `use_theme` / `embed_image` / `format_filter`.

## Test the integration

`/admin/config/services/mailjetapi/settings/test` (route `mailjet_api.test_email_form`) sends a
test message. Two modes: **Mailjet** (calls the handler directly) or **Mail Manager** (routes
through `plugin.manager.mail`, exercising the Mail System wiring). Optional attachment
(`core/misc/druplicon.png`), plus reply-to / CC / BCC fields.
