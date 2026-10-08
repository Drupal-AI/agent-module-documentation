<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zammad Webform Handler (zammad_webform_handler) — agent index

**A Webform handler that posts submissions to a Zammad help-desk as tickets, creating the customer user when needed.**

- **Version:** 1.0.x (1.0.0-beta10)
- **Core:** ^10.5 || ^11
- **Dependencies:** webform:webform; composer requires `zammad/zammad-api-client-php:^2`
- **Handler:** `@WebformHandler` id `zammad` (`ZammadWebformHandler`), fires on `postSave`
- **Configure:** `zammad_webform_handler.settings_form` — `/admin/config/system/zammad-webform-handler` (perm `administer zammad_webform_handler configuration`, restrict access)
- **Settings:** `zammad_url`, `http_token_secret`, `timeout`, `verify` (SSL toggle), `authentication_method`

**Security:** Outbound-only — no inbound webhook/callback route; the sole route is the admin settings form behind a restrict-access permission. Report items: (1) Zammad HTTP token stored as plaintext config (`http_token_secret`, `Form/SettingsForm.php:100`), not a Key entity; (2) TLS verification is a user-toggleable checkbox — `Client(['verify' => config('verify')])` at `ZammadWebformHandler.php:729,813` lets an admin disable cert verification (falsy when unset). No inbound trust boundary.

See [configure/settings.md](configure/settings.md).
