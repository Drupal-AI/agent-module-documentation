<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Postoffice Simplenews (postoffice_simplenews) — agent index

**Sends Simplenews newsletter, confirmation and subscription emails through Symfony Mailer via the Postoffice module.**

- **Version:** 2.1.x (release 2.1.0)
- **Core:** ^10.2 || ^11
- **Requires:** postoffice, postoffice_compat, simplenews
- **Mail plugin id:** `postoffice_simplenews_mail` (`src/Plugin/Mail/SimplenewsMail.php`)
- **Mail-key routing:** `simplenews_test|_node|_extra`->IssueEmail, `simplenews_subscribe_combined`->ConfirmEmail, `simplenews_validate`->SubscriptionSettingsEmail
- **Templates:** `postoffice-simplenews-issue-email`, `-confirm-email`, `-subscription-settings-email` (+ per-newsletter/langcode suggestions via `hook_theme_suggestions`)
- **Enable delivery:** `drush config:set system.mail interface.simplenews postoffice_simplenews_mail`
- **Security:** No routes, forms, permissions or config schema; a mail backend plugin only. Access is inherited from Simplenews/Postoffice; unknown mail keys throw `InvalidArgumentException` rather than sending.

See [configure/setup.md](configure/setup.md).
