<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# APNs PHP (apns_php) — agent index

**Provides edamov/pushok as a Drupal service for sending Apple Push Notifications, with settings and test-send forms.**

- **Version:** 1.0.x (1.0.0-beta1)  •  **Core:** ^10.4 || ^11.1
- **Routes:** `apns_php.config` `/admin/config/system/apns_php` (`administer site configuration`); `apns_php.send_test_message_form` `/admin/config/system/apns_php/test` (`administer site configuration`).
- **Services:** `ApnsPhpMessagingService`, `ApnsPhpMessagingApi`.  **Config:** `apns_php.settings`.
- **Settings:** key_id, team_id, app_bundle_id, certificate_path, certificate_secret, production, logging_level, notification_url_key.

**Security:** both routes gated by `administer site configuration`; no anonymous/mutating public endpoints. Observations: the certificate **passphrase** (`certificate_secret`) is stored in **plaintext config** (`config/schema/apns_php.schema.yml`, string; set in `ApnsPhpConfigurationForm::submitForm`). The `.p8`/`.pem` key itself is stored on disk by path — the form warns it must be outside the webroot. See [configure/settings.md](configure/settings.md).
