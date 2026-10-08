<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Postoffice Simplenews provides a Drupal mail-system plugin (`postoffice_simplenews_mail`) that renders and delivers Simplenews newsletter emails through the Postoffice module and Symfony Mailer instead of Drupal's legacy mail formatting.
---
Simplenews formats newsletter, confirmation and subscription-settings emails with the classic Drupal mail pipeline. This module bridges Simplenews to Postoffice so those messages are built as Symfony `RawMessage`/`Email` objects and sent with Symfony Mailer, giving themed HTML/plain-text output and modern transports.

The plugin `SimplenewsMail` (a `postoffice_compat` `CompatMailBase`) maps each Simplenews mail key to a dedicated email builder: `simplenews_test` / `simplenews_node` / `simplenews_extra` -> `IssueEmail`, `simplenews_subscribe_combined` -> `ConfirmEmail`, and `simplenews_validate` -> `SubscriptionSettingsEmail`; any other key throws an `InvalidArgumentException`. Each builder renders one of three Twig templates (`postoffice-simplenews-issue-email`, `-confirm-email`, `-subscription-settings-email`), and `hook_theme_suggestions` add per-newsletter and per-langcode template overrides.

Setup is developer-oriented and code/Drush driven: after enabling Postoffice, `postoffice_compat` and Simplenews, point the Simplenews mail interface at this plugin. There are no routes, permissions, forms or configuration schema; access control is entirely inherited from Simplenews and Postoffice.
---
- Route Simplenews newsletter mail through Symfony Mailer via Postoffice.
- Set `postoffice_simplenews_mail` as the Simplenews mail interface with Drush.
- Send themed HTML newsletter issues (`simplenews_node`).
- Send test newsletter issues (`simplenews_test`).
- Send extra/one-off Simplenews issue mails (`simplenews_extra`).
- Deliver double-opt-in subscription confirmation emails (`simplenews_subscribe_combined`).
- Deliver subscription-settings / validation emails (`simplenews_validate`).
- Override the issue email markup via `postoffice-simplenews-issue-email.html.twig`.
- Override confirmation email markup via the confirm-email template.
- Override subscription-settings email markup via its template.
- Provide a per-newsletter template suggestion (`__{newsletter_id}`).
- Provide a per-language template suggestion (`__{langcode}`).
- Combine per-newsletter and per-language template suggestions.
- Use Symfony Mailer transports (SMTP, sendmail, API) for newsletters.
- Keep Simplenews access/subscription logic unchanged while modernising delivery.
- Theme newsletter emails using a test theme as a reference implementation.
- Migrate a site off legacy Drupal mail formatting for newsletters only.
- Debug which Simplenews mail key maps to which email builder.
- Confirm delivery of newsletters as proper multipart Symfony messages.
