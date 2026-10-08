<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure APNs PHP

Route `/admin/config/system/apns_php` (`administer site configuration`). Config object `apns_php.settings`.

Fields:
- `app_bundle_id` — e.g. `com.example.app`.
- `team_id` — Apple Developer team ID.
- `key_id` — Apple Developer key ID for the certificate.
- `certificate_path` — path to the token/cert file. **Must be outside the Drupal webroot.** Accepts absolute (`/etc/apns/key.p8`), relative (`../apns/key.p8`), or stream wrapper (`private://apns/key.p8`). Validated to exist and be readable.
- `certificate_secret` — optional passphrase. Stored in plaintext config; leave the password field blank to keep the currently saved value. **Note:** because it lands in config, config exports contain it — treat exports as sensitive.
- `production` — checked = production APNs, unchecked = sandbox.
- `logging_level` — verbosity of Drupal logging.
- `log_token_validation_result` — log token validations to the database.
- `notification_url_key` — custom payload key carrying the deep-link URL (default `url`; e.g. `link` for FCM, `deeplink`). Cannot be `aps` (reserved).

Testing: `/admin/config/system/apns_php/test` sends a test notification through `ApnsPhpMessagingService`.

Programmatic use: inject `ApnsPhpMessagingService` to send notifications; it builds the pushok client from the config above and raises typed `ApnsPhp*Exception`s on failure.
