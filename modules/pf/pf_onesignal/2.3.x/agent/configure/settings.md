<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Push Framework OneSignal

Route: `onesignal.settings` → `/admin/config/system/push_framework/onesignal` (perm `administer site configuration`).
Config: `pf_onesignal.settings` — `appid` (OneSignal App ID) and `authkey` (OneSignal REST API key, sent as `Authorization: Basic <authkey>`).

Setup steps:
1. Enable the module (requires `push_framework`).
2. Enter the OneSignal App ID and REST API auth key on the settings form.
3. In your mobile app, use the OneSignal SDK and POST the device payload (JSON with `oneSignalUserId`, plus optional `appVersion`, `os`, `osVersion`, `language`, `platform`, `model`) to `/onesignal/register` as an authenticated user.
4. Enable/activate the OneSignal channel within Push Framework so `OneSignal::send()` is used for delivery.

Delivery (`OneSignal::send()`):
- Loads the target user's active `onesignal_device` player-ids (`status = 1`).
- Builds a payload with `app_id`, `include_player_ids`, per-language `headings`/`contents` (English fallback enforced), and `data.targetUrl` = the entity's absolute HTTPS canonical URL.
- POSTs to `https://onesignal.com/api/v1/notifications`; HTTP 200 = success, otherwise retry up to `MAX_ATTEMPTS` (3).

Secrets: the REST auth key lives in config. To avoid committing it, override `pf_onesignal.settings:authkey` from `settings.php` (config overrides) or a secrets/key mechanism, per the project's secret-handling guidance.