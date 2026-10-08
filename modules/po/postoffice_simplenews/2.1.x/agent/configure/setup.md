<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Postoffice Simplenews — setup

Zero UI. Enable the dependencies and switch the Simplenews mail interface.

```bash
drush en postoffice postoffice_compat simplenews postoffice_simplenews -y
# Route Simplenews mail through this plugin:
drush config:set system.mail interface.simplenews postoffice_simplenews_mail
```

`system.mail` then contains:
```yaml
interface:
  simplenews: postoffice_simplenews_mail
```

## Mail-key handling (src/Plugin/Mail/SimplenewsMail.php)
`emailFromMessage()` switches on `$message['id']`:
- `simplenews_test`, `simplenews_node`, `simplenews_extra` -> `IssueEmail::createFromMessage()`
- `simplenews_subscribe_combined` -> `ConfirmEmail::createFromMessage()`
- `simplenews_validate` -> `SubscriptionSettingsEmail::createFromMessage()`
- anything else -> throws `\InvalidArgumentException`.

## Theming
Copy the module's `templates/*.html.twig` into your theme to override output. Suggestions available:
- issue: `postoffice_simplenews_issue_email__{langcode}`, `__{newsletter_id}`, `__{newsletter_id}__{langcode}`
- confirm / validate: `..._email__{langcode}`.

Transport (SMTP etc.) is configured in Postoffice / Symfony Mailer, not here.
