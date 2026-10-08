# SpamAway — agent index

Anti-spam for **Webform**. Ships one Webform handler plugin, `spamaway_anti_spam_forms`,
that rejects submissions failing an IP-frequency check and/or a similarity check. No global
config page (`configure: null`) — you configure it per webform on the handler. Requires the
`webform` module.

- **Add the handler to a webform, all handler settings/keys, where config is stored, drush/PHP** →
  [plugins/anti-spam-handler.md](plugins/anti-spam-handler.md)
- **Bypassing checks (permission + settings.php) and the one permission** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Handler plugin id: `spamaway_anti_spam_forms` (label "SpamAway - Anti spam handler", category "Anti-SPAM").
- Handler settings are stored in the webform config entity under
  `webform.webform.<id>` → `handlers.<handler_id>.settings`.
- Two checks: IP frequency (`spamaway_ip_check_enabled`, `spamaway_anti_spam_ip_period`,
  `spamaway_anti_spam_allowed_ip_count`) and similarity (`spamaway_anti_spam_field_names`,
  `spamaway_anti_spam_threshold_percentage`, `spamaway_anti_spam_allowed_count`).
- Bypass: permission `spamaway bypass spam detection` or `$settings['spamaway_bypass_anti_spam'] = TRUE`.
- Custom table `spamaway_webform_submission` stores hashed field values / IPs for forms that don't save results.
