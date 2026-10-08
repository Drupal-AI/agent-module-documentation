<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Stackla Widget

Settings form `stackla_widget.stackla_settings_form` → `/admin/config/services/stackla_widget/settings` (perm `administer stackla`). Config object `stackla_widget.settings`:
- `stack_name` — Stackla stack shortname (required).
- `client_id`, `client_secret` — OAuth2 credentials (required; secret shown in a plain textfield, stored in config).
- `refresh_interval` — seconds; `-1` means run every cron.
- `proxy_status` / `proxy_url` — optional outbound proxy. **Enabling the proxy disables TLS certificate verification** in the SDK (`src/Api/Request.php:105`, `'verify' => FALSE`).
- `debug_mode` — verbose logging. **Leave OFF in production**: the OAuth callback logs `client_id`, `client_secret`, access code and callback in cleartext (`StacklaController.php` ~L536).

## OAuth2 authorize flow
1. Copy the read-only **Callback URL** (`stackla_widget.stackla_oauth`) into the Stackla plugin config.
2. Paste the Stackla-provided `client_id`/`client_secret` into the form.
3. Click **Authorize** → redirected to Stackla → Stackla calls back with `?code=…`.
4. `StacklaController::stacklaOauth` exchanges the code via `Credentials::generateToken` and stores the token in State.
5. **Revoke** / **Reauthorize** buttons manage the stored token.
