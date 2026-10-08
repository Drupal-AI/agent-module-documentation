# Brevo — agent index

Integrates Drupal with the **Brevo** (ex-Sendinblue) CRM/email platform via the `getbrevo/brevo-php` SDK.
Base module = API-key settings + a factory of typed API clients + contact helpers + a Webform transactional
handler + a cron contact queue. Config UI at `/admin/config/services/brevo/settings`
(`configure: brevo.admin_settings_form`, permission `administer brevo`). Two submodules add mail delivery
and Commerce list opt-in. No Drush.

- **Settings form, `brevo.settings` keys, API-key/settings.php override, Marketing Automation, permission** →
  [configure/settings.md](configure/settings.md)
- **Services: `BrevoFactory` (all SDK clients), `BrevoHandler`, `ContactsApiClientHelper`; Webform handler; queue worker** →
  [api/services.md](api/services.md)

Submodules (own docs):
- `brevo_mailer` (routes Drupal mail through Brevo) → [../../modules/brevo_mailer/1.0.x/agent/start.md](../../modules/brevo_mailer/1.0.x/agent/start.md)
- `brevo_commerce` (checkout list opt-in pane) → [../../modules/brevo_commerce/1.0.x/agent/start.md](../../modules/brevo_commerce/1.0.x/agent/start.md)

Key facts:
- Config `brevo.settings`: `api_key`, `activate_marketing_automation`, `client_key`.
- `brevo.brevo_client_factory` (`BrevoFactory`) builds any SDK API client with the key + core `http_client`.
- Marketing Automation ON → loads `cdn.brevo.com/js/sdk-loader.js` with the public `client_key` on non-admin
  pages (`brevo_page_attachments_alter`).
- Requires external libs `getbrevo/brevo-php`, `nyholm/psr7`, `html2text/html2text`.
