<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stackla Widget (stackla_widget) — agent index
**Connects Drupal to the Stackla UGC service (OAuth2) and embeds Stackla widgets via a field type/widget/formatter.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 · **Package:** Stackla
- **Config route:** `stackla_widget.stackla_settings_form` → `/admin/config/services/stackla_widget/settings` (perm `administer stackla`)
- **OAuth callback:** `stackla_widget.stackla_oauth` → `/admin/config/services/stackla_widget/oauth` (perm `use stackla`)
- **Permissions:** `administer stackla`, `use stackla`
- **Service:** `stackla_widget.stackla_service` (StacklaService) · SDK under `src/Api` (Guzzle)
- **Field plugins:** StacklaWidgetField / StacklaWidget / StacklaWidgetFormatter

**Security:** Config and OAuth callback routes are permission-gated (no anonymous endpoints). BUT the SDK sets `'verify' => FALSE` — disabled TLS verification — whenever the proxy is enabled (`src/Api/Request.php:105`), exposing the OAuth `client_secret`/token exchange to MITM; and `debug_mode` logs `client_id`/`client_secret`/auth code in cleartext (`StacklaController.php` ~L536). Client secret stored in plain config.

See [configure/settings.md](configure/settings.md) and [api/sdk.md](api/sdk.md)
