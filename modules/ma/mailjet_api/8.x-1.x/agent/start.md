<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mailjet_api — agent index

Routes Drupal outbound email through **Mailjet's Send API v3.1** using the official
`mailjet/mailjet-apiv3-php` SDK. Registers a Mail plugin (`mailjet_api_mail`) that you wire up
via the Mail System module; it maps a Drupal message array to the Mailjet v3.1 payload and POSTs
it. Optional behaviours: queue-and-send on cron, embed images as base64, run the body through a
text format or a mail theme, use Mailjet stored templates, tag custom campaigns, and sandbox mode.

- Depends on `mailsystem:mailsystem`. Composer also pulls `mailjet/mailjet-apiv3-php ^1.5.0` and
  `html2text/html2text ~4.0.1`. Needs a Mailjet account with a public + secret API key.
- Configure route: `mailjet_api.admin_settings_form` → `/admin/config/services/mailjetapi/settings`.
- Defines 1 permission, 1 config object, a Mail plugin, a QueueWorker, 2 events and a mail theme
  hook. No Drush commands, no plugin types of its own.

## Solution docs
- **Set API keys / options and wire up mail delivery** → [configure/settings.md](configure/settings.md)
- **Send mail programmatically; message params the handler honors** → [api/handler.md](api/handler.md)
- **Alter the message before / after build (events)** → [events/message-events.md](events/message-events.md)
- **Override the HTML email template / mail theme** → [theme/email-template.md](theme/email-template.md)
- **The permission** → [permissions/permissions.md](permissions/permissions.md)

## Key facts
- Config object: `mailjet_api.settings` — keys: `api_key_public`, `api_key_secret`, `debug_mode`,
  `sandbox_mode`, `use_queue`, `format_filter`, `use_theme`, `embed_image`, `custom_campaign`,
  `deduplicate_campaign`, `mailjet_templates`, `template_error`, `template_error_email`.
- Service: `mailjet_api.mail_handler` → `Drupal\mailjet_api\MailjetApiHandler`. Logger channel `mailjet_api`.
- Mail plugin id: `mailjet_api_mail` (label "Mailjet API mailer"), class `MailjetApiMail`.
- QueueWorker id: `mailjet_api_cron_worker` (cron time 10).
- Routes: `mailjet_api.admin_settings_form`, `mailjet_api.test_email_form` (both require `administer mailjet api`).
- Permission: `administer mailjet api`.
- Events: `mailjet_api.message_pre_build`, `mailjet_api.message_post_build` (constants on `MailjetApiEvents`).
- Theme hook: `mailjet` (template `mailjet.html.twig`). hook_mail key: `test_form_email`.
