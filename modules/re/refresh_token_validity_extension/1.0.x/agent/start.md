<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OAuth refresh token validity extension (refresh_token_validity_extension) — agent index

**A monthly Ultimate Cron job that re-mints the Azure OAuth2 refresh token used by PHPMailer OAuth2 SMTP so it never lapses past Azure's 90-day expiry.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends on:** `ultimate_cron`, `phpmailer_oauth2`
- **Callback:** `refresh_token_validity_extension_oauth()` — Ultimate Cron job `refresh_token_validity_extension_cron`, schedule `0 12 1 * *`
- **Routes / permissions:** none
- **Security:** no routes or endpoints; a cron-only callback that exchanges the stored refresh token via `phpmailer_oauth2.azure_provider` and writes the new token into `phpmailer_oauth2.settings` config; the token value is not written to the log (only a success/failure message).